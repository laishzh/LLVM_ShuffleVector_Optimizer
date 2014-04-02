; ModuleID = 'a.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [21 x i8] c"%02X %02X %02X %02X \00", align 1
@.str1 = private unnamed_addr constant [21 x i8] c"%02X %02X %02X %02X\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 0, i32* %1
  store i32 287454020, i32* %a, align 4
  store i32 1432778632, i32* %b, align 4
  store i32 0, i32* %i, align 4
  store i32 0, i32* %i, align 4
  %t1 = load i32* %a, align 4
  %t2 = load i32* %b, align 4
  %t3 = zext i32 %t1 to i64
  %t4 = shl i64 %t3, 32
  %t5 = zext i32 %t2 to i64
  %t6 = add i64 %t5, %t4
  %t7 = bitcast i64 %t6 to <8 x i8>
  br label %2

; <label>:2                                       ; preds = %6, %0
  %3 = load i32* %i, align 4
  %4 = icmp slt i32 %3, 1000000
  br i1 %4, label %5, label %9

; <label>:5                                       ; preds = %2
  %bsret = call i64 @llvm.bswap.i64(i64 %t6)
  ;%bs1 = shufflevector <8 x i8> %t7, <8 x i8> undef,
  ;     <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  
  br label %6

; <label>:6                                       ; preds = %5
  %7 = load i32* %i, align 4
  %8 = add nsw i32 %7, 1
  store i32 %8, i32* %i, align 4
  br label %2

; <label>:9                                       ; preds = %2
  ;%bsret = bitcast <8 x i8> %bs1 to i64
  %t20 = bitcast i64 %bsret to <2 x i32>
  %t21 = extractelement <2 x i32> %t20, i32 1
  %t22 = extractelement <2 x i32> %t20, i32 0
  store i32 %t21, i32* %a, align 4
  store i32 %t22, i32* %b, align 4

  %10 = load i32* %a, align 4
  %11 = and i32 %10, -16777216
  %12 = lshr i32 %11, 24
  %13 = load i32* %a, align 4
  %14 = and i32 %13, 16711680
  %15 = ashr i32 %14, 16
  %16 = load i32* %a, align 4
  %17 = and i32 %16, 65280
  %18 = ashr i32 %17, 8
  %19 = load i32* %a, align 4
  %20 = and i32 %19, 255
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i32 0, i32 0), i32 %12, i32 %15, i32 %18, i32 %20)
  %22 = load i32* %b, align 4
  %23 = and i32 %22, -16777216
  %24 = lshr i32 %23, 24
  %25 = load i32* %b, align 4
  %26 = and i32 %25, 16711680
  %27 = ashr i32 %26, 16
  %28 = load i32* %b, align 4
  %29 = and i32 %28, 65280
  %30 = ashr i32 %29, 8
  %31 = load i32* %b, align 4
  %32 = and i32 %31, 255
  %33 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str1, i32 0, i32 0), i32 %24, i32 %27, i32 %30, i32 %32)
  ret i32 0
}

declare i32 @printf(i8*, ...) #1
declare i64 @llvm.bswap.i64(i64)
declare i32 @llvm.bswap.i32(i32)

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4.1-1~exp1 (branches/release_34) (based on LLVM 3.4.1)"}
