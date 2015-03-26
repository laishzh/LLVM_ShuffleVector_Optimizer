; ModuleID = 'test-rotate/result/res-rot-1-lane-1.bc'

define <8 x i32> @try(<8 x i32> %a) {
  %bitcast1 = bitcast <8 x i32> %a to i256
  %shl1 = shl i256 %bitcast1, 32
  %bitcast11 = bitcast <8 x i32> %a to i256
  %LShr = lshr i256 %bitcast11, 224
  %Xor = xor i256 %shl1, %LShr
  %bitcastRot = bitcast i256 %Xor to <8 x i32>
  ret <8 x i32> %bitcastRot
}
