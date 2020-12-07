	.text
	.file	"data.c"
	.globl	func                    # -- Begin function func
	.p2align	4, 0x90
	.type	func,@function
func:                                   # @func
# %bb.0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$2, %esp
	movw	$40, -2(%ebp)
	addl	$2, %esp
	popl	%ebp
	retl
.Lfunc_end0:
	.size	func, .Lfunc_end0-func
                                        # -- End function
	.type	bb,@object              # @bb
	.data
	.globl	bb
	.p2align	1
bb:
	.short	20                      # 0x14
	.size	bb, 2

	.type	func.cc,@object         # @func.cc
	.p2align	2
func.cc:
	.long	30                      # 0x1e
	.size	func.cc, 4

	.ident	"Ubuntu clang version 10.0.1-++20200618012851+f5a9c661a35-1~exp1~20200617233447.176 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
