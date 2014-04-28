#include "llvm/IR/Instructions.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

static bool isByteSwap(VectorType &LHS, VectorType &RHS,
                       SmallVector<int, 16> &Masks)
{

    return false;
}

using namespace llvm;
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

                    unsigned LHSWidth = cast<VectorType>(LHS->getType())->getNumElements();
                    unsigned LHSBitWidth = cast<VectorType>(LHS->getType())->getBitWidth();
                    errs() << "LHSWidth: " << LHSWidth << "; " << "LHSBitWidth: " << LHSBitWidth << "\n";

                    Type *ElementType = cast<VectorType>(LHS->getType())->getElementType();
                    unsigned ElementWidth = 0;

                    if (IntegerType *it = dyn_cast<IntegerType>(ElementType)) {
                        ElementWidth = it->getBitWidth();
                        errs() << "It's a IntegerType and it has " << ElementWidth << " Bits." << "\n";
                    }
                    errs() << cast<VectorType>(LHS->getType())->getElementType()->isIntegerTy(8) << "\n";
                    errs() << cast<VectorType>(LHS->getType())->getElementType()->isIntegerTy(16) << "\n";


                    unsigned VWidth = cast<VectorType>(si->getType())->getNumElements();
                    unsigned VBitWidth = cast<VectorType>(si->getType())->getBitWidth();
                    errs() << "VWidth: " << VWidth << "; " << "VBitWidth: " << VBitWidth << "\n";

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

                    IntegerType *it = dyn_cast<IntegerType>(ElementType);
                    if (VWidth > 0
                        && VWidth % 8 == 0
                        && it != nullptr
                        && it->isIntegerTy(8)) {
                        //Check if ShuffleVector can be translated into
                        //several llvm.bswap.i64 operations.
                        SmallVector<int, 8> checkmasks;
                        bool checkflag = true;
                        for (unsigned i = 0; i < VWidth / 8; ++i) {
                            unsigned base = masks[i * 8];
                            if (base % 8 != 7) {
                                checkflag = false;
                                errs() << "Break at Base: " << base << "\n";
                                break;
                            }
                            for (unsigned j = 1; j < 8; ++j) {
                                if (base - masks[i*8 + j] != j) {
                                    checkflag = false;
                                    errs() << "Break at: " << i << ":" << j << "\n";
                                    break;
                                }
                            }
                            if (!checkflag) {
                                break;
                            } else {
                                checkmasks.push_back(base / 8);
                            }
                        }

                        if (checkflag) {
                            errs() << "Can be translated.\n";
                            for (unsigned i = 0; i < checkmasks.size(); ++i) {
                                errs() << checkmasks[i] << " ";
                            }
                            errs() << "\n";
                        } else {
                            errs() << "Cannot be translated.\n";
                            //TODO:change this
                        }


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

static RegisterPass<ShufflevectorToByteSwapPass> X("SFLtoBSwap", "Shufflevector to ByteSwap Pass", false, false);