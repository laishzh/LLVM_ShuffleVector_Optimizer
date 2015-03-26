; ModuleID = 'test-LShr/result/res-LShr-2-lane-2.bc'

define <8 x i32> @try(<8 x i32> %a) {
  %bcInst1 = bitcast <8 x i32> %a to <2 x i128>
  %LShr = lshr <2 x i128> %bcInst1, <i128 64, i128 64>
  %bitcast2R = bitcast <2 x i128> %LShr to <8 x i32>
  ret <8 x i32> %bitcast2R
}
