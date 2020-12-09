    .arch armv8-a
    .file	"fact.c"
    .text
    .align	2						;
    .global	f2						;
    .type	f2, %function			; 对函数定义的描述
f2:
    stp	x29, x30, [sp, -32]!		; 入栈指令
    add	x29, sp, 0					;
    str	w0, [x29, 28]				; 存 w0 (即n)
    adrp	x0, m.3259				; m.3259 地址读取
    add	x0, x0, :lo12:m.3259        ; 
    ldr	w1, [x29, 28]               ; 读取 n 到 w1
    str	w1, [x0]                    ; 存 w1 到 x0
    adrp	x0, m.3259              ; 读 m.3259 地址
    add	x0, x0, :lo12:m.3259        ;
    ldr	w0, [x0]                    ; 把 n 存到 m 的地址
    cmp	w0, 0                       ; 比较 n 和 0
    bne	.L2                         ; 不等则跳  .L2, 否则
    mov	w0, 1                       ; 赋值返回值 w0 为 1
    b	.L3                         ; 并跳转到 .L3 以返回
.L2:
    adrp	x0, m.3259              ;
    add	x0, x0, :lo12:m.3259        ; 获取 m 地址
    ldr	w0, [x0]                    ; 读取 m
    sub	w0, w0, #1                  ; 计算 m-1
    bl	f2                          ; 调用函数 f2
    mov	w1, w0                      ; 获取返回值
    adrp	x0, m.3259              ; 
    add	x0, x0, :lo12:m.3259        ; 获取 m 地址
    ldr	w0, [x0]                    ; 读 m
    mul	w0, w1, w0                  ; 做乘法并准备返回
.L3:
    ldp	x29, x30, [sp], 32          ; 出栈指令
    ret                             ; 返回
    .size	f2, .-f2                ; 符号大小
    .align	2
    .global	f1
    .type	f1, %function
f1:
    stp	x29, x30, [sp, -32]!
    add	x29, sp, 0
    str	w0, [x29, 28]
    ldr	w0, [x29, 28]
    cmp	w0, 0
    bne	.L5
    mov	w0, 1
    b	.L6
.L5:
    ldr	w0, [x29, 28]
    sub	w0, w0, #1
    bl	f1
    mov	w1, w0
    ldr	w0, [x29, 28]
    mul	w0, w1, w0
.L6:
    ldp	x29, x30, [sp], 32
    ret
    .size	f1, .-f1
    .global	n
    .data
    .align	2
    .type	n, %object
    .size	n, 4
n:
    .word	3
    .text
    .align	2
    .global	f3
    .type	f3, %function
f3:
    stp	x29, x30, [sp, -16]!
    add	x29, sp, 0
    adrp	x0, n
    add	x0, x0, :lo12:n
    ldr	w0, [x0]
    cmp	w0, 0
    bne	.L8
    mov	w0, 1
    b	.L9
.L8:
    adrp	x0, n
    add	x0, x0, :lo12:n
    ldr	w0, [x0]
    sub	w0, w0, #1
    bl	f3
    mov	w1, w0
    adrp	x0, n
    add	x0, x0, :lo12:n
    ldr	w0, [x0]
    mul	w0, w1, w0
.L9:
    ldp	x29, x30, [sp], 16
    ret
    .size	f3, .-f3
    .section	.rodata
    .align	3
.LC0:
    .string	"%d, %d"
    .text
    .align	2
    .global	main
    .type	main, %function
main:
    stp	x29, x30, [sp, -32]!
    add	x29, sp, 0
    str	x19, [sp, 16]
    mov	w0, 3                   ; w0 = 3
    bl	f1                      ; 调用 f1(3)
    mov	w19, w0                 ; 获取返回值 w19=f1(3)
    mov	w0, 3                   ; w0=3
    bl	f2                      ; 调用 f2(3)
    mov	w1, w0                  ; 获取返回值 w1 = f2(3)
    adrp	x0, .LC0            ; 获取页基址
    add	x0, x0, :lo12:.LC0      ; 计算.LC0 地址(即字符串 "%d, %d")
    mov	w2, w1                  ; 参数 f2(3)
    mov	w1, w19                 ; 传参 f1(3)
    bl	printf                  ; 调用 printf
    mov	w0, 0
    ldr	x19, [sp, 16]
    ldp	x29, x30, [sp], 32
    ret
    .size	main, .-main
    .local	m.3259
    .comm	m.3259,4,4
    .ident	"GCC: (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
    .section	.note.GNU-stack,"",@progbits
