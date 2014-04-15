#How ShuffleVector works#
##ShuffleVectorInst Class##
The Class ShuffleVectorInst is defined in file of [Instructions.h](https://github.com/laishzh/llvm/blob/master/include/llvm/IR/Instructions.h). In the ShuffleVectorInst, there are some basic operations, such as the getMask(), getMaskValue(), getMaskValue() and getShuffleMask(). 

getMask() returns the mask constant array.
getMaskValue() returns the index from shuffle mask for the specified output result. This is either -1 if the element is undef or a number less than 2*numelements.
getShuffleMask() returns the full mask for this instruction, where each element is the element number and undef's are returned as -1.

##visitShuffleVectorInst Functions##
There are several visitShuffleVectorInst Functions in different classes, such as InstCombiner, Scalarizer, Interpreter, Verifier, and so on. This means you can do different works in different periods of compilation, and execution.
