	.file	"simd.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"%d"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$1552, %rsp
	.cfi_def_cfa_offset 1584
	movdqa	.LC0(%rip), %xmm0
	movdqa	.LC1(%rip), %xmm2
	movq	%fs:40, %rax
	movq	%rax, 1544(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rdx
	leaq	512(%rsp), %rcx
	.p2align 4,,10
	.p2align 3
.L2:
	movdqa	%xmm0, %xmm1
	paddd	%xmm2, %xmm0
	movaps	%xmm1, (%rdx,%rax)
	movaps	%xmm1, (%rcx,%rax)
	addq	$16, %rax
	cmpq	$512, %rax
	jne	.L2
	xorl	%eax, %eax
	leaq	1024(%rsp), %rbx
	.p2align 4,,10
	.p2align 3
.L3:
	movdqa	(%rdx,%rax), %xmm0
	paddd	(%rcx,%rax), %xmm0
	movaps	%xmm0, (%rbx,%rax)
	addq	$16, %rax
	cmpq	$512, %rax
	jne	.L3
	leaq	1536(%rsp), %r12
	leaq	.LC2(%rip), %rbp
	.p2align 4,,10
	.p2align 3
.L4:
	movl	(%rbx), %edx
	movq	%rbp, %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	addq	$4, %rbx
	call	__printf_chk@PLT
	cmpq	%r12, %rbx
	jne	.L4
	movq	1544(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L11
	addq	$1552, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L11:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.align 16
.LC1:
	.long	4
	.long	4
	.long	4
	.long	4
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
