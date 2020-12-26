	.text
	.file	"data1.c"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	subl	$36, %esp
	movl	$1067030938, -8(%ebp)   # imm = 0x3F99999A
	movl	$1074318540, -12(%ebp)  # imm = 0x4008CCCC
	movl	$-858993459, -16(%ebp)  # imm = 0xCCCCCCCD
	flds	-8(%ebp)
	fnstcw	-30(%ebp)
	movzwl	-30(%ebp), %eax
	orl	$3072, %eax             # imm = 0xC00
                                        # kill: def $ax killed $ax killed $eax
	movw	%ax, -32(%ebp)
	fldcw	-32(%ebp)
	fistpl	-28(%ebp)
	fldcw	-30(%ebp)
	movl	-28(%ebp), %ecx
	fldl	-16(%ebp)
	fnstcw	-34(%ebp)
	movzwl	-34(%ebp), %edx
	orl	$3072, %edx             # imm = 0xC00
                                        # kill: def $dx killed $dx killed $edx
	movw	%dx, -36(%ebp)
	fldcw	-36(%ebp)
	fistpl	-24(%ebp)
	fldcw	-34(%ebp)
	movl	-24(%ebp), %esi
	addl	%esi, %ecx
	movl	%ecx, -20(%ebp)
	addl	$36, %esp
	popl	%esi
	popl	%ebp
	retl
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
