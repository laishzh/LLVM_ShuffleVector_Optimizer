; ModuleID = 'test-blend/result/blend_unaligned.bc'

define <3 x i32> @mysfl(<4 x i32> %a, <4 x i32> %b) {
  %slInst1 = select <4 x i1> <i1 true, i1 false, i1 false, i1 true>, <4 x i32> %a, <4 x i32> %b
  %bcInst1 = bitcast <4 x i32> %slInst1 to i128
  %tcInst1 = trunc i128 %bcInst1 to i96
  %bcInst2 = bitcast i96 %tcInst1 to <3 x i32>
  ret <3 x i32> %bcInst2
}
