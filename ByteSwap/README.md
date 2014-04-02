ShuffleVector

 Performance counter stats for './sfl_vec' (1000 runs):

          4.451156 task-clock                #    0.952 CPUs utilized            ( +-  0.60% )
                 0 context-switches          #    0.095 K/sec                    ( +-  3.96% )
                 0 cpu-migrations            #    0.031 K/sec                    ( +-  8.92% )
               139 page-faults               #    0.031 M/sec                    ( +-  0.01% )
         4,832,559 cycles                    #    1.086 GHz                      ( +-  1.47% )
         4,485,436 stalled-cycles-frontend   #   92.82% frontend cycles idle     ( +-  0.23% )
           599,417 stalled-cycles-backend    #   12.40% backend  cycles idle     ( +-  1.20% )
        11,451,614 instructions              #    2.37  insns per cycle        
                                             #    0.39  stalled cycles per insn  ( +-  0.00% )
         2,085,465 branches                  #  468.522 M/sec                    ( +-  0.00% )
             2,052 branch-misses             #    0.10% of all branches          ( +-  2.86% ) [62.17%]

       0.004674730 seconds time elapsed                                          ( +-  0.58% )

ByteSwap

 Performance counter stats for './byte_swap' (1000 runs):

          4.465466 task-clock                #    0.952 CPUs utilized            ( +-  0.58% )
                 0 context-switches          #    0.096 K/sec                    ( +-  3.79% )
                 0 cpu-migrations            #    0.029 K/sec                    ( +-  9.40% )
               139 page-faults               #    0.031 M/sec                    ( +-  0.01% )
         4,826,001 cycles                    #    1.081 GHz                      ( +-  1.50% ) [68.84%]
         4,514,586 stalled-cycles-frontend   #   93.55% frontend cycles idle     ( +-  0.24% ) [99.96%]
           524,281 stalled-cycles-backend    #   10.86% backend  cycles idle     ( +-  1.33% )
         9,449,852 instructions              #    1.96  insns per cycle        
                                             #    0.48  stalled cycles per insn  ( +-  0.00% )
         2,085,156 branches                  #  466.951 M/sec                    ( +-  0.00% )
             2,100 branch-misses             #    0.10% of all branches          ( +-  2.92% ) [61.70%]

       0.004690560 seconds time elapsed                                          ( +-  0.56% )

