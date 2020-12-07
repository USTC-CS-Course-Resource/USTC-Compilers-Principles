	.arch armv8-a
	.file	"control.c"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	sub	sp, sp, #16
	str	wzr, [sp, 12]
	ldr	w0, [sp, 12]
	cmp	w0, 0
	bne	.L8
.L6:
	ldr	w0, [sp, 12]
	cmp	w0, 5
	beq	.L9
	b	.L4
.L5:
	ldr	w0, [sp, 12]
	add	w0, w0, 1
	str	w0, [sp, 12]
.L4:
	ldr	w0, [sp, 12]
	cmp	w0, 4
	ble	.L5
	b	.L6
.L9:
	nop
.L8:
	nop
	add	sp, sp, 16
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
