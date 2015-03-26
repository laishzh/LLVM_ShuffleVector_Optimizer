#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Metadata.h"     // NEW
#include "llvm/Transforms/Utils/BasicBlockUtils.h"  // NEW
#include "llvm/IR/Function.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/IR/InstrTypes.h"   // NEW
#include "PatternName.h"

#define NCadd(x) number_check.push_back(x);
using namespace llvm;

class pattern_rec {
private:
    SmallVector<int, 16> sin_mask;
    SmallVector<int, 16> signature;
    unsigned len;
    unsigned opLen;
    bool isV2Splat;
    bool isV2Zero;
        //  sin_mask is the single-lane mask after lane detection
        //  signature is the indication of pattern derived from differentiation of sin_mask
    void pattern_diff(const SmallVector<int, 16>& P, int m, int k, SmallVector<int, 16>& vec) {
        for (int i = 0; i< m-k; i++)
            vec.push_back(P[i+k]-P[i]);
    }
    void number_count(const SmallVector<int, 16>& vec, int beg, int end, const SmallVector<int, 16>& value, SmallVector<int, 16>& result) {
        //  to count the number of elements equal to value[] from beg to end, and the result is also vector each bit i representing value[i]
        // this module is realized in an ineffient way, for each value scan the vec, this is to make sure that in the future we may have equal values in value[], this can also make the value of counting number flexible
        result.clear();
        for (unsigned j = 0; j < value.size(); j++)
         result.push_back(vec[beg] == value[j]);
     for (unsigned i = beg+1; i <= end; i++)
        for (unsigned j = 0; j < value.size(); j++)
            result[j] += (vec[i] == value[j]);
        return ;
    }
public:
    pattern_rec(const SmallVector<int, 16>& vec, unsigned ttl, bool b1, bool b2) {
        sin_mask = vec;
        signature.clear();
        signature.push_back(vec[0]);
        pattern_diff(vec, vec.size(), 1, signature);
        len = vec.size();/*# of elements in sin_mask*/
        opLen = ttl;
        isV2Splat = b1;
        isV2Zero = b2;
    }

    PatternName recognize(unsigned& eigenvalue) {
        // find the internal pattern of single-lane mask
	    // afterwards revision: add argv eighenvalue for replacement use.
	    //  in each pattern, eighenvalue serves as its extra information
        SmallVector<int, 16> number_check;
        NCadd(0) NCadd(1) NCadd(2) NCadd(opLen) NCadd(1-len) NCadd(-opLen)
            // num_check stores the candidate value to be checked

        SmallVector<int, 16> candidate;
        number_count(signature, 1, len-1, number_check, candidate);
        
        // check rotate pattern ( one lane)
        if ( ((candidate[1] == len-2)&&(candidate[4] == 1/*1-opLen??*/)&& (len == opLen) ) ){
            for(int i=1; i<signature.size(); i++){
              if (signature[i] == 1-opLen){
                eigenvalue = i;
                break;
              }
            }
            return Rotate;
        }
        // check rotate pattern ( multiple lanes)
        if ((candidate[1] == len-2) && (len < opLen)) {
          for(int i=1; i<signature.size(); i++){
            if (signature[i] == 1 - len){
              eigenvalue = i;
              return Rotate;
            }
          }
        }

        // check pack pattern
        if (candidate[2] == len-1)
            return Pack;

        // check shift right logical pattern
        if (((candidate[1] + candidate[0] == len-1) && (len == opLen))|| 
            ((candidate[1] + candidate[0] == len-2) && (len < opLen))) {
            bool succ = 1;
            for (int i=1; i<=candidate[1]; i++)
                succ &= (signature[i] == 1);
            if (candidate[1]+1 < opLen){
              if (len < opLen)
                succ &= (signature[candidate[1]+1] == opLen - len + 1); 
              else
                succ &= (signature[candidate[1]+1] == 0);
            }
            for (int i=candidate[1]+2; i<len; i++)
                succ &= (signature[i] == 0);

            if (succ && isV2Zero){      // Pay attention! now the grogress still needs V2 be zeroinitializer
                eigenvalue = signature[0];
                _DEBUG<<"# of LShr = "<< eigenvalue<<'\n';     
                return ShiftRightLogical;
            }
        }

        // check zeroExtention
        // bug: it seems that lane_detect cannot detect lanes for zeroExtention
        // note: len = 2^n * opLen (n = 0,1,2...)
        if (signature[0] == 0) {
          bool succ = true;
          for (int i = 1; i <= opLen; ++i)
          {
            if (signature[i] != 1) {
                succ = false;
                break;
            }
          }
          for (int i = opLen+1; i < len; ++i)
          {
            if (signature[i] != 0) {
              succ = false;
              break;
            }
          }
          if (succ) {
            return ZeroExtend;
          }
        }

        // check shift left pattern
        if (candidate[0] + candidate[1] + candidate[5] == len-1) {
            bool succ = 1;
            for (int i=1; i<=candidate[0]; i++)
                succ &= (signature[i] == 0);
            for (int i=candidate[0]+2; i<len; i++)
                succ &= (signature[i] == 1);
            if (succ && isV2Zero)
              eigenvalue = candidate[0]+1;
          return ShiftLeft;
      }

        // check merge pattern
      if (candidate[3] + candidate[4] == len-1) {
        bool succ = 1;
        for (int i=1; i<len; i++)
            if (i%2) {  // odd position
                succ &= (signature[i] == len);
            } else {    // even
                succ &= (signature[i] == 1-len);
            }
            if (succ)
                return Merge;
        }

        // check blend pattern
        {
            bool succ = 1;
            for (int i=0; i<len; i++)
                succ &= (sin_mask[i] % opLen == i);
            if (succ)
                return Blend;
        }

        

        // after all special cases checked
        return NoPattern;
    }
};

