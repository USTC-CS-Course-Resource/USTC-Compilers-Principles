	.text
	.file	"control.c"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	$0, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jne	.LBB0_11
# %bb.1:
	jmp	.LBB0_2
.LBB0_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_5 Depth 2
	cmpl	$5, -4(%rbp)
	jne	.LBB0_4
# %bb.3:
	jmp	.LBB0_10
.LBB0_4:                                #   in Loop: Header=BB0_2 Depth=1
	jmp	.LBB0_5
.LBB0_5:                                #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$5, -4(%rbp)
	jge	.LBB0_8
# %bb.6:                                #   in Loop: Header=BB0_5 Depth=2
	jmp	.LBB0_7
.LBB0_7:                                #   in Loop: Header=BB0_5 Depth=2
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB0_5
.LBB0_8:                                #   in Loop: Header=BB0_2 Depth=1
	jmp	.LBB0_9
.LBB0_9:                                #   in Loop: Header=BB0_2 Depth=1
	jmp	.LBB0_2
.LBB0_10:
	jmp	.LBB0_11
.LBB0_11:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
