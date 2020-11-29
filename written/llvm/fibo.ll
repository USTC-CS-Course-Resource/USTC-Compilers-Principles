define i32 @fib(i32 %0) {
    %2 = alloca i32, align 4    ; 为 n 申请空间
    %3 = alloca i32, align 4    ; 为 r 申请空间
    store i32 %0, i32* %2, align 4
    %4 = load i32, i32* %2, align 4

    %5 = icmp eq i32 %4, 0  ; n 与 0 判等
    br i1 %5, label %6, label %7
6:
    store i32 0, i32* %3, align 4
    br label %16
7:
    %8 = icmp eq i32 %4, 1  ; n 与 1 判等
    br i1 %8, label %9, label %10
9:
    store i32 1, i32* %3, align 4
    br label %16
10:
    %11 = sub i32 %4, 1
    %12 = call i32 @fib(i32 %11)    ; fab(n-1)
    %13 = sub i32 %4, 2
    %14 = call i32 @fib(i32 %13)    ; fab(n-2)
    %15 = add i32 %12, %14
    store i32 %15, i32* %3, align 4
    br label %16
16:
    %17 = load i32, i32* %3, align 4
    ret i32 %17
}

define dso_local i32 @main() #0 {
    %1 = alloca i32, align 4    ; x
    store i32 0, i32* %1, align 4
    %2 = alloca float, align 4  ; n
    store float 8.0, float* %2, align 4
    %3 = alloca i32, align 4    ; i
    store i32 1, i32* %3, align 4
    br label %4
4:
    %5 = load float, float* %2, align 4
    %6 = fptosi float %5 to i32 ; 浮点数转整数
    %7 = load i32, i32* %3, align 4
    %8 = icmp slt i32 %7, %6
    br i1 %8, label %9, label %14
9:
    %10 = load i32, i32* %1, align 4    ;   \
    %11 = call i32 @fib(i32 %7)         ;    |  x += fib(i)
    %12 = add i32 %10, %11              ;    |
    store i32 %12, i32* %1, align 4     ;   /
    ; ++i
    %13 = add i32 %7, 1
    store i32 %13, i32* %3, align 4
    br label %4
14:
    %15 = load i32, i32* %1, align 4
    ret i32 %15
}
