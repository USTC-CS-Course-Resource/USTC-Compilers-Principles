	.text
	.file	"switch.c"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	movl	$50, -8(%ebp)
	movl	-8(%ebp), %eax
	imull	%eax, %eax
	movl	%eax, %ecx
	subl	$10, %ecx
	movl	%eax, -12(%ebp)         # 4-byte Spill
	je	.LBB0_1
	jmp	.LBB0_17
.LBB0_17:
	movl	-12(%ebp), %eax         # 4-byte Reload
	subl	$20, %eax
	je	.LBB0_5
	jmp	.LBB0_18
.LBB0_18:
	movl	-12(%ebp), %eax         # 4-byte Reload
	subl	$50, %eax
	je	.LBB0_3
	jmp	.LBB0_19
.LBB0_19:
	movl	-12(%ebp), %eax         # 4-byte Reload
	subl	$70, %eax
	je	.LBB0_4
	jmp	.LBB0_20
.LBB0_20:
	movl	-12(%ebp), %eax         # 4-byte Reload
	subl	$80, %eax
	je	.LBB0_2
	jmp	.LBB0_6
.LBB0_1:
	movl	$10, -8(%ebp)
	jmp	.LBB0_7
.LBB0_2:
	movl	$80, -8(%ebp)
	jmp	.LBB0_7
.LBB0_3:
	movl	$50, -8(%ebp)
	jmp	.LBB0_7
.LBB0_4:
	movl	$70, -8(%ebp)
	jmp	.LBB0_7
.LBB0_5:
	movl	$20, -8(%ebp)
	jmp	.LBB0_7
.LBB0_6:
	movl	$40, -8(%ebp)
.LBB0_7:
	movl	-8(%ebp), %eax
	imull	%eax, %eax
	decl	%eax
	movl	%eax, %ecx
	subl	$9, %ecx
	movl	%eax, -16(%ebp)         # 4-byte Spill
	ja	.LBB0_15
# %bb.21:
	movl	-16(%ebp), %eax         # 4-byte Reload
	movl	.LJTI0_0(,%eax,4), %ecx
	jmpl	*%ecx
.LBB0_8:
	movl	$7, -8(%ebp)
	jmp	.LBB0_16
.LBB0_9:
	movl	$1, -8(%ebp)
	jmp	.LBB0_16
.LBB0_10:
	movl	$6, -8(%ebp)
	jmp	.LBB0_16
.LBB0_11:
	movl	$9, -8(%ebp)
	jmp	.LBB0_16
.LBB0_12:
	movl	$5, -8(%ebp)
	jmp	.LBB0_16
.LBB0_13:
	movl	$10, -8(%ebp)
	jmp	.LBB0_16
.LBB0_14:
	movl	$2, -8(%ebp)
	jmp	.LBB0_16
.LBB0_15:
	movl	$40, -8(%ebp)
.LBB0_16:
	movl	-4(%ebp), %eax
	addl	$16, %esp
	popl	%ebp
	retl
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.section	.rodata,"a",@progbits
	.p2align	2
.LJTI0_0:
	.long	.LBB0_9
	.long	.LBB0_14
	.long	.LBB0_15
	.long	.LBB0_15
	.long	.LBB0_12
	.long	.LBB0_10
	.long	.LBB0_8
	.long	.LBB0_15
	.long	.LBB0_11
	.long	.LBB0_13
                                        # -- End function
	.ident	"Ubuntu clang version 10.0.1-++20200618012851+f5a9c661a35-1~exp1~20200617233447.176 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
