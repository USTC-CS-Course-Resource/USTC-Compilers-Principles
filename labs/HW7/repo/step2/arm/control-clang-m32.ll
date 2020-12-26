; ModuleID = 'step2/control.c'
source_filename = "step2/control.c"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "armv4t-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone
define dso_local arm_aapcscc void @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = load i32, i32* %1, align 4
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %4, label %20

4:                                                ; preds = %0
  br label %5

5:                                                ; preds = %4, %18
  %6 = load i32, i32* %1, align 4
  %7 = icmp eq i32 %6, 5
  br i1 %7, label %8, label %9

8:                                                ; preds = %5
  br label %19

9:                                                ; preds = %5
  br label %10

10:                                               ; preds = %14, %9
  %11 = load i32, i32* %1, align 4
  %12 = icmp slt i32 %11, 5
  br i1 %12, label %13, label %17

13:                                               ; preds = %10
  br label %14

14:                                               ; preds = %13
  %15 = load i32, i32* %1, align 4
  %16 = add nsw i32 %15, 1
  store i32 %16, i32* %1, align 4
  br label %10

17:                                               ; preds = %10
  br label %18

18:                                               ; preds = %17
  br label %5

19:                                               ; preds = %8
  br label %20

20:                                               ; preds = %19, %0
  ret void
}

attributes #0 = { noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="arm7tdmi" "target-features"="+armv4t,+soft-float,+strict-align,-crypto,-d32,-dotprod,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fp64,-fpregs,-fullfp16,-mve,-mve.fp,-neon,-thumb-mode,-vfp2,-vfp2sp,-vfp3,-vfp3d16,-vfp3d16sp,-vfp3sp,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" "unsafe-fp-math"="false" "use-soft-float"="true" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"min_enum_size", i32 4}
!2 = !{!"clang version 10.0.1 "}
