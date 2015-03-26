; ModuleID = 'test-blend/result/blend.bc'

define <4 x i32> @mysfl(<4 x i32> %a, <4 x i32> %b) {
  %slInst1 = select <4 x i1> <i1 true, i1 false, i1 false, i1 true>, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %slInst1
}
