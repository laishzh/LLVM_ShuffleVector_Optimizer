ByteSwap

 Performance counter stats for './byte_swap' (1000 runs):

          0.399183 task-clock                #    0.689 CPUs utilized            ( +-  0.60% )
                 0 context-switches          #    0.158 K/sec                    ( +- 12.61% )
                 0 cpu-migrations            #    0.055 K/sec                    ( +- 22.05% )
               113 page-faults               #    0.283 M/sec                    ( +-  0.01% )
           641,036 cycles                    #    1.606 GHz                      ( +-  0.61% )
           427,594 stalled-cycles-frontend   #   66.70% frontend cycles idle     ( +-  0.53% )
           288,234 stalled-cycles-backend    #   44.96% backend  cycles idle     ( +-  0.59% )
           486,575 instructions              #    0.76  insns per cycle        
                                             #    0.88  stalled cycles per insn  ( +-  0.05% )
            97,531 branches                  #  244.326 M/sec                    ( +-  0.04% )
     <not counted> branch-misses           

       0.000579185 seconds time elapsed                                          ( +-  0.65% )

ShuffleVector

 Performance counter stats for './sfl_vec' (1000 runs):

          0.404711 task-clock                #    0.684 CPUs utilized            ( +-  0.55% )
                 0 context-switches          #    0.156 K/sec                    ( +- 12.41% )
                 0 cpu-migrations            #    0.049 K/sec                    ( +- 22.15% )
               113 page-faults               #    0.279 M/sec                    ( +-  0.01% )
           638,817 cycles                    #    1.578 GHz                      ( +-  0.67% )
           430,972 stalled-cycles-frontend   #   67.46% frontend cycles idle     ( +-  0.58% )
           290,810 stalled-cycles-backend    #   45.52% backend  cycles idle     ( +-  0.67% )
           486,244 instructions              #    0.76  insns per cycle        
                                             #    0.89  stalled cycles per insn  ( +-  0.06% )
            97,512 branches                  #  240.942 M/sec                    ( +-  0.04% )
     <not counted> branch-misses           

       0.000592044 seconds time elapsed                                          ( +-  0.68% )

