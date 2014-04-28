; ModuleID = 'a.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@main.a = private unnamed_addr constant [8 x i64] [i64 286397464, i64 555885608, i64 825373752, i64 1094861896, i64 1364350040, i64 1633838184, i64 1903326328, i64 2172814472], align 16
@.str = private unnamed_addr constant [25 x i8] c"%02lX %02lX %02lX %02lX\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %tmp = alloca i64, align 8
  %1 = alloca i32, align 4
  %a = alloca [8 x i64], align 16
  %i = alloca i32, align 4
  store i32 0, i32* %1
  %2 = bitcast [8 x i64]* %a to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* bitcast ([8 x i64]* @main.a to i8*), i64 64, i32 16, i1 false)
  %3 = getelementptr inbounds [8 x i64]* %a, i32 0, i64 0
  store i64 0, i64* %tmp, align 8
  %4 = getelementptr inbounds [8 x i64]* %a, i32 0, i64 1
  store i64 1, i64* %tmp, align 8
  %5 = getelementptr inbounds [8 x i64]* %a, i32 0, i64 2
  store i64 2, i64* %tmp, align 8
  %6 = getelementptr inbounds [8 x i64]* %a, i32 0, i64 3
  store i64 3, i64* %tmp, align 8
  %7 = getelementptr inbounds [8 x i64]* %a, i32 0, i64 4
  store i64 4, i64* %tmp, align 8
  %8 = getelementptr inbounds [8 x i64]* %a, i32 0, i64 5
  store i64 5, i64* %tmp, align 8
  %9 = getelementptr inbounds [8 x i64]* %a, i32 0, i64 6
  store i64 6, i64* %tmp, align 8
  %10 = getelementptr inbounds [8 x i64]* %a, i32 0, i64 7
  store i64 7, i64* %tmp, align 8
  ;%p0 = bitcast [8 x i64]* %a to <64 x i8>*
  ;%p1 = load <64 x i8>* %p0
  %p0 = bitcast [8 x i64]* %a to <8 x i8>*
  %p1 = load <8 x i8>* %p0

  store i32 0, i32* %i, align 4
  store i32 0, i32* %i, align 4
  br label %11

; <label>:11                                      ; preds = %15, %0
  %12 = load i32* %i, align 4
  %13 = icmp ult i32 %12, 100000
  br i1 %13, label %14, label %18

; <label>:14                                      ; preds = %11
  ;%t = shufflevector <64 x i8> %p1, <64 x i8> undef,
  ;   <64 x i32> <i32 63, i32 62, i32 61, i32 60, i32 59, i32 58, i32 57, i32 56, i32 55, i32 54, i32 53, i32 52, i32 51, i32 50, i32 49, i32 48, i32 47, i32 46, i32 45, i32 44, i32 43, i32 42, i32 41, i32 40, i32 39, i32 38, i32 37, i32 36, i32 35, i32 34, i32 33, i32 32, i32 31, i32 30, i32 29, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 22, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  %t = shufflevector <8 x i8> %p1, <8 x i8> undef,
     ;<8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
     <8 x i32> <i32 0, i32 1, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  br label %15

; <label>:15                                      ; preds = %14
  %16 = load i32* %i, align 4
  %17 = add i32 %16, 1
  store i32 %17, i32* %i, align 4
  br label %11

; <label>:18                                      ; preds = %11
  store i32 0, i32* %i, align 4
  br label %19

; <label>:19                                      ; preds = %47, %18
  %20 = load i32* %i, align 4
  %21 = icmp ult i32 %20, 8
  br i1 %21, label %22, label %50

; <label>:22                                      ; preds = %19
  ;store <64 x i8> %t, <64 x i8>*%p0
  store <8 x i8> %t, <8 x i8>*%p0
  %23 = load i32* %i, align 4
  %24 = zext i32 %23 to i64
  %25 = getelementptr inbounds [8 x i64]* %a, i32 0, i64 %24
  %26 = load i64* %25, align 8
  %27 = and i64 %26, 4278190080
  %28 = lshr i64 %27, 24
  %29 = load i32* %i, align 4
  %30 = zext i32 %29 to i64
  %31 = getelementptr inbounds [8 x i64]* %a, i32 0, i64 %30
  %32 = load i64* %31, align 8
  %33 = and i64 %32, 16711680
  %34 = lshr i64 %33, 16
  %35 = load i32* %i, align 4
  %36 = zext i32 %35 to i64
  %37 = getelementptr inbounds [8 x i64]* %a, i32 0, i64 %36
  %38 = load i64* %37, align 8
  %39 = and i64 %38, 65280
  %40 = lshr i64 %39, 8
  %41 = load i32* %i, align 4
  %42 = zext i32 %41 to i64
  %43 = getelementptr inbounds [8 x i64]* %a, i32 0, i64 %42
  %44 = load i64* %43, align 8
  %45 = and i64 %44, 255
  %46 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([25 x i8]* @.str, i32 0, i32 0), i64 %28, i64 %34, i64 %40, i64 %45)
  br label %47

; <label>:47                                      ; preds = %22
  %48 = load i32* %i, align 4
  %49 = add i32 %48, 1
  store i32 %49, i32* %i, align 4
  br label %19

; <label>:50                                      ; preds = %19
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture, i64, i32, i1) #1

declare i32 @printf(i8*, ...) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf"="true" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf"="true" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
