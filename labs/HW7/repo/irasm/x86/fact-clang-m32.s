	.text
	.file	"fact.c"
	.globl	f2                      # -- Begin function f2
	.p2align	4, 0x90
	.type	f2,@function
f2:                                     # @f2
# %bb.0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	8(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	%ecx, f2.m
	cmpl	$0, f2.m
	jne	.LBB0_2
# %bb.1:
	movl	$1, -4(%ebp)
	jmp	.LBB0_3
.LBB0_2:
	movl	f2.m, %eax
	movl	f2.m, %ecx
	subl	$1, %ecx
	movl	%ecx, (%esp)
	movl	%eax, -8(%ebp)          # 4-byte Spill
	calll	f2
	movl	-8(%ebp), %ecx          # 4-byte Reload
	imull	%eax, %ecx
	movl	%ecx, -4(%ebp)
.LBB0_3:
	movl	-4(%ebp), %eax
	addl	$24, %esp
	popl	%ebp
	retl
.Lfunc_end0:
	.size	f2, .Lfunc_end0-f2
                                        # -- End function
	.globl	f1                      # -- Begin function f1
	.p2align	4, 0x90
	.type	f1,@function
f1:                                     # @f1
# %bb.0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	8(%ebp), %eax
	cmpl	$0, 8(%ebp)
	jne	.LBB1_2
# %bb.1:
	movl	$1, -4(%ebp)
	jmp	.LBB1_3
.LBB1_2:
	movl	8(%ebp), %eax
	movl	8(%ebp), %ecx
	subl	$1, %ecx
	movl	%ecx, (%esp)
	movl	%eax, -8(%ebp)          # 4-byte Spill
	calll	f1
	movl	-8(%ebp), %ecx          # 4-byte Reload
	imull	%eax, %ecx
	movl	%ecx, -4(%ebp)
.LBB1_3:
	movl	-4(%ebp), %eax
	addl	$24, %esp
	popl	%ebp
	retl
.Lfunc_end1:
	.size	f1, .Lfunc_end1-f1
                                        # -- End function
	.globl	f3                      # -- Begin function f3
	.p2align	4, 0x90
	.type	f3,@function
f3:                                     # @f3
# %bb.0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	cmpl	$0, n
	jne	.LBB2_2
# %bb.1:
	movl	$1, -4(%ebp)
	jmp	.LBB2_3
.LBB2_2:
	movl	n, %eax
	movl	n, %ecx
	subl	$1, %ecx
	movl	%ecx, (%esp)
	movl	%eax, -8(%ebp)          # 4-byte Spill
	calll	f3
	movl	-8(%ebp), %ecx          # 4-byte Reload
	imull	%eax, %ecx
	movl	%ecx, -4(%ebp)
.LBB2_3:
	movl	-4(%ebp), %eax
	addl	$24, %esp
	popl	%ebp
	retl
.Lfunc_end2:
	.size	f3, .Lfunc_end2-f3
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$3, (%esp)
	calll	f1
	movl	$3, (%esp)
	movl	%eax, -4(%ebp)          # 4-byte Spill
	calll	f2
	leal	.L.str, %ecx
	movl	%ecx, (%esp)
	movl	-4(%ebp), %ecx          # 4-byte Reload
	movl	%ecx, 4(%esp)
	movl	%eax, 8(%esp)
	calll	printf
	xorl	%ecx, %ecx
	movl	%eax, -8(%ebp)          # 4-byte Spill
	movl	%ecx, %eax
	addl	$24, %esp
	popl	%ebp
	retl
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
                                        # -- End function
	.type	f2.m,@object            # @f2.m
	.local	f2.m
	.comm	f2.m,4,4
	.type	n,@object               # @n
	.data
	.globl	n
	.p2align	2
n:
	.long	3                       # 0x3
	.size	n, 4

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d, %d"
	.size	.L.str, 7

	.ident	"Ubuntu clang version 10.0.1-++20200618012851+f5a9c661a35-1~exp1~20200617233447.176 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym f2
	.addrsig_sym f1
	.addrsig_sym f3
	.addrsig_sym printf
	.addrsig_sym f2.m
	.addrsig_sym n
