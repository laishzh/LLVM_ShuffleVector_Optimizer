; ModuleID = 'a.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@main.a = private unnamed_addr constant [64 x i8] c"\01\02\03\04\05\06\07\08\09\10\11\12\13\14\15\16\17\18\19 !\22#$%&'()0123456789@ABCDEFGHIPQRSTUVWXY`abcd", align 16
@.str = private unnamed_addr constant [23 x i8] c"Before Shuffle: Begin\0A\00", align 1
@.str1 = private unnamed_addr constant [41 x i8] c"%02X %02X %02X %02X %02X %02X %02X %02X\0A\00", align 1
@.str2 = private unnamed_addr constant [22 x i8] c"Before Shuffle: End\0A\0A\00", align 1
@.str3 = private unnamed_addr constant [22 x i8] c"After Shuffle: Begin\0A\00", align 1
@.str4 = private unnamed_addr constant [20 x i8] c"After Shuffle: End\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %a = alloca [64 x i8], align 16
  %i = alloca i32, align 4
  store i32 0, i32* %1
  %2 = bitcast [64 x i8]* %a to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* getelementptr inbounds ([64 x i8]* @main.a, i32 0, i32 0), i64 64, i32 16, i1 false)
  store i32 0, i32* %i, align 4
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %4

; <label>:4                                       ; preds = %65, %0
  %5 = load i32* %i, align 4
  %6 = icmp ult i32 %5, 8
  br i1 %6, label %7, label %68

; <label>:7                                       ; preds = %4
  %8 = load i32* %i, align 4
  %9 = mul i32 8, %8
  %10 = add i32 %9, 0
  %11 = zext i32 %10 to i64
  %12 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %11
  %13 = load i8* %12, align 1
  %14 = zext i8 %13 to i32
  %15 = load i32* %i, align 4
  %16 = mul i32 8, %15
  %17 = add i32 %16, 1
  %18 = zext i32 %17 to i64
  %19 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %18
  %20 = load i8* %19, align 1
  %21 = zext i8 %20 to i32
  %22 = load i32* %i, align 4
  %23 = mul i32 8, %22
  %24 = add i32 %23, 2
  %25 = zext i32 %24 to i64
  %26 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %25
  %27 = load i8* %26, align 1
  %28 = zext i8 %27 to i32
  %29 = load i32* %i, align 4
  %30 = mul i32 8, %29
  %31 = add i32 %30, 3
  %32 = zext i32 %31 to i64
  %33 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %32
  %34 = load i8* %33, align 1
  %35 = zext i8 %34 to i32
  %36 = load i32* %i, align 4
  %37 = mul i32 8, %36
  %38 = add i32 %37, 4
  %39 = zext i32 %38 to i64
  %40 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %39
  %41 = load i8* %40, align 1
  %42 = zext i8 %41 to i32
  %43 = load i32* %i, align 4
  %44 = mul i32 8, %43
  %45 = add i32 %44, 5
  %46 = zext i32 %45 to i64
  %47 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %46
  %48 = load i8* %47, align 1
  %49 = zext i8 %48 to i32
  %50 = load i32* %i, align 4
  %51 = mul i32 8, %50
  %52 = add i32 %51, 6
  %53 = zext i32 %52 to i64
  %54 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %53
  %55 = load i8* %54, align 1
  %56 = zext i8 %55 to i32
  %57 = load i32* %i, align 4
  %58 = mul i32 8, %57
  %59 = add i32 %58, 7
  %60 = zext i32 %59 to i64
  %61 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %60
  %62 = load i8* %61, align 1
  %63 = zext i8 %62 to i32
  %64 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([41 x i8]* @.str1, i32 0, i32 0), i32 %14, i32 %21, i32 %28, i32 %35, i32 %42, i32 %49, i32 %56, i32 %63)

  %pre0 = bitcast [64 x i8]* %a to <64 x i8>*
  %p = load <64 x i8>* %pre0, align 1
  
  br label %65

; <label>:65                                      ; preds = %7
  %66 = load i32* %i, align 4
  %67 = add i32 %66, 1
  store i32 %67, i32* %i, align 4
  br label %4

; <label>:68                                      ; preds = %4
  %69 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str2, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %70

; <label>:70                                      ; preds = %74, %68
  %71 = load i32* %i, align 4
  %72 = icmp ult i32 %71, 100000
  br i1 %72, label %73, label %77

; <label>:73                                      ; preds = %70
  %w = shufflevector <64 x i8> %p, <64 x i8> undef,
     <64 x i32> <i32 63, i32 62, i32 61, i32 60, i32 59, i32 58, i32 57, i32 56, i32 55, i32 54, i32 53, i32 52, i32 51, i32 50, i32 49, i32 48, i32 47, i32 46, i32 45, i32 44, i32 43, i32 42, i32 41, i32 40, i32 39, i32 38, i32 37, i32 36, i32 35, i32 34, i32 33, i32 32, i32 31, i32 30, i32 29, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 22, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  br label %74

; <label>:74                                      ; preds = %73
  %75 = load i32* %i, align 4
  %76 = add i32 %75, 1
  store i32 %76, i32* %i, align 4
  br label %70

; <label>:77                                      ; preds = %70

  store <64 x i8> %w, <64 x i8>* %pre0, align 1
  %78 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str3, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %79

; <label>:79                                      ; preds = %140, %77
  %80 = load i32* %i, align 4
  %81 = icmp ult i32 %80, 8
  br i1 %81, label %82, label %143

; <label>:82                                      ; preds = %79
  %83 = load i32* %i, align 4
  %84 = mul i32 8, %83
  %85 = add i32 %84, 0
  %86 = zext i32 %85 to i64
  %87 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %86
  %88 = load i8* %87, align 1
  %89 = zext i8 %88 to i32
  %90 = load i32* %i, align 4
  %91 = mul i32 8, %90
  %92 = add i32 %91, 1
  %93 = zext i32 %92 to i64
  %94 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %93
  %95 = load i8* %94, align 1
  %96 = zext i8 %95 to i32
  %97 = load i32* %i, align 4
  %98 = mul i32 8, %97
  %99 = add i32 %98, 2
  %100 = zext i32 %99 to i64
  %101 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %100
  %102 = load i8* %101, align 1
  %103 = zext i8 %102 to i32
  %104 = load i32* %i, align 4
  %105 = mul i32 8, %104
  %106 = add i32 %105, 3
  %107 = zext i32 %106 to i64
  %108 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %107
  %109 = load i8* %108, align 1
  %110 = zext i8 %109 to i32
  %111 = load i32* %i, align 4
  %112 = mul i32 8, %111
  %113 = add i32 %112, 4
  %114 = zext i32 %113 to i64
  %115 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %114
  %116 = load i8* %115, align 1
  %117 = zext i8 %116 to i32
  %118 = load i32* %i, align 4
  %119 = mul i32 8, %118
  %120 = add i32 %119, 5
  %121 = zext i32 %120 to i64
  %122 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %121
  %123 = load i8* %122, align 1
  %124 = zext i8 %123 to i32
  %125 = load i32* %i, align 4
  %126 = mul i32 8, %125
  %127 = add i32 %126, 6
  %128 = zext i32 %127 to i64
  %129 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %128
  %130 = load i8* %129, align 1
  %131 = zext i8 %130 to i32
  %132 = load i32* %i, align 4
  %133 = mul i32 8, %132
  %134 = add i32 %133, 7
  %135 = zext i32 %134 to i64
  %136 = getelementptr inbounds [64 x i8]* %a, i32 0, i64 %135
  %137 = load i8* %136, align 1
  %138 = zext i8 %137 to i32
  %139 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([41 x i8]* @.str1, i32 0, i32 0), i32 %89, i32 %96, i32 %103, i32 %110, i32 %117, i32 %124, i32 %131, i32 %138)
  br label %140

; <label>:140                                     ; preds = %82
  %141 = load i32* %i, align 4
  %142 = add i32 %141, 1
  store i32 %142, i32* %i, align 4
  br label %79

; <label>:143                                     ; preds = %79
  %144 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str4, i32 0, i32 0))
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture, i64, i32, i1) #1

declare i32 @printf(i8*, ...) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf"="true" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf"="true" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
