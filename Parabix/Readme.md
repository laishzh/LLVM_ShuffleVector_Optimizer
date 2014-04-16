#Parabix#
##Introduction##
[Parabix](http://parabix.costar.sfu.ca/) technology is a high-performance programming framework for streaming text processing applications, leveraging both SIMD and multicore parallel processing features.
##Parabix's s2p##
Parabix transforms byte sequences into bit streams, for ASCII, is eight bit streams. File [minre.cpp](https://github.com/laishzh/LLVM_ShuffleVector_Optimizer/blob/master/Parabix/minre.cpp) is a minimial file, which only reads the bytes from a file and does the byte-to-bits transformation. In minre.cpp, **s2p_do_block** is the key function. The **s2p** maybe is short of "Sequential To Parallized". 
