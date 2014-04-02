ShuffleVector

 Performance counter stats for './sfl_vec' (1000 runs):

          4.453295 task-clock                #    0.952 CPUs utilized            ( +-  0.60% )
                 0 context-switches          #    0.093 K/sec                    ( +-  4.00% )
                 0 cpu-migrations            #    0.027 K/sec                    ( +-  9.25% )
               139 page-faults               #    0.031 M/sec                    ( +-  0.01% )
     <not counted> cycles                  
         4,499,332 stalled-cycles-frontend   #   95.12% frontend cycles idle     ( +-  0.23% )
           600,796 stalled-cycles-backend    #   12.70% backend  cycles idle     ( +-  1.20% )
        11,451,385 instructions              #    2.42  insns per cycle        
                                             #    0.39  stalled cycles per insn  ( +-  0.00% )
         2,085,423 branches                  #  468.288 M/sec                    ( +-  0.00% )
             1,963 branch-misses             #    0.09% of all branches          ( +-  2.49% )

       0.004677592 seconds time elapsed                                          ( +-  0.58% )

ByteSwap

 Performance counter stats for './byte_swap' (1000 runs):

          4.492368 task-clock                #    0.953 CPUs utilized            ( +-  0.57% )
                 0 context-switches          #    0.094 K/sec                    ( +-  3.86% )
                 0 cpu-migrations            #    0.027 K/sec                    ( +-  9.34% )
               139 page-faults               #    0.031 M/sec                    ( +-  0.01% )
         4,897,603 cycles                    #    1.090 GHz                      ( +-  1.44% ) [68.73%]
         4,497,303 stalled-cycles-frontend   #   91.83% frontend cycles idle     ( +-  0.22% )
           507,080 stalled-cycles-backend    #   10.35% backend  cycles idle     ( +-  1.16% )
         9,448,124 instructions              #    1.93  insns per cycle        
                                             #    0.48  stalled cycles per insn  ( +-  0.00% )
         2,084,827 branches                  #  464.082 M/sec                    ( +-  0.00% )
             2,019 branch-misses             #    0.10% of all branches          ( +-  2.81% ) [61.32%]

       0.004714244 seconds time elapsed                                          ( +-  0.55% )

