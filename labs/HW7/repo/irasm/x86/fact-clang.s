	.text
	.file	"fact.c"
	.globl	f2                      # -- Begin function f2
	.p2align	4, 0x90
	.type	f2,@function
f2:                                     # @f2
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -8(%rbp)
	movl	-8(%rbp), %eax
	movl	%eax, f2.m
	cmpl	$0, f2.m
	jne	.LBB0_2
# %bb.1:
	movl	$1, -4(%rbp)
	jmp	.LBB0_3
.LBB0_2:
	movl	f2.m, %eax
	movl	f2.m, %ecx
	subl	$1, %ecx
	movl	%ecx, %edi
	movl	%eax, -12(%rbp)         # 4-byte Spill
	callq	f2
	movl	-12(%rbp), %ecx         # 4-byte Reload
	imull	%eax, %ecx
	movl	%ecx, -4(%rbp)
.LBB0_3:
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	f2, .Lfunc_end0-f2
	.cfi_endproc
                                        # -- End function
	.globl	f1                      # -- Begin function f1
	.p2align	4, 0x90
	.type	f1,@function
f1:                                     # @f1
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -8(%rbp)
	cmpl	$0, -8(%rbp)
	jne	.LBB1_2
# %bb.1:
	movl	$1, -4(%rbp)
	jmp	.LBB1_3
.LBB1_2:
	movl	-8(%rbp), %eax
	movl	-8(%rbp), %ecx
	subl	$1, %ecx
	movl	%ecx, %edi
	movl	%eax, -12(%rbp)         # 4-byte Spill
	callq	f1
	movl	-12(%rbp), %ecx         # 4-byte Reload
	imull	%eax, %ecx
	movl	%ecx, -4(%rbp)
.LBB1_3:
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	f1, .Lfunc_end1-f1
	.cfi_endproc
                                        # -- End function
	.globl	f3                      # -- Begin function f3
	.p2align	4, 0x90
	.type	f3,@function
f3:                                     # @f3
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	cmpl	$0, n
	jne	.LBB2_2
# %bb.1:
	movl	$1, -4(%rbp)
	jmp	.LBB2_3
.LBB2_2:
	movl	n, %eax
	movl	n, %ecx
	subl	$1, %ecx
	movl	%ecx, %edi
	movl	%eax, -8(%rbp)          # 4-byte Spill
	movb	$0, %al
	callq	f3
	movl	-8(%rbp), %ecx          # 4-byte Reload
	imull	%eax, %ecx
	movl	%ecx, -4(%rbp)
.LBB2_3:
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	f3, .Lfunc_end2-f3
	.cfi_endproc
                                        # -- End function
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
	subq	$16, %rsp
	movl	$3, %edi
	callq	f1
	movl	$3, %edi
	movl	%eax, -4(%rbp)          # 4-byte Spill
	callq	f2
	movabsq	$.L.str, %rdi
	movl	-4(%rbp), %esi          # 4-byte Reload
	movl	%eax, %edx
	movb	$0, %al
	callq	printf
	xorl	%ecx, %ecx
	movl	%eax, -8(%rbp)          # 4-byte Spill
	movl	%ecx, %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
	.cfi_endproc
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
