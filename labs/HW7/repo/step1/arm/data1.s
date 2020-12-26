	.arch armv8-a
	.file	"data1.c"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	sub	sp, sp, #16
	ldr	w0, .LC0
	str	w0, [sp]
	ldr	x0, .LC1
	str	x0, [sp, 8]
	ldr	s0, [sp]
	fcvtzs	w1, s0
	ldr	d0, [sp, 8]
	fcvtzs	w0, d0
	add	w0, w1, w0
	str	w0, [sp, 4]
	nop
	add	sp, sp, 16
	ret
	.size	main, .-main
	.align	2
.LC0:
	.word	1067030938
	.align	3
.LC1:
	.word	3435973837
	.word	1074318540
	.ident	"GCC: (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
