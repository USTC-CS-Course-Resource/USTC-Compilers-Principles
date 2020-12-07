	.arch armv8-a
	.file	"switch.c"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	sub	sp, sp, #16
	mov	w0, 50
	str	w0, [sp, 12]
	ldr	w1, [sp, 12]
	ldr	w0, [sp, 12]
	mul	w0, w1, w0				; w0 和 w1 分别是 50 和 50, 这句是为了计算 i*i
	cmp	w0, 50					; 比较 i*i 和 50 的大小关系
	beq	.L3						; 如果 i*i == 50, 跳转到 .L3
	cmp	w0, 50					; 比较 i*i 和 50 的大小关系
	bgt	.L4						; 如果 i*i > 50, 跳转到 .L4
	cmp	w0, 10					; 比较 i*i 和 10
	beq	.L5						; 如果 i*i == 10, 跳转到 .L5
	cmp	w0, 20					; 比较 i*i 和 20
	beq	.L6						; 如果 i*i == 20, 跳转到 .L6
	b	.L2
.L4:
	cmp	w0, 70					; 比较 i*i 和 70
	beq	.L7						; 如果 i*i == 70, 跳转到 .L7
	cmp	w0, 80					; 比较 i*i 和 80
	beq	.L8						; 如果 i*i == 80, 跳转到 .L8
	b	.L2
.L5:
	mov	w0, 10					; 如果跳转到此说明 i*i==10, 故赋值 10 给 i
	str	w0, [sp, 12]			; 然后把 i 存回内存
	b	.L9						; 相当于 break
.L8:
	mov	w0, 80
	str	w0, [sp, 12]
	b	.L9
.L3:
	mov	w0, 50
	str	w0, [sp, 12]
	b	.L9
.L7:
	mov	w0, 70
	str	w0, [sp, 12]
	b	.L9
.L6:
	mov	w0, 20
	str	w0, [sp, 12]
	b	.L9
.L2:
	mov	w0, 40
	str	w0, [sp, 12]
.L9:
	ldr	w1, [sp, 12]					; i = w1 = 50
	ldr	w0, [sp, 12]					; i = w0 = 50
	mul	w0, w1, w0						; i*i = w1 * w0
	sub	w0, w0, #1						; w0 = i*i-1
	cmp	w0, 9							; i*i-1 和 9 比较 
	bhi	.L10							; 如果大于, 则跳转到 default(.L10)
	adrp	x1, .L12					; 读取 .L12 的地址
	add	x1, x1, :lo12:.L12				; 
	ldr	w0, [x1,w0,uxtw #2]				; 从x1开始w0*4处取值. 这里uxtw #2 是扩展, 相当于左移两位, 这里是为了取地址.
	adr	x1, .Lrtx12						; 取 .Lrtx12 地址 到 x1
	add	x0, x1, w0, sxtw #2				; 计算跳转目标为 x0=x1 + w0*4
	br	x0								; 跳转到 x0
.Lrtx12:
	.section	.rodata
	.align	0
	.align	2
.L12:									; 这就是一系列跳转表
	.word	(.L11 - .Lrtx12) / 4
	.word	(.L13 - .Lrtx12) / 4
	.word	(.L10 - .Lrtx12) / 4
	.word	(.L10 - .Lrtx12) / 4
	.word	(.L14 - .Lrtx12) / 4
	.word	(.L15 - .Lrtx12) / 4
	.word	(.L16 - .Lrtx12) / 4
	.word	(.L10 - .Lrtx12) / 4
	.word	(.L17 - .Lrtx12) / 4
	.word	(.L18 - .Lrtx12) / 4
	.text
.L16:
	mov	w0, 7							; 如果跳转到这, 则 i = w0 = 7
	str	w0, [sp, 12]					; 存数 i
	b	.L19							; 跳转, 相当于 break
.L11:
	mov	w0, 1
	str	w0, [sp, 12]
	b	.L19
.L15:
	mov	w0, 6
	str	w0, [sp, 12]
	b	.L19
.L17:
	mov	w0, 9
	str	w0, [sp, 12]
	b	.L19
.L14:
	mov	w0, 5
	str	w0, [sp, 12]
	b	.L19
.L18:
	mov	w0, 10
	str	w0, [sp, 12]
	b	.L19
.L13:
	mov	w0, 2
	str	w0, [sp, 12]
	b	.L19
.L10:
	mov	w0, 40
	str	w0, [sp, 12]
.L19:
	mov	w0, 0
	add	sp, sp, 16
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
