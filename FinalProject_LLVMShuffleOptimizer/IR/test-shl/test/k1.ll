define <8 x i8> @mysfl(<8 x i8> %a, <8 x i8>%b)
{
  %t = shufflevector <8 x i8> %a, <8 x i8> zeroinitializer,
     <8 x i32> <i32 8, i32 8, i32 8, i32 0, i32 1, i32 2, i32 3, i32 4>
     
  ret <8 x i8> %t
}
