; ModuleID = 'test-LShr/result/res-LShr-2-lane-1.bc'

define <8 x i32> @try(<8 x i32> %a) {
  %bitcast1 = bitcast <8 x i32> %a to i256
  %LShr = lshr i256 %bitcast1, 64
  %bitcast2R = bitcast i256 %LShr to <8 x i32>
  ret <8 x i32> %bitcast2R
}
