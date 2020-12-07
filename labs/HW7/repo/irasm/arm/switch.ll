; ModuleID = 'src/switch.c'
source_filename = "src/switch.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 50, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = load i32, i32* %2, align 4
  %5 = mul nsw i32 %3, %4
  switch i32 %5, label %11 [
    i32 10, label %6
    i32 80, label %7
    i32 50, label %8
    i32 70, label %9
    i32 20, label %10
  ]

6:                                                ; preds = %0
  store i32 10, i32* %2, align 4
  br label %12

7:                                                ; preds = %0
  store i32 80, i32* %2, align 4
  br label %12

8:                                                ; preds = %0
  store i32 50, i32* %2, align 4
  br label %12

9:                                                ; preds = %0
  store i32 70, i32* %2, align 4
  br label %12

10:                                               ; preds = %0
  store i32 20, i32* %2, align 4
  br label %12

11:                                               ; preds = %0
  store i32 40, i32* %2, align 4
  br label %12

12:                                               ; preds = %11, %10, %9, %8, %7, %6
  %13 = load i32, i32* %2, align 4
  %14 = load i32, i32* %2, align 4
  %15 = mul nsw i32 %13, %14
  switch i32 %15, label %23 [
    i32 7, label %16
    i32 1, label %17
    i32 6, label %18
    i32 9, label %19
    i32 5, label %20
    i32 10, label %21
    i32 2, label %22
  ]

16:                                               ; preds = %12
  store i32 7, i32* %2, align 4
  br label %24

17:                                               ; preds = %12
  store i32 1, i32* %2, align 4
  br label %24

18:                                               ; preds = %12
  store i32 6, i32* %2, align 4
  br label %24

19:                                               ; preds = %12
  store i32 9, i32* %2, align 4
  br label %24

20:                                               ; preds = %12
  store i32 5, i32* %2, align 4
  br label %24

21:                                               ; preds = %12
  store i32 10, i32* %2, align 4
  br label %24

22:                                               ; preds = %12
  store i32 2, i32* %2, align 4
  br label %24

23:                                               ; preds = %12
  store i32 40, i32* %2, align 4
  br label %24

24:                                               ; preds = %23, %22, %21, %20, %19, %18, %17, %16
  %25 = load i32, i32* %1, align 4
  ret i32 %25
}

attributes #0 = { noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.1 "}
