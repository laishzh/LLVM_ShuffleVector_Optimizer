; RUN: llc < %s -mattr=+bmi2 | FileCheck %s

; CHECK: pextl
; CHECK: ret
define <32 x i1> @mypext(<32 x i1> %a) {
    %p = shufflevector <32 x i1> %a, <32 x i1> zeroinitializer,
                       <32 x i32>
         <i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32,
          i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32,
          i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32,
          i32 0, i32 4, i32 7, i32 8, i32 9, i32 10, i32 15, i32 20>
    ret <32 x i1> %p
}
