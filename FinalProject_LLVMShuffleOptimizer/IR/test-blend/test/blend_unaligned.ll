define <3 x i32> @mysfl(<4 x i32> %a, <4 x i32>%b)
{
  %t = shufflevector <4 x i32> %a, <4 x i32> %b, <3 x i32> <i32 0, i32 5, i32 6>
  ret <3 x i32> %t
}