class instruction_rep {
private:
    ShuffleVectorInst * svi;
    SmallVector<int, 16> sin_mask;
    unsigned laneNum;
    PatternName typeId;
    unsigned eigenvalue;
    BitCastInst* bcInst2L;
    BitCastInst* bcInst2R;
    bool isRotate = false;

	// specific replacement functions
    bool replaceWithRotate() {

      isRotate = true;
      //
      Value * op1 = svi->getOperand(0);
      VectorType * v1Type = cast<VectorType>(op1->getType());
      VectorType * resType = cast<VectorType>(svi->getType());
      unsigned bitLen = v1Type->getBitWidth();
      unsigned opNum = v1Type->getNumElements();
      unsigned resLen = resType->getBitWidth();

      // Step 1:
      // %bcInstOriginal = bitcast <a x bi>%v1 to (a*b)i
      Type* intType = Type::getIntNTy(svi->getContext(), resLen);
      
      // Shl
      if (!replaceWithShiftLeft()){
        isRotate = false;
        return false;
      }

      // # of logical shift right
      eigenvalue = sin_mask.size() - eigenvalue;
      
      // LShr
      if(!replaceWithShiftRightLogical()) {
        isRotate = false;
        return false;
      }
     
      // Xor
      BinaryOperator* boInst1 = BinaryOperator::Create(BinaryOperator::Xor, (Value*)bcInst2L, (Value*)bcInst2R, "Xor", (Instruction*)svi);

      // delete the ShuffleVector result uses
      svi->replaceAllUsesWith((Value *)boInst1);
       isRotate = false;
      return true;

   }
   bool replaceWithShiftLeft() {
	// SUPPORT:
	//    unaligned vector by truncating
	//    last-lost mask: eg. 8012845, lost '6'
	    // NOTE: little-endian
	    // for example
	    //    ShuffleVector <4 x i8>%a, <4 x i8>initializer
	    //    with mask <4 x i32> <i32 5, i32 0, i32 1, i32 2>
	    // equals to
	    //    shl i32 %a, 8
	    // 8 is computed by offset(1) * ElementLength(i8 is 8)

    Value* op1 = svi->getOperand(0);
    VectorType* v1Type = cast<VectorType>(op1->getType());
    VectorType* resType = cast<VectorType>(svi->getType());
    unsigned bitLen = v1Type->getBitWidth();
    unsigned opNum = v1Type->getNumElements();
    unsigned resLen = resType->getBitWidth();
	if (laneNum == 1) {    // No lane handle
	    // Step 1:
	    // %bcInst1 = bitcast <a x bi>%v1 to (a*b)i
       Type* intType = Type::getIntNTy(svi->getContext(), resLen);
       BitCastInst* bcInst1 = new BitCastInst(op1, Type::getIntNTy(svi->getContext(), bitLen), "bitcast1", (Instruction *)svi);
	    // Step 1.5:
	    //   check if v1 and res mismatch, if so, truncate v1
	    // %trunc1 = trunc (a*b)i %bcInst1 to ($res_size)i
	    //
	    // Inconsistency NOTE:
	    //   others will be truncated at the end for a handy resType use !!!
       TruncInst * tcInst1 = nullptr;
            if (resLen < bitLen) {  // implies v1 longer than res, truncate it
                tcInst1 = new TruncInst(bcInst1, intType, "trunc1", (Instruction *)svi);
            }
	    // Step 2:
	    // %boInst1 = shl (a*b)i %bcInst1||%tcInst1, eigenvalue*b
            unsigned offsetValue = eigenvalue * bitLen / opNum;
            Constant* offset = ConstantInt::getSigned(intType, offsetValue);
            BinaryOperator* boInst1 = BinaryOperator::Create(BinaryOperator::Shl, (resLen<bitLen)?(Value*)tcInst1:(Value*)bcInst1, (Value*)offset, "shl1", (Instruction*)svi);
            
	    // Step 3:
	    // %bcInst2 = bitcast (a*b)i %boInst1 to <a x bi>
            bcInst2L = new BitCastInst((Value *)boInst1, (Type *)resType, "bitcast2L", (Instruction *)svi);
	    // Step 4:
	    // delete the ShuffleVector result uses
            if (!isRotate)
              svi->replaceAllUsesWith((Value *)bcInst2L);
	        //
	        // NOTE: below are noticable errors in programming.
	        //      when deleting, iterator in main function will be broken!!!
	        //
                // ReplaceInstWithInst(svi, bcInst2); // Choice 1
                // svi->removeFromParent();	      // Choice 2
                // svi->eraseFromParent();	      // Choice 3
	} else {            // multi-lane handle
	    // Step 1:
	    // %bcInst1 = <a x bi>%v1 to <lane * ...>
       unsigned sin_width = bitLen / laneNum;
       Type* intType = Type::getIntNTy(svi->getContext(), sin_width);
       VectorType* vecType = VectorType::get(intType, laneNum);
       BitCastInst* bcInst1 = new BitCastInst(op1, vecType, "bcInst1", (Instruction *)svi);
	    // Step 2:
	    // %boInst1 = shl <lane * ...> %bcInst1, eigenvalue*b
       unsigned offsetValue = eigenvalue * bitLen / opNum;
       Constant* offset = ConstantInt::getSigned(intType, offsetValue);
       Constant* offsetVec = ConstantVector::getSplat(laneNum, offset);
       BinaryOperator* boInst1 = BinaryOperator::Create(BinaryOperator::Shl, (Value*)bcInst1, (Value*)offsetVec, "shl1", (Instruction*) svi);
	    // Step 3.*:
	    //  check if v1,res type mismatch, if so, bitcast to bit, truncate and restore
       TruncInst* tcInst1 = nullptr;
       if (resLen < bitLen) {
		// Step 3.0:
		// %bcInst3 = bitcast <lane*...> %boInst1 to (a*b)i
		// %tcInst1 = trunc (a*b)i to (%res_size)i
          BitCastInst* bcInst3 = new BitCastInst((Value*)boInst1, Type::getIntNTy(svi->getContext(), bitLen), "bcInst3", (Instruction*)svi);
          tcInst1 = new TruncInst((Value*)bcInst3, Type::getIntNTy(svi->getContext(), resLen), "trunc1", (Instruction*)svi);
      }
            // Step 3:
            // %bcInst2 = bitcast <lane*...>%boInst1|<...i>%trunc1 to <a x bi>
      bcInst2L = new BitCastInst((resLen<bitLen)?(Value*)tcInst1:(Value*)boInst1, (Type*)resType, "bitcast2L", (Instruction*)svi);
	    // Step 4:
	    // delete the ShuffleVector result uses
      if (!isRotate)
        svi->replaceAllUsesWith((Value*)bcInst2L);
	}	// end of if (laneNum==1)
	return true;
}
bool replaceWithShiftRightLogical() {
    Value* op1 = svi->getOperand(0);
    VectorType* v1Type = cast<VectorType>(op1->getType());
    VectorType* resType = cast<VectorType>(svi->getType());
    unsigned bitLen = v1Type->getBitWidth();
    unsigned opNum = v1Type->getNumElements();
    unsigned resLen = resType->getBitWidth();
    if (laneNum == 1) {    // No lane handle
      // %bcInst1 = bitcast <a x bi>%v1 to (a*b)i
      Type* intType = Type::getIntNTy(svi->getContext(), resLen);
      BitCastInst* bcInst1 = new BitCastInst(op1, Type::getIntNTy(svi->getContext(), bitLen), "bitcast1", (Instruction *)svi);
      //logic shift right
      unsigned offsetValue = eigenvalue * bitLen / opNum;
            Constant* offset = ConstantInt::getSigned(intType, offsetValue);
      BinaryOperator* boInst1 = BinaryOperator::Create(BinaryOperator::LShr, (Value*)bcInst1, (Value*)offset, "LShr", (Instruction*)svi);
      //%bcInst2 = bitcast (a*b)i %boInst1 to <a x bi>
      bcInst2R = new BitCastInst((Value *)boInst1, (Type *)resType, "bitcast2R", (Instruction *)svi);
      if (!isRotate)  
        svi->replaceAllUsesWith((Value *)bcInst2R);
    }
    else{//multiple lanes
      //bit length of one lane
      unsigned sin_width = bitLen / laneNum;
      Type* intType = Type::getIntNTy(svi->getContext(), sin_width);
      
      //create vector contains every lane, each element is an intType type
      VectorType* vecType = VectorType::get(intType, laneNum);
      BitCastInst* bcInst1 = new BitCastInst(op1, vecType, "bcInst1", (Instruction *)svi);
      
      unsigned offsetValue = eigenvalue * bitLen / opNum;
      Constant* offset = ConstantInt::getSigned(intType, offsetValue);
      Constant* offsetVec = ConstantVector::getSplat(laneNum, offset);
      //replace instruction
      BinaryOperator* boInst1 = BinaryOperator::Create(BinaryOperator::LShr, (Value*)bcInst1, (Value*)offsetVec, "LShr", (Instruction*) svi);
      
      // bitcast to <a x bi>
      bcInst2R = new BitCastInst((Value*)boInst1, (Type*)resType, "bitcast2R", (Instruction*)svi);

      // replace result
      if (!isRotate)
        svi->replaceAllUsesWith((Value*)bcInst2R);
    }

    return true;
}
bool replaceWithZeroExtend() {
    Value* op1 = svi->getOperand(0);
    VectorType* v1Type = cast<VectorType>(op1->getType());
    VectorType* resType = cast<VectorType>(svi->getType());
    unsigned bitLen = v1Type->getBitWidth();
    unsigned opNum = v1Type->getNumElements();
    unsigned resLen = resType->getBitWidth();
    
    // laneNum = 1
    // replace shufflevector with zeroExtention
    
    // %bcInst1 = bitcast <a x bi>%v1 to (a*b)i
    Type* intType = Type::getIntNTy(svi->getContext(), resLen);// element int type in result vector
    BitCastInst* bcInst1 = new BitCastInst(op1, Type::getIntNTy(svi->getContext(), bitLen), "bitcast1", (Instruction *)svi);

    // try to replace 
    CastInst* testInst1 =  CastInst::CreateZExtOrBitCast((Value*)bcInst1, Type::getIntNTy(svi->getContext(), resLen), "res", (Instruction *)svi);

    BitCastInst* bcInst2 = new BitCastInst((Value *)testInst1, (Type *)resType, "bitcast2", (Instruction *)svi);
    //
    _DEBUG<<"???\n";
    svi->replaceAllUsesWith((Value *)bcInst2);

    return true;
}
bool replaceWithMerge() {
	return true;
}
bool replaceWithPack() {
	return true;
}
bool replaceWithBlend() {
	return true;
}

public:
    instruction_rep(ShuffleVectorInst * sv, const SmallVector<int, 16>& vec, unsigned ln, PatternName pn, unsigned chrct) {
       svi = sv;
       sin_mask = vec;
       laneNum = ln;
       typeId = pn;
       eigenvalue = chrct;
   }
    bool replace() {		//  return whether replacement succeeds
      
       switch (typeId) {
           case Rotate:
           return replaceWithRotate();
           case ShiftLeft:
           return replaceWithShiftLeft();
           case ShiftRightLogical:
           return replaceWithShiftRightLogical();
           case ZeroExtend:
           return replaceWithZeroExtend();
           case Merge:
           return replaceWithMerge();
           case Pack:
           return replaceWithPack();
           case Blend:
           return replaceWithBlend();
           default:
           errs() << "class instruction_rep encountered unknown type\n";
           return false;
       }
   }
};

