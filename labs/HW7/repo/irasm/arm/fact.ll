; ModuleID = 'src/fact.c'
source_filename = "src/fact.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

@f2.m = internal global i32 0, align 4
@n = dso_local global i32 3, align 4
@.str = private unnamed_addr constant [7 x i8] c"%d, %d\00", align 1

; Function Attrs: noinline nounwind optnone
define dso_local i32 @f2(i32 %0) #0 {     ; 函数声明
  %2 = alloca i32, align 4                ; 分配空间给 返回值
  %3 = alloca i32, align 4                ; 分配空间给 n
  store i32 %0, i32* %3, align 4          ; 存 n
  %4 = load i32, i32* %3, align 4         ; 取 n
  store i32 %4, i32* @f2.m, align 4       ; 存 n 到静态变量 @f2.m
  %5 = load i32, i32* @f2.m, align 4      ; 读 @f2.m 到 %5
  %6 = icmp eq i32 %5, 0                  ; 判 m == 0
  br i1 %6, label %7, label %8            ; 跳转

7:                                                ; preds = %1
  store i32 1, i32* %2, align 4           ; 存 1 到 %2
  br label %14                            ; 跳转到 return 1

8:                                                ; preds = %1
  %9 = load i32, i32* @f2.m, align 4      ; 取 @f2.m 到 %9
  %10 = load i32, i32* @f2.m, align 4     ; 取 @f2.m 到 %10
  %11 = sub nsw i32 %10, 1                ; 求 n-1
  %12 = call i32 @f2(i32 %11)             ; 调用 f2(n-1)
  %13 = mul nsw i32 %9, %12               ; n*f2(n-1)
  store i32 %13, i32* %2, align 4         ; 存计算结果到返回值地址
  br label %14                            ; 返回

14:                                               ; preds = %8, %7
  %15 = load i32, i32* %2, align 4        ; 读取返回值
  ret i32 %15                             ; 返回
}

; Function Attrs: noinline nounwind optnone
define dso_local i32 @f1(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  %4 = load i32, i32* %3, align 4
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %7

6:                                                ; preds = %1
  store i32 1, i32* %2, align 4
  br label %13

7:                                                ; preds = %1
  %8 = load i32, i32* %3, align 4
  %9 = load i32, i32* %3, align 4
  %10 = sub nsw i32 %9, 1
  %11 = call i32 @f1(i32 %10)
  %12 = mul nsw i32 %8, %11
  store i32 %12, i32* %2, align 4
  br label %13

13:                                               ; preds = %7, %6
  %14 = load i32, i32* %2, align 4
  ret i32 %14
}

; Function Attrs: noinline nounwind optnone
define dso_local i32 @f3() #0 {
  %1 = alloca i32, align 4
  %2 = load i32, i32* @n, align 4
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %4, label %5

4:                                                ; preds = %0
  store i32 1, i32* %1, align 4
  br label %11

5:                                                ; preds = %0
  %6 = load i32, i32* @n, align 4
  %7 = load i32, i32* @n, align 4
  %8 = sub nsw i32 %7, 1
  %9 = call i32 bitcast (i32 ()* @f3 to i32 (i32)*)(i32 %8)
  %10 = mul nsw i32 %6, %9
  store i32 %10, i32* %1, align 4
  br label %11

11:                                               ; preds = %5, %4
  %12 = load i32, i32* %1, align 4
  ret i32 %12
}

; Function Attrs: noinline nounwind optnone
define dso_local i32 @main() #0 {
  %1 = call i32 @f1(i32 3)    ; 调用函数 f1(3)
  %2 = call i32 @f2(i32 3)    ; 调用函数 f2(3)
  ; 调用函数 printf
  %3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i64 0, i64 0), i32 %1, i32 %2)
  ret i32 0                   ; 默认返回 0
}

declare dso_local i32 @printf(i8*, ...) #1

attributes #0 = { noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.1 "}
