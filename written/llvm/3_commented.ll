; ModuleID = '3.c'
source_filename = "3.c" ; 定义了源文件
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128" ; 指定数据布局
target triple = "x86_64-pc-linux-gnu" ; 目标

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1 ; 常量字符串 "%d\n"

; Function Attrs: noinline nounwind optnone uwtable
; 函数定义
define dso_local i32 @factorial(i32 %0) #0 {
  %2 = alloca i32, align 4  ; 返回值指针
  %3 = alloca i32, align 4  ; %3 为指向参数 %0 的指针
  store i32 %0, i32* %3, align 4  ; *%3 = *%0
  %4 = load i32, i32* %3, align 4 ; %4 = *%3 = n
  %5 = icmp eq i32 %4, 0  ; n 与 0 判等
  br i1 %5, label %6, label %7  ; 分支, n == 0 则到6, 否则到7

6:                                                ; preds = %1
  store i32 1, i32* %2, align 4 ; 返回值设置为1
  br label %13  ; 结束, 跳到13

7:                                                ; preds = %1
  %8 = load i32, i32* %3, align 4 ; %8 = n;
  %9 = load i32, i32* %3, align 4 ; %9 = n;
  %10 = sub nsw i32 %9, 1 ; %10 = %9-1, 其中 nsw 表示 no signed wrap, 即发生有符号溢出结果就是 poison value
  %11 = call i32 @factorial(i32 %10)  ; 递归调用 factorial
  %12 = mul nsw i32 %8, %11 ; 将返回值和 n 相乘
  store i32 %12, i32* %2, align 4 ; 存返回值
  br label %13  ; 结束, 跳到13

13:                                               ; preds = %7, %6
  %14 = load i32, i32* %2, align 4  ; 读取返回值到 %14
  ret i32 %14 ; 返回
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4  ; 分配 int a 的空间
  %2 = call i32 @factorial(i32 5) ; 函数调用, 即 factorial(5)
  store i32 %2, i32* %1, align 4  ; a = 返回值%2
  %3 = load i32, i32* %1, align 4 ; %3 = a
  ; 调用 printf
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 %3)
  ret i32 0 ; 返回
}

; 声明外部函数 printf
declare dso_local i32 @printf(i8*, ...) #1

; 指定函数的 attributes
attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

; 元数据: 附加于此来传达多余信息, 有助于优化和生成代码
!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}
