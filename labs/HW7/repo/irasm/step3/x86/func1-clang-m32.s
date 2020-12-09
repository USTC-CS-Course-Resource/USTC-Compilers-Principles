	.text
	.file	"func1.c"
	.globl	fun1                    # -- Begin function fun1
	.p2align	4, 0x90
	.type	fun1,@function
fun1:                                   # @fun1
# %bb.0:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%eax
	movl	8(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	%ecx, -4(%ebp)
	fildl	-4(%ebp)
	addl	$4, %esp
	popl	%ebp
	retl
.Lfunc_end0:
	.size	fun1, .Lfunc_end0-fun1
                                        # -- End function
	.globl	fun2                    # -- Begin function fun2
	.p2align	4, 0x90
	.type	fun2,@function
fun2:                                   # @fun2
# %bb.0:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%eax
	movl	8(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	%ecx, -4(%ebp)
	fildl	-4(%ebp)
	addl	$4, %esp
	popl	%ebp
	retl
.Lfunc_end1:
	.size	fun2, .Lfunc_end1-fun2
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	$1080452710, -4(%ebp)   # imm = 0x40666666
	movl	$1075236044, -12(%ebp)  # imm = 0x4016CCCC
	movl	$-858993459, -16(%ebp)  # imm = 0xCCCCCCCD
	flds	-4(%ebp)
	fnstcw	-26(%ebp)
	movzwl	-26(%ebp), %eax
	orl	$3072, %eax             # imm = 0xC00
                                        # kill: def $ax killed $ax killed $eax
	movw	%ax, -28(%ebp)
	fldcw	-28(%ebp)
	fistpl	-24(%ebp)
	fldcw	-26(%ebp)
	movl	-24(%ebp), %ecx
	movl	%esp, %edx
	movl	%ecx, (%edx)
	calll	fun1
	fldl	-16(%ebp)
	fnstcw	-30(%ebp)
	movzwl	-30(%ebp), %ecx
	orl	$3072, %ecx             # imm = 0xC00
                                        # kill: def $cx killed $cx killed $ecx
	movw	%cx, -32(%ebp)
	fldcw	-32(%ebp)
	fistpl	-20(%ebp)
	fldcw	-30(%ebp)
	movl	-20(%ebp), %edx
	movl	%edx, (%esp)
	fstps	-36(%ebp)               # 4-byte Folded Spill
	calll	fun2
	fstp	%st(0)
	addl	$40, %esp
	popl	%ebp
	retl
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        # -- End function
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym fun1
	.addrsig_sym fun2
