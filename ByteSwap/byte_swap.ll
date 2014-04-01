; ModuleID = 'loop.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %a = add i64 0, 123123123
  %arr = bitcast i64 %a to <8 x i8>
  store i32 0, i32* %1
  store i32 0, i32* %i, align 4
  store i32 0, i32* %i, align 4
  br label %2

; <label>:2                                       ; preds = %6, %0
  %3 = load i32* %i, align 4
  %4 = icmp slt i32 %3, 10000
  br i1 %4, label %5, label %9

; <label>:5                                       ; preds = %2
  %bs1 = bitcast <8 x i8> %arr to i64
  %bs2 = call i64 @llvm.bswap.i64(i64 %bs1)
  %bs3 = bitcast i64 %bs2 to <8 x i8>
  br label %6

; <label>:6                                       ; preds = %5
  %7 = load i32* %i, align 4
  %8 = add nsw i32 %7, 1
  store i32 %8, i32* %i, align 4
  br label %2

; <label>:9                                       ; preds = %2
  ret i32 0
}

declare i64 @llvm.bswap.i64(i64)
attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.5.0-1~exp1 (trunk) (based on LLVM 3.5.0)"}
