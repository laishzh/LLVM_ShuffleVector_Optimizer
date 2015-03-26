define <8 x i4> @mysfl(<8 x i4> %a, <8 x i4>%b)
{
  %t = shufflevector <8 x i4> %a, <8 x i4> zeroinitializer,
     <8 x i32> <i32 8, i32 0, i32 1, i32 2, i32 8, i32 4, i32 5, i32 6>
     
  ret <8 x i4> %t
}
