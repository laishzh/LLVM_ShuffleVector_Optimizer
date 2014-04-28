#include "llvm/IR/Instructions.h"
#include "llvm/IR/BasicBlock.h"
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

static void replaceShuffleVectorWithByteSwap64()
{

    return ;
}

namespace {
    class ShufflevectorToByteSwapPass:public llvm::BasicBlockPass {
    public:

        ShufflevectorToByteSwapPass() : BasicBlockPass(ID) {}
        virtual bool runOnBasicBlock(llvm::BasicBlock &bb) {
            errs() << "Hello: \n";
            bool retval = false;
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
                    } else {
                        errs() << "Shufflevector cannot be translated "
                            "into ByteSwap.\n";
                    }



                }
                    //DEBUG(errs() << "I am here!\n");
            }
            return false;
        }
        static char ID;

    };

    char ShufflevectorToByteSwapPass::ID = 0;
}

static RegisterPass<ShufflevectorToByteSwapPass>
    X("SFLtoBSwap", "Shufflevector to ByteSwap Pass", false, false);