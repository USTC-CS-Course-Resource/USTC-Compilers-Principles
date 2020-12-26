	.arch armv8-a
	.file	"func1.c"
	.text
	.align	2
	.global	fun1
	.type	fun1, %function
fun1:
	sub	sp, sp, #16
	str	w0, [sp, 12]
	ldr	w0, [sp, 12]
	scvtf	s0, w0
	add	sp, sp, 16
	ret
	.size	fun1, .-fun1
	.align	2
	.global	fun2
	.type	fun2, %function
fun2:
	sub	sp, sp, #16
	str	w0, [sp, 12]
	ldr	w0, [sp, 12]
	scvtf	d0, w0
	add	sp, sp, 16
	ret
	.size	fun2, .-fun2
	.align	2
	.global	main
	.type	main, %function
main:
	stp	x29, x30, [sp, -32]!
	add	x29, sp, 0
	ldr	w0, .LC0
	str	w0, [x29, 20]
	ldr	x0, .LC1
	str	x0, [x29, 24]
	ldr	s0, [x29, 20]
	fcvtzs	w0, s0
	bl	fun1
	ldr	d0, [x29, 24]
	fcvtzs	w0, d0
	bl	fun2
	nop
	ldp	x29, x30, [sp], 32
	ret
	.size	main, .-main
	.align	2
.LC0:
	.word	1080452710
	.align	3
.LC1:
	.word	3435973837
	.word	1075236044
	.ident	"GCC: (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
