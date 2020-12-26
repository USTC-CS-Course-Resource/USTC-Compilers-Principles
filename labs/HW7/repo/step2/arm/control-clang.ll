; ModuleID = 'step2/control.c'
source_filename = "step2/control.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone
define dso_local void @main() #0 {
  %1 = alloca i32, align 4          ; 
  store i32 0, i32* %1, align 4     ; i = 0
  %2 = load i32, i32* %1, align 4   ;
  %3 = icmp eq i32 %2, 0            ; if (i == 0)
  br i1 %3, label %4, label %20     ;   goto %4, else goto %20

4:                                                ; preds = %0
  br label %5                       ; while(1)

5:                                                ; preds = %4, %18
  %6 = load i32, i32* %1, align 4   ;
  %7 = icmp eq i32 %6, 5            ; if (i == 5)
  br i1 %7, label %8, label %9      ;   break; else for loop

8:                                                ; preds = %5
  br label %19                      ; break;

9:                                                ; preds = %5
  br label %10                      ; goto for loop

10:                                               ; preds = %14, %9
  %11 = load i32, i32* %1, align 4  ; 
  %12 = icmp slt i32 %11, 5         ; is i < 5 ?
  br i1 %12, label %13, label %17   ;  goto %13 else goto %17

13:                                               ; preds = %10
  br label %14                      ; goto %14

14:                                               ; preds = %13
  %15 = load i32, i32* %1, align 4  ;
  %16 = add nsw i32 %15, 1          ; i++
  store i32 %16, i32* %1, align 4   ;
  br label %10                      ; goto start of for loop 

17:                                               ; preds = %10
  br label %18

18:                                               ; preds = %17
  br label %5

19:                                               ; preds = %8
  br label %20

20:                                               ; preds = %19, %0
  ret void
}

attributes #0 = { noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.1 "}
