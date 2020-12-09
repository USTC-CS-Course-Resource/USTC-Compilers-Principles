; ModuleID = 'step3/func1.c'
source_filename = "step3/func1.c"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone
define dso_local float @fun1(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = sitofp i32 %3 to float
  ret float %4
}

; Function Attrs: noinline nounwind optnone
define dso_local double @fun2(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = sitofp i32 %3 to double
  ret double %4
}

; Function Attrs: noinline nounwind optnone
define dso_local void @main() #0 {
  %1 = alloca float, align 4
  %2 = alloca double, align 8
  store float 0x400CCCCCC0000000, float* %1, align 4
  store double 5.700000e+00, double* %2, align 8
  %3 = load float, float* %1, align 4
  %4 = fptosi float %3 to i32
  %5 = call float @fun1(i32 %4)
  %6 = load double, double* %2, align 8
  %7 = fptosi double %6 to i32
  %8 = call double @fun2(i32 %7)
  ret void
}

attributes #0 = { noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="i686" "target-features"="+cx8,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"NumRegisterParameters", i32 0}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{!"clang version 10.0.0-4ubuntu1 "}
