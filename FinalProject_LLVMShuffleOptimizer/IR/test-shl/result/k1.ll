; ModuleID = 'test-shl/result/k1.bc'

define <8 x i8> @mysfl(<8 x i8> %a, <8 x i8> %b) {
  %bitcast1 = bitcast <8 x i8> %a to i64
  %shl1 = shl i64 %bitcast1, 24
  %bitcast2L = bitcast i64 %shl1 to <8 x i8>
  ret <8 x i8> %bitcast2L
}
