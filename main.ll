; ModuleID = 'main.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
entry:
  %0 = alloca i32, align 4

  store i32 0, i32* %0
  %1 = load i32 * %0
  %2 = alloca i64, align 4
  %3 = load i64 * %2
  %4 = bitcast i64 %3 to <8 x i8>

  
  
  br label %Loop
Loop:
  %indvar = phi i32 [100000, %entry], [%nextvar, %Loop]
  ;%5 = shufflevector<8 x i8> %4, <8 x i8> undef,
  ;<8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  %5 = bitcast <8 x i8> %4 to i64
  %6 = call i64 @llvm.bswap.i64(i64 %5)
  %7 = bitcast i64 %6 to <8 x i8>

  

  %nextvar = sub i32 %indvar, 1
  %cond = icmp eq i32 %nextvar, 0
  br i1 %cond, label %AfterLoop, label %Loop
AfterLoop:

  ret i32 0
}

declare i16 @llvm.bswap.i16(i16 )
declare i32 @llvm.bswap.i32(i32 )
declare i64 @llvm.bswap.i64(i64 )

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4.1-1~exp1 (branches/release_34) (based on LLVM 3.4.1)"}
