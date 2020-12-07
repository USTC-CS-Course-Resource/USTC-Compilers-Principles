	.text
	.file	"switch.c"
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
	movl	$50, -8(%rbp)
	movl	-8(%rbp), %eax
	imull	%eax, %eax
	movl	%eax, %ecx
	subl	$10, %ecx
	movl	%eax, -12(%rbp)         # 4-byte Spill
	je	.LBB0_1
	jmp	.LBB0_17
.LBB0_17:
	movl	-12(%rbp), %eax         # 4-byte Reload
	subl	$20, %eax
	je	.LBB0_5
	jmp	.LBB0_18
.LBB0_18:
	movl	-12(%rbp), %eax         # 4-byte Reload
	subl	$50, %eax
	je	.LBB0_3
	jmp	.LBB0_19
.LBB0_19:
	movl	-12(%rbp), %eax         # 4-byte Reload
	subl	$70, %eax
	je	.LBB0_4
	jmp	.LBB0_20
.LBB0_20:
	movl	-12(%rbp), %eax         # 4-byte Reload
	subl	$80, %eax
	je	.LBB0_2
	jmp	.LBB0_6
.LBB0_1:
	movl	$10, -8(%rbp)
	jmp	.LBB0_7
.LBB0_2:
	movl	$80, -8(%rbp)
	jmp	.LBB0_7
.LBB0_3:
	movl	$50, -8(%rbp)
	jmp	.LBB0_7
.LBB0_4:
	movl	$70, -8(%rbp)
	jmp	.LBB0_7
.LBB0_5:
	movl	$20, -8(%rbp)
	jmp	.LBB0_7
.LBB0_6:
	movl	$40, -8(%rbp)
.LBB0_7:
	movl	-8(%rbp), %eax
	imull	%eax, %eax
	addl	$-1, %eax
	movl	%eax, %ecx
	subl	$9, %eax
	movq	%rcx, -24(%rbp)         # 8-byte Spill
	ja	.LBB0_15
# %bb.21:
	movq	-24(%rbp), %rax         # 8-byte Reload
	movq	.LJTI0_0(,%rax,8), %rcx
	jmpq	*%rcx
.LBB0_8:
	movl	$7, -8(%rbp)
	jmp	.LBB0_16
.LBB0_9:
	movl	$1, -8(%rbp)
	jmp	.LBB0_16
.LBB0_10:
	movl	$6, -8(%rbp)
	jmp	.LBB0_16
.LBB0_11:
	movl	$9, -8(%rbp)
	jmp	.LBB0_16
.LBB0_12:
	movl	$5, -8(%rbp)
	jmp	.LBB0_16
.LBB0_13:
	movl	$10, -8(%rbp)
	jmp	.LBB0_16
.LBB0_14:
	movl	$2, -8(%rbp)
	jmp	.LBB0_16
.LBB0_15:
	movl	$40, -8(%rbp)
.LBB0_16:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	3
.LJTI0_0:
	.quad	.LBB0_9
	.quad	.LBB0_14
	.quad	.LBB0_15
	.quad	.LBB0_15
	.quad	.LBB0_12
	.quad	.LBB0_10
	.quad	.LBB0_8
	.quad	.LBB0_15
	.quad	.LBB0_11
	.quad	.LBB0_13
                                        # -- End function
	.ident	"Ubuntu clang version 10.0.1-++20200618012851+f5a9c661a35-1~exp1~20200617233447.176 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
