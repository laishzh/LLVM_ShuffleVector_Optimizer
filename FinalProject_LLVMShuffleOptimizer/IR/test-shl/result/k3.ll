; ModuleID = 'test-shl/result/k3.bc'

define <8 x i4> @mysfl(<8 x i4> %a, <8 x i4> %b) {
  %bcInst1 = bitcast <8 x i4> %a to <2 x i16>
  %shl1 = shl <2 x i16> %bcInst1, <i16 4, i16 4>
  %bitcast2L = bitcast <2 x i16> %shl1 to <8 x i4>
  ret <8 x i4> %bitcast2L
}
