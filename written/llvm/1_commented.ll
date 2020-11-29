; ModuleID = '1.c'
source_filename = "1.c" ; 定义了源文件
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128" ; 指定数据布局
target triple = "x86_64-pc-linux-gnu" ; 目标

@.str = private unnamed_addr constant [6 x i8] c"a==1\0A\00", align 1 ; 常量字符串 "a==1\n"
@.str.1 = private unnamed_addr constant [6 x i8] c"a!=1\0A\00", align 1 ; 常量字符串 "a!=1\n"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4  ; 用来返回0
  %2 = alloca i32, align 4  ; 分配 int a 的空间
  store i32 0, i32* %1, align 4 ; 用来返回的0
  store i32 1, i32* %2, align 4 ; a = 1
  %3 = load i32, i32* %2, align 4 ; %3=a 
  %4 = icmp eq i32 %3, 1  ; 比较 %3 和 1 大小
  br i1 %4, label %5, label %7  ; 根据 %4 中比较结果分支, 若比较结果为真, 则跳转到 %5, 否则 %7

5:                                                ; preds = %0
  ; 调用 printf 函数
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0))
  ; 结束分支, 跳到9
  br label %9

7:                                                ; preds = %0
  ; 调用 printf 函数
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0))
  ; 结束分支, 跳到9
  br label %9

9:                                                ; preds = %7, %5
  %10 = load i32, i32* %1, align 4  ; %10 = *%2 = 0
  ret i32 %10 ; 返回0
}

; 声明外部函数
declare dso_local i32 @printf(i8*, ...) #1  ; 

; 指定函数的 attributes
attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

; 元数据: 附加于此来传达多余信息, 有助于优化和生成代码
!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}
