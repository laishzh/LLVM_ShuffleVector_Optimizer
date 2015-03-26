; ModuleID = 'test-zext/result/res-zext-2n-lane-1.bc'

define <16 x i32> @try(<8 x i32> %a) {
  %bitcast1 = bitcast <8 x i32> %a to i256
  %res = zext i256 %bitcast1 to i512
  %bitcast2 = bitcast i512 %res to <16 x i32>
  ret <16 x i32> %bitcast2
}
