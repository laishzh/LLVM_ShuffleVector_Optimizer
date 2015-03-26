; ModuleID = 'test-shl/result/k2.bc'

define <5 x i12> @mysfl(<8 x i12> %a, <8 x i12> %b) {
  %bitcast1 = bitcast <8 x i12> %a to i96
  %trunc1 = trunc i96 %bitcast1 to i60
  %shl1 = shl i60 %trunc1, 24
  %bitcast2L = bitcast i60 %shl1 to <5 x i12>
  ret <5 x i12> %bitcast2L
}
