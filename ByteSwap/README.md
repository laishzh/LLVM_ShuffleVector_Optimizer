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

(lldb) disassemble -name main
byte_swap`main:
byte_swap[0x4004d0]:  pushq  %rbp
byte_swap[0x4004d1]:  movq   %rsp, %rbp
byte_swap[0x4004d4]:  movl   $0x756b5b3, %eax
byte_swap[0x4004d9]:  movl   %eax, %ecx
byte_swap[0x4004db]:  movd   %rcx, %xmm0
byte_swap[0x4004e0]:  punpcklbw %xmm1, %xmm0
byte_swap[0x4004e4]:  movl   $0x0, -0x4(%rbp)
byte_swap[0x4004eb]:  movl   $0x0, -0x8(%rbp)
byte_swap[0x4004f2]:  movl   $0x0, -0x8(%rbp)
byte_swap[0x4004f9]:  movaps %xmm0, -0x30(%rbp)
byte_swap[0x4004fd]:  cmpl   $0x2710, -0x8(%rbp)
byte_swap[0x400504]:  jge    0x40051a                  ; main + 74
byte_swap[0x40050a]:  movl   -0x8(%rbp), %eax
byte_swap[0x40050d]:  addl   $0x1, %eax
byte_swap[0x400512]:  movl   %eax, -0x8(%rbp)
byte_swap[0x400515]:  jmp    0x4004fd                  ; main + 45
byte_swap[0x40051a]:  movl   $0x0, %eax
byte_swap[0x40051f]:  popq   %rbp
byte_swap[0x400520]:  retq   

(lldb) disassemble -name main
sfl_vec`main:
sfl_vec[0x4004d0]:  pushq  %rbp
sfl_vec[0x4004d1]:  movq   %rsp, %rbp
sfl_vec[0x4004d4]:  movl   $0x756b5b3, %eax
sfl_vec[0x4004d9]:  movl   %eax, %ecx
sfl_vec[0x4004db]:  movd   %rcx, %xmm0
sfl_vec[0x4004e0]:  punpcklbw %xmm1, %xmm0
sfl_vec[0x4004e4]:  movl   $0x0, -0x4(%rbp)
sfl_vec[0x4004eb]:  movl   $0x0, -0x8(%rbp)
sfl_vec[0x4004f2]:  movl   $0x0, -0x8(%rbp)
sfl_vec[0x4004f9]:  movaps %xmm0, -0x30(%rbp)
sfl_vec[0x4004fd]:  cmpl   $0x2710, -0x8(%rbp)
sfl_vec[0x400504]:  jge    0x40051a                  ; main + 74
sfl_vec[0x40050a]:  movl   -0x8(%rbp), %eax
sfl_vec[0x40050d]:  addl   $0x1, %eax
sfl_vec[0x400512]:  movl   %eax, -0x8(%rbp)
sfl_vec[0x400515]:  jmp    0x4004fd                  ; main + 45
sfl_vec[0x40051a]:  movl   $0x0, %eax
sfl_vec[0x40051f]:  popq   %rbp
sfl_vec[0x400520]:  retq   
