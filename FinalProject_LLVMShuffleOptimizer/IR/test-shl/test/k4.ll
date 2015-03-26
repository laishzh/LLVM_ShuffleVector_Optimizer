define <7 x i12> @mysfl(<8 x i12> %a, <8 x i12>%b)
{
  %t = shufflevector <8 x i12> %a, <8 x i12> zeroinitializer,
     <7 x i32> <i32 8, i32 0, i32 1, i32 2, i32 8, i32 4, i32 5>
     
  ret <7 x i12> %t
}
