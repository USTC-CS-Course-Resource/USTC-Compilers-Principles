	.text
	.file	"control.c"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%eax
	movl	$0, -4(%ebp)
	cmpl	$0, -4(%ebp)
	jne	.LBB0_11
# %bb.1:
	jmp	.LBB0_2
.LBB0_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_5 Depth 2
	cmpl	$5, -4(%ebp)
	jne	.LBB0_4
# %bb.3:
	jmp	.LBB0_10
.LBB0_4:                                #   in Loop: Header=BB0_2 Depth=1
	jmp	.LBB0_5
.LBB0_5:                                #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$5, -4(%ebp)
	jge	.LBB0_8
# %bb.6:                                #   in Loop: Header=BB0_5 Depth=2
	jmp	.LBB0_7
.LBB0_7:                                #   in Loop: Header=BB0_5 Depth=2
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -4(%ebp)
	jmp	.LBB0_5
.LBB0_8:                                #   in Loop: Header=BB0_2 Depth=1
	jmp	.LBB0_9
.LBB0_9:                                #   in Loop: Header=BB0_2 Depth=1
	jmp	.LBB0_2
.LBB0_10:
	jmp	.LBB0_11
.LBB0_11:
	addl	$4, %esp
	popl	%ebp
	retl
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
