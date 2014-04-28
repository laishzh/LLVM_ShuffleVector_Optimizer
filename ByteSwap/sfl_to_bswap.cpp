#include "llvm/IR/Instructions.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"

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

                    if (IntegerType *it = dyn_cast<IntegerType>(ElementType)) {
                        errs() << "It's a IntegerType and it has " << it->getBitWidth() << " Bits." << "\n";

                    }
                    errs() << cast<VectorType>(LHS->getType())->getElementType()->isIntegerTy(8) << "\n";
                    errs() << cast<VectorType>(LHS->getType())->getElementType()->isIntegerTy(16) << "\n";


                    unsigned VWidth = cast<VectorType>(si->getType())->getNumElements();
                    unsigned VBitWidth = cast<VectorType>(si->getType())->getBitWidth();
                    errs() << "VWidth: " << VWidth << "; " << "VBitWidth: " << VBitWidth << "\n";

                    si->print(errs());
                    errs() << "\n";
                    SmallVector<int, 16> masks(si->getShuffleMask());

                    //si->getShuffleMask(masks);
                    errs() << masks.size() << " masks.\n";
                    for (unsigned i = 0; i < masks.size(); ++i) {
                        errs() << i << " ";
                        if (i % 8 == 7) {
                            errs() << '\n';
                        }
                    }
                    errs() << "\n";
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