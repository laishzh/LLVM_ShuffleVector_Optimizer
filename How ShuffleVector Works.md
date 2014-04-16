#How ShuffleVector works#
##ShuffleVectorInst Class##
The Class ShuffleVectorInst is defined in file of [Instructions.h](https://github.com/laishzh/llvm/blob/master/include/llvm/IR/Instructions.h). In the ShuffleVectorInst, there are some basic operations, such as the getMask(), getMaskValue(), getMaskValue() and getShuffleMask(). 

getMask() returns the mask constant array.
getMaskValue() returns the index from shuffle mask for the specified output result. This is either -1 if the element is undef or a number less than 2*numelements.
getShuffleMask() returns the full mask for this instruction, where each element is the element number and undef's are returned as -1.

##visitShuffleVectorInst Functions##
There are several visitShuffleVectorInst Functions in different classes, such as InstCombiner, Scalarizer, Interpreter, Verifier, and so on. This means you can do different works in different periods of compilation, and execution.

In the file [InstCombineVectorOps.cpp](https://github.com/laishzh/llvm/blob/master/lib/Transforms/InstCombine/InstCombineVectorOps.cpp), implements instcombine for ExtractElement, InsertElement and ShuffleVector. The function InstCombiner::visitShuffleVectorInst has dealed with these four special cases for shufflevector.

>If the LHS is a shufflevector itself, see if we can combine it with this
one without producing an unusual shuffle.                               
Cases that might be simplified:                                         
1.                                                                      
x1=shuffle(v1,v2,mask1)                                                 
 x=shuffle(x1,undef,mask)                                               
       ==>                                                              
 x=shuffle(v1,undef,newMask)                                            
newMask[i] = (mask[i] < x1.size()) ? mask1[mask[i]] : -1                
2.                                                                      
x1=shuffle(v1,undef,mask1)                                              
 x=shuffle(x1,x2,mask)                                                  
where v1.size() == mask1.size()                                         
       ==>                                                              
 x=shuffle(v1,x2,newMask)                                               
newMask[i] = (mask[i] < x1.size()) ? mask1[mask[i]] : mask[i]           
3.                                                                      
x2=shuffle(v2,undef,mask2)                                              
 x=shuffle(x1,x2,mask)                                                  
where v2.size() == mask2.size()                                         
       ==>                                                              
 x=shuffle(x1,v2,newMask)                                               
newMask[i] = (mask[i] < x1.size())                                      
             ? mask[i] : mask2[mask[i]-x1.size()]+x1.size()             
4.                                                                      
x1=shuffle(v1,undef,mask1)                                              
x2=shuffle(v2,undef,mask2)                                              
 x=shuffle(x1,x2,mask)                                                  
where v1.size() == v2.size()                                            
       ==>                                                              
 x=shuffle(v1,v2,newMask)                                               
newMask[i] = (mask[i] < x1.size())                                      
             ? mask1[mask[i]] : mask2[mask[i]-x1.size()]+v1.size()      

And also, 
>Here we are really conservative:                                        
we are absolutely afraid of producing a shuffle mask not in the input   
program, because the code gen may not be smart enough to turn a merged  
shuffle into two specific shuffles: it may produce worse code.  As such,
we only merge two shuffles if the result is either a splat or one of the
input shuffle masks.  In this case, merging the shuffles just removes   
one instruction, which we know is safe.  This is good for things like   
turning: (splat(splat)) -> splat, or                                    
merge(V[0..n], V[n+1..2n]) -> V[0..2n]                                  

##ShuffleVector in Assembly 
