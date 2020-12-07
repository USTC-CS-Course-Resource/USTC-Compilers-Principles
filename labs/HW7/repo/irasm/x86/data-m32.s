	.file	"data.c"
	.text
	.data
	.align 4
	.type	aa, @object
	.size	aa, 4
aa:
	.long	10
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
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movw	$40, -2(%ebp)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	func, .-func
	.data
	.align 4
	.type	cc.1413, @object
	.size	cc.1413, 4
cc.1413:
	.long	30
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~16.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
