; ModuleID = '2.c'
source_filename = "2.c" ; 定义了源文件
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128" ; 指定数据布局
target triple = "x86_64-pc-linux-gnu" ; 目标

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1 ; 字符串常量 "%d\n"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4  ; 返回值地址申请
  %2 = alloca i32, align 4  ; i 地址申请
  store i32 0, i32* %1, align 4 ; *%1 = 0
  store i32 0, i32* %2, align 4 ; *%2 = 0
  br label %3 ; 跳转到3

3:                                                ; preds = %9, %0
  %4 = load i32, i32* %2, align 4 ; %4 = *%2 = 0;
  %5 = icmp slt i32 %4, 10  ; %4(即i) 和 10 比较是否小于
  br i1 %5, label %6, label %12 ; 如果 i < 10, 就跳转到6, 否则跳转12

6:                                                ; preds = %3
  %7 = load i32, i32* %2, align 4 ; %7 = *%2
  ; 输出 i
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 %7)
  br label %9 ; 跳转到9

9:                                                ; preds = %6
  %10 = load i32, i32* %2, align 4  ; %10 = *%2
  %11 = add nsw i32 %10, 1  ; %11 = %10 + 1
  store i32 %11, i32* %2, align 4 ; 把加法结果(i+1)存回去
  br label %3 ; 跳转到3

12:                                               ; preds = %3
  %13 = load i32, i32* %1, align 4  ; 读入返回值
  ret i32 %13 ; 返回
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
