define <16 x i32> @try(<8 x i32> %a)
{
	
	%b = shufflevector <8 x i32> %a, <8 x i32> zeroinitializer, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5,  i32 6, i32 7, i32 8,i32 8,i32 8,i32 8,i32 8,i32 8,i32 8,i32 8>  ; yields <16 x i8>

	ret <16 x i32> %b

}
