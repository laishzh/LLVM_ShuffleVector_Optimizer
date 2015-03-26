define <8 x i12> @mysfl(<10 x i12> %a, <10 x i12>%b)
{
  %t = shufflevector <10 x i12> zeroinitializer, <10 x i12> %a,
     <8 x i32> <i32 0, i32 0, i32 0, i32 0, i32 0, i32 10, i32 11, i32 12>
     
  ret <8 x i12> %t
}
