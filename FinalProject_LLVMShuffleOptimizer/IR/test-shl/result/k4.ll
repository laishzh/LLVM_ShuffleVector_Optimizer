; ModuleID = 'test-shl/result/k4.bc'

define <7 x i12> @mysfl(<8 x i12> %a, <8 x i12> %b) {
  %bcInst1 = bitcast <8 x i12> %a to <2 x i48>
  %shl1 = shl <2 x i48> %bcInst1, <i48 12, i48 12>
  %bcInst3 = bitcast <2 x i48> %shl1 to i96
  %trunc1 = trunc i96 %bcInst3 to i84
  %bitcast2L = bitcast i84 %trunc1 to <7 x i12>
  ret <7 x i12> %bitcast2L
}
