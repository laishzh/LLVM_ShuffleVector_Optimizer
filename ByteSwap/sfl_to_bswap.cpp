#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"


using namespace llvm;
static bool isByteSwap64(ShuffleVectorInst &SI, SmallVector<int, 16>&RefMasks)
{

    RefMasks.clear();
    unsigned VWidth = cast<VectorType>(SI.getType())->getNumElements();
    VectorType *LHS = cast<VectorType>(SI.getOperand(0)->getType());
    VectorType *RHS = cast<VectorType>(SI.getOperand(1)->getType());

    IntegerType *IT = dyn_cast<IntegerType>(LHS->getElementType());
    //When Element Type is not IntegerType or the Result's element number
    //can't be divided by 8, return false
    //TODO:Need to check all masks are all constants.
    if (IT == nullptr
        || ! IT->isIntegerTy(8)
        || VWidth % 8 != 0) {
        return false;
    }

    SmallVector<int, 16> Masks(SI.getShuffleMask());
    bool isByteSwap = true;

    for (unsigned i = 0; i < VWidth / 8; ++i) {
        unsigned base = Masks[i * 8];
        if (base % 8 != 7) {
            isByteSwap = false;
            break;
        }

        for (unsigned j = 1; j < 8; ++j) {
            if (base - Masks[i * 8 + j] != j) {
                isByteSwap = false;
                break;
            }
        }

        if (isByteSwap) {
            RefMasks.push_back(base / 8);
        } else {
            break;
        }
    }

    if (!isByteSwap) {
        RefMasks.clear();
    }

    return isByteSwap;
}

static void replaceShuffleVectorWithByteSwap64(
    ShuffleVectorInst *SI, SmallVector<int, 16> &RefMasks)
{
    Value *LHS = SI->getOperand(0);
    Value *RHS = SI->getOperand(1);
    VectorType *LHSType = cast<VectorType>(LHS->getType());
    VectorType *RHSType = cast<VectorType>(RHS->getType());
    unsigned LHSWidth = LHSType->getBitWidth();
    errs() << "In Replace: " << LHSWidth << "\n";
    unsigned RHSWidth = RHSType->getBitWidth();

    //ReplaceWork begins
    //TODO:Make it automatic and compact

    unsigned ITEMNUM = LHSWidth / 64;
    VectorType *Ty1 = VectorType::get(
        Type::getInt64Ty(SI->getContext()),
                ITEMNUM);

    BitCastInst *BCI1 = new BitCastInst(
        LHS, Ty1, "", SI);

    SmallVector<Constant *, 16> BigMasks;
    for (unsigned i = 0; i < ITEMNUM; ++i) {
        APInt num(32, ITEMNUM - i - 1);
        BigMasks.push_back(
            Constant::getIntegerValue(
                Type::getInt32Ty(SI->getContext()),
                num));
    }
    Constant *Masks = ConstantVector::get(BigMasks);
    ShuffleVectorInst *SVI = new ShuffleVectorInst(
        BCI1, UndefValue::get(BCI1->getType()),
        Masks,//Mask is ConstantVector
        "",
        SI);

    SmallVector<CallInst *, 16> CIS;

    for (unsigned i = 0; i < ITEMNUM; ++i) {
        ConstantInt *CI =
            ConstantInt::get(
                Type::getInt32Ty(
                    SI->getContext()), i);
        ExtractElementInst *EEI = ExtractElementInst::Create(
            SVI, CI, "", SI);
        //EVIS.push_back(EEI);

        Module *M = SI->getParent()->getParent()->getParent();
        Constant *Int = Intrinsic::getDeclaration(
            M, Intrinsic::bswap, EEI->getType());
        Value *Op = EEI;
        CallInst *CaI = CallInst::Create(Int, Op, "", SI);
        CIS.push_back(CaI);
    }



    return ;
}

namespace {
    class ShufflevectorToByteSwapPass:public llvm::BasicBlockPass {
    public:

        ShufflevectorToByteSwapPass() : BasicBlockPass(ID) {}
        virtual bool runOnBasicBlock(llvm::BasicBlock &bb) {
            errs() << "Hello: \n";
            bool isModified = false;
            for (llvm::BasicBlock::iterator bbit = bb.begin();
                 bbit != bb.end(); ++bbit) {
                Instruction *isn = bbit;
                if (ShuffleVectorInst *si = dyn_cast<ShuffleVectorInst>(isn)) {
                    errs() << "ShuffleVector\n";
                    Value *LHS = si->getOperand(0);

                    unsigned LHSWidth
                        = cast<VectorType>(LHS->getType())->getNumElements();
                    unsigned LHSBitWidth
                        = cast<VectorType>(LHS->getType())->getBitWidth();
                    errs() << "LHSWidth: " << LHSWidth << "; "
                           << "LHSBitWidth: " << LHSBitWidth << "\n";

                    Type *ElementType
                        = cast<VectorType>(LHS->getType())->getElementType();
                    unsigned ElementWidth = 0;

                    if (IntegerType *it = dyn_cast<IntegerType>(ElementType)) {
                        ElementWidth = it->getBitWidth();
                        errs() << "It's a IntegerType and it has "
                               << ElementWidth << " Bits." << "\n";
                    }
                    errs() << cast<VectorType>(LHS->getType())
                        ->getElementType()->isIntegerTy(8) << "\n";
                    errs() << cast<VectorType>(LHS->getType())
                        ->getElementType()->isIntegerTy(16) << "\n";


                    unsigned VWidth
                        = cast<VectorType>(si->getType())->getNumElements();
                    unsigned VBitWidth
                        = cast<VectorType>(si->getType())->getBitWidth();
                    errs() << "VWidth: " << VWidth << "; "
                           << "VBitWidth: " << VBitWidth << "\n";

                    si->print(errs());
                    errs() << "\n";
                    SmallVector<int, 16> masks(si->getShuffleMask());

                    errs() << masks.size() << " masks.\n";

                    for (unsigned i = 0; i < masks.size(); ++i) {
                        errs() << masks[i] << " ";
                        if (i % 8 == 7) {
                            errs() << '\n';
                        }
                    }
                    errs() << "\n";

                    SmallVector<int, 16> RefMasks;

                    bool isBswap = isByteSwap64(*si, RefMasks);
                    if (isBswap) {
                        errs() << "Shufflevector can be translated "
                            "into ByteSwap.\n";
                        for (unsigned i = 0; i < RefMasks.size(); ++i) {
                            errs() << RefMasks[i] << " ";
                        }
                        errs() << "\n";
                        replaceShuffleVectorWithByteSwap64(si, RefMasks);
                        isModified = true;
                    } else {
                        errs() << "Shufflevector cannot be translated "
                            "into ByteSwap.\n";
                    }




                }
                    //DEBUG(errs() << "I am here!\n");
            }
            return isModified;
        }
        static char ID;

    };

    char ShufflevectorToByteSwapPass::ID = 0;
}

static RegisterPass<ShufflevectorToByteSwapPass>
    X("SFLtoBSwap", "Shufflevector to ByteSwap Pass", false, false);