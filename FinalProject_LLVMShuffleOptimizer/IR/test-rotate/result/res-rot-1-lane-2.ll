; ModuleID = 'test-rotate/result/res-rot-1-lane-2.bc'

define <8 x i32> @try(<8 x i32> %a) {
  %bcInst1 = bitcast <8 x i32> %a to <2 x i128>
  %shl1 = shl <2 x i128> %bcInst1, <i128 32, i128 32>
  %bcInst11 = bitcast <8 x i32> %a to <2 x i128>
  %LShr = lshr <2 x i128> %bcInst11, <i128 96, i128 96>
  %Xor = xor <2 x i128> %shl1, %LShr
  %bitcastRot = bitcast <2 x i128> %Xor to <8 x i32>
  ret <8 x i32> %bitcastRot
}