namespace {
    class ShuffleVectorReplacementPass:public  llvm::BasicBlockPass {
    private:
		// functions serve to detect type of operand in shfvctinst
       bool isUndef(Value * op) {
           if (dyn_cast<UndefValue>(op) != nullptr)
               return true;
           return false;
       }
       bool isZeroInitializer(Value * op) {
         if (dyn_cast<ConstantAggregateZero>(op) != nullptr)
          return true;
      return false;
  }
	bool isConstantSplat(Value * op) {  // Note: here splat excludes zeroinitializer!
       ConstantDataVector* cdv = dyn_cast<ConstantDataVector>(op);
       if (cdv != nullptr)
         if (cdv->getSplatValue() != nullptr)
          return true;
      return false;
  }
  bool isVariable(Value *op) {
     if (dyn_cast<Argument>(op) != nullptr)
      return true;
  return false;
}
bool isConstant(Value *op) {
   return (isZeroInitializer(op) || isConstantSplat(op));
}

		// math helper
bool isPowerOf2(unsigned n) {
	    while (!(n%2)) {     // while n is even
          n = n >> 1;
      }
      return n==1;
  }

  unsigned lane_detect(const SmallVector<int, 16>& vec, unsigned len, unsigned constantMask) {
		// constantMask is zero if their does not exist "the second constant vector"
   bool succ = true;
   if (len <1) {
      errs() << "error condition in lane_detect, maybe mask: 01234567\n";
      return 0;
  }
  for (unsigned i=0; i<len; i++)
	       if (i+len < vec.size())   // protect in case of halfMaskLen*2 > total_len
            succ &= (((vec[i]<len)&&(vec[i+len]-vec[i]==len)) || 
              ((constantMask!=0)&&(vec[i+len]==constantMask)&&(vec[i]==constantMask)));
	       if (succ)   // this level, it can be SIMDly done half
            return 1 + lane_detect(vec, len/2, constantMask);
        else return 0;
    }
public:
	static char ID;
	    // constructor
    ShuffleVectorReplacementPass() : BasicBlockPass(ID) {}

