	.text
	.file	"data.c"
	.globl	func                    # -- Begin function func
	.p2align	4, 0x90
	.type	func,@function
func:                                   # @func
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movw	$40, -2(%rbp)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	func, .Lfunc_end0-func
	.cfi_endproc
                                        # -- End function
	.type	bb,@object              # @bb
	.data
	.globl	bb
	.p2align	1
bb:
	.short	20                      # 0x14
	.size	bb, 2

	.type	func.cc,@object         # @func.cc
	.p2align	3
func.cc:
	.quad	30                      # 0x1e
	.size	func.cc, 8

	.ident	"Ubuntu clang version 10.0.1-++20200618012851+f5a9c661a35-1~exp1~20200617233447.176 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
