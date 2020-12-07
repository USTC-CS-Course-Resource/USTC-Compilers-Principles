	.file	"data.c"
	.text
	.data
	.align 8
	.type	aa, @object
	.size	aa, 8
aa:
	.quad	10
	.globl	bb
	.align 2
	.type	bb, @object
	.size	bb, 2
bb:
	.value	20
	.text
	.globl	func
	.type	func, @function
func:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movw	$40, -2(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	func, .-func
	.data
	.align 8
	.type	cc.1796, @object
	.size	cc.1796, 8
cc.1796:
	.quad	30
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~16.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