    virtual bool runOnBasicBlock(llvm::BasicBlock &bb) {
        _DEBUG << "Begin shufflevector pattern recognization\n";
        bool isModified = false;
	    SmallVector<Instruction *, 16> toBeDeleted;	  // record the shuffleVectorInst, delete them after iterator ends
	    toBeDeleted.clear();
		// scan the basic block
        for (llvm::BasicBlock::iterator bbiter = bb.begin(); bbiter != bb.end(); bbiter++) {
            Instruction *inst = bbiter;
            ShuffleVectorInst *svi = dyn_cast<ShuffleVectorInst>(inst);
		  // shfvct detected
            if (svi != nullptr) {
                _DEBUG << "ShuffleVector detected!\n";
                if (__DEBUG) svi->dump();
                SmallVector<int, 16> mask(svi->getShuffleMask());
		      unsigned total_len = mask.size();  // the overall length of mask, note that it has nothing to do with length of operand
			//
			// Step1: canonical form transformation
			// about operands v1, v2
			//
			// via trying, we find that:
			//        initializer belongs to User->Constant->ConstantAggregateZero;
			//        undef belongs to User->Constant->UndefValue;
			//        array with value given belongs to User->Constant->ConstantDataSequential->ConstantDataVector;
			//        variable array belongs to Argument;
			//
            _DEBUG << "Step 1 starts: \n";
            Value *op1 = svi->getOperand(0);
            Value *op2 = svi->getOperand(1);
            VectorType *opVec = cast<VectorType>(op1->getType());
		    unsigned opLen = opVec->getNumElements();            // length of operand

		    if (isConstant(op1))          // always select the first one
                for (unsigned i=0; i<total_len; i++)
			         if (mask[i] < opLen)      // this position choose element from v1
			             mask[i] = 0;          // select the first one in v1: mask[0]
            if (isConstant(op2))
                for (unsigned i=0; i<total_len; i++)
        			if (mask[i] >= opLen)     // this position choose element from v2
        			    mask[i] = opLen;      // select the first one in v2: mask[opLen]

		    bool operChanged = false;     // denote if v1 and v2 transpose to form the canon
		    bool isV2Splat = false;       // many patterns below needs to know whether the second operand is constant
		    bool isV2Zero = false;        // also needs to know whether it is zeroinitializer
						  // note that isV2***, here V2 is after transposition
		    if (isUndef(op1))             // if v1 is undef, we must change the order
                operChanged = true;
            else if (isUndef(op2))
			     operChanged = false;	  // else below no undef
            else if (isConstant(op1) && isVariable(op2)) {
                operChanged = true;
                isV2Splat = true;
                isV2Zero = isZeroInitializer(op1);
            }
            else if (isVariable(op1) && isConstant(op2)) {
                operChanged = false;
                isV2Splat = true;
                isV2Zero = isZeroInitializer(op2);
		    }
            else if (mask[0] >= opLen) {// else when executing here, op1 op2 are either all var, or all const, make mask[0] < opLen
             operChanged = true;
             isV2Splat = isConstant(op1);
             isV2Zero = isZeroInitializer(op1);
            }
            else {
                isV2Splat = isConstant(op2);
                isV2Zero = isZeroInitializer(op2);
            }

		    if (operChanged)              // also need to change the mask
                for (unsigned i=0; i<total_len; i++)
                    mask[i] = (mask[i] + opLen)%(opLen << 1);
            _DEBUG << (operChanged? "v1 and v2 changed":"v1 and v2 not changed") << '\n';
            _DEBUG << "mask now: ";
            if (__DEBUG) VECTOR_DUMP(mask)
                _DEBUG << '\n';
			//
			// Step2: vector size expansion
			// about size of v1, v2 and masks
			//
			// now the length of v1, v2 can be regarded as 2^n.
			//
            _DEBUG << "Step 2 starts: \n";
		    if (!isPowerOf2(opLen)) {       // if the length of operand is not power of 2
                unsigned len2 = 1;
                while (len2 < opLen)
                     len2 = len2 << 1;
			     for (unsigned i=0; i<total_len; i++)	// update mask
                    mask[i] = mask[i]/opLen * len2 + mask[i] % opLen;
			     opLen = len2;              // modify the opLen
            }
            _DEBUG << "mask now: ";
            if (__DEBUG) VECTOR_DUMP(mask)
            _DEBUG << '\n';
			//
			// Step3: lane detection
			// about masks
			//
			// NOTE: the length of mask is now arbitrary, when it is not power of 2, naturally the laneNo is 0.
			//      but indeed we can expand it as the way of opLen, finally truncate it, so instead of
			//      total_len/2, we substitute as 2^n small than total_len.
			// here exists an unnecessary unpleasant process, if no lane detected, whether uses the original mask length,
			//  or the length expansion of mask length???
			//
            _DEBUG << "Step 3 starts: \n";
            unsigned halfMaskLen = 1;
            while ((halfMaskLen << 1) < total_len)
                halfMaskLen = halfMaskLen << 1;

            unsigned laneNo = lane_detect(mask, halfMaskLen, isV2Splat? opLen:0);
            unsigned sin_len;
            if (laneNo == 0)
                sin_len = total_len;
            else {
                sin_len = halfMaskLen << 1;
                for (unsigned i=0; i<laneNo; i++)
                    sin_len = sin_len >> 1;
            }
		    SmallVector<int, 16> sin_mask;    // sin_mask is the single_lane mask
		    for (unsigned i=0; i<sin_len; i++)
             sin_mask.push_back(mask[i]);
         _DEBUG << "lane detected: " << (1 << laneNo) << '\n';
         _DEBUG << "mask in the first lane: ";
         if (__DEBUG) VECTOR_DUMP(sin_mask);
         _DEBUG << '\n';
			//
			// Step4: pattern recognition
			// about sin_mask, opLen, property of constant of v2
			//
			// NOTE: it's very complex to handle sin_len, opLen in each pattern, when multi-lane detected,
			//      change must be well-defined, comprehensive and scalable
			//
         _DEBUG << "Step 4 starts: \n";
         pattern_rec recognizer(sin_mask, opLen, isV2Splat, isV2Zero);
         unsigned eigenvalue = 0;
         PatternName typeId = recognizer.recognize(eigenvalue);
         _DEBUG << "pattern recognized: ";
         if (__DEBUG) ArgvDump(typeId);
         _DEBUG << '\n';
			//
			// Step5: instruction replacement
			// about svi, isModified
			//
         _DEBUG << "Step 5 starts: \n";
         instruction_rep replacer(svi, sin_mask, 1<<laneNo, typeId, eigenvalue);
         if (replacer.replace()) {
             errs() << "replacement succeeds. \n";
             toBeDeleted.push_back(svi);
             isModified = true;
         } else
         errs() << "Error occurs during instruction replacement!!!\n";
         _DEBUG << "five steps finish\n";
     }
	    }   //  end of instruction's for loop
	    if (isModified) {
	    	_DEBUG << "Extra Step: remove original ShuffleVector Instructions\n";
          for (unsigned i=0; i<toBeDeleted.size(); i++)
              toBeDeleted[i]->eraseFromParent();
      }
      _DEBUG << "ALL DONE...\n";
      return isModified;
  }
		// TODO::
		// BUG REPORT:
		// 1) for  %t = shufflevector <4 x i8> zeroinitializer, <4 x i8> %a,
		//              <8 x i32> <i32 5, i32 6, i32 7, i32 4, i32 1, i32 2, i32 3, i32 0>
		//    we cant find the pattern since we manually change the mask to 12304444, which 12305674 obscured!!!
		//
		// 2) for  %t = shufflevector <8 x i8> %a, <8 x i8> zeroinitializer,
		//              <8 x i32> <i32 1, i32 2, i32 3, i32 8, i32 5, i32 6, i32 7, i32 8>
		//    we've find the single lane:1238, but the pattern "shift" is obscured due to 8-3 = 5 not an eigenvalue
		//
		// 3)for  %t = shufflevector <8 x i8> %a, <8 x i8> zeroinitializer,
		//  		<8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
		//    it will be regarded to be 8 lanes! So Pack pattern will be detected...
		//
};
char ShuffleVectorReplacementPass::ID = 0;
}


static RegisterPass<ShuffleVectorReplacementPass>
X("shfRplc", "ShuffleVectorInst pattern recognization and replacement Pass", false, false);
