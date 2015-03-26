; ModuleID = 'test-shl/result/k5.bc'

define <8 x i12> @mysfl(<10 x i12> %a, <10 x i12> %b) {
  %bitcast1 = bitcast <10 x i12> zeroinitializer to i120
  %trunc1 = trunc i120 %bitcast1 to i96
  %shl1 = shl i96 %trunc1, 60
  %bitcast2L = bitcast i96 %shl1 to <8 x i12>
  ret <8 x i12> %bitcast2L
}
