	.arch armv8-a
	.file	"data.c"
	.data
	.align	3
	.type	aa, %object
	.size	aa, 8
aa:
	.xword	10
	.global	bb
	.align	1
	.type	bb, %object
	.size	bb, 2
bb:
	.hword	20
	.text
	.align	2
	.global	func
	.type	func, %function
func:
	sub	sp, sp, #16
	mov	w0, 40
	strh	w0, [sp, 14]
	nop
	add	sp, sp, 16
	ret
	.size	func, .-func
	.data
	.align	3
	.type	cc.2807, %object
	.size	cc.2807, 8
cc.2807:
	.xword	30
	.ident	"GCC: (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
