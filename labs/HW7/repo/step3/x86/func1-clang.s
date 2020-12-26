	.text
	.file	"func1.c"
	.globl	fun1                    # -- Begin function fun1
	.p2align	4, 0x90
	.type	fun1,@function
fun1:                                   # @fun1
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	cvtsi2ssl	-4(%rbp), %xmm0
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	fun1, .Lfunc_end0-fun1
	.cfi_endproc
                                        # -- End function
	.globl	fun2                    # -- Begin function fun2
	.p2align	4, 0x90
	.type	fun2,@function
fun2:                                   # @fun2
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	cvtsi2sdl	-4(%rbp), %xmm0
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	fun2, .Lfunc_end1-fun2
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function main
.LCPI2_0:
	.quad	4618103647896390861     # double 5.7000000000000002
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2
.LCPI2_1:
	.long	1080452710              # float 3.5999999
	.text
	.globl	main
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
	subq	$32, %rsp
	movsd	.LCPI2_0(%rip), %xmm0   # xmm0 = mem[0],zero
	movss	.LCPI2_1(%rip), %xmm1   # xmm1 = mem[0],zero,zero,zero
	movss	%xmm1, -4(%rbp)
	movsd	%xmm0, -16(%rbp)
	cvttss2si	-4(%rbp), %edi
	callq	fun1
	cvttsd2si	-16(%rbp), %edi
	movss	%xmm0, -20(%rbp)        # 4-byte Spill
	callq	fun2
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym fun1
	.addrsig_sym fun2
