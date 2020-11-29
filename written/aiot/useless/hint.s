	.file	"hint.c"
	.text
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB34:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$4096, %rsp
	.cfi_def_cfa_offset 4120
	orq	$0, (%rsp)
	subq	$24, %rsp
	.cfi_def_cfa_offset 4144
	movdqa	.LC0(%rip), %xmm0
	movq	%fs:40, %rax
	movq	%rax, 4104(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rbx
	leaq	2048(%rsp), %rdx
	movq	%rbx, %rax
	.p2align 4,,10
	.p2align 3
.L2:
	movaps	%xmm0, (%rax)
	addq	$16, %rax
	cmpq	%rdx, %rax
	jne	.L2
	movdqa	.LC1(%rip), %xmm0
	leaq	3408(%rbx), %rdx
	.p2align 4,,10
	.p2align 3
.L3:
	movaps	%xmm0, (%rax)
	addq	$16, %rax
	cmpq	%rdx, %rax
	jne	.L3
	movdqa	.LC2(%rip), %xmm0
	leaq	3412(%rsp), %rax
	movl	$3, 3408(%rsp)
	leaq	3716(%rbx), %rdx
.L4:
	movups	%xmm0, (%rax)
	addq	$16, %rax
	cmpq	%rax, %rdx
	jne	.L4
	movdqa	.LC3(%rip), %xmm0
	leaq	3720(%rsp), %rax
	movl	$7, 3716(%rsp)
	leaq	4088(%rbx), %rdx
.L5:
	movups	%xmm0, (%rax)
	addq	$16, %rax
	cmpq	%rax, %rdx
	jne	.L5
	movabsq	$4294967297, %rax
	leaq	4096(%rbx), %rbp
	movq	%rax, 4088(%rsp)
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L20:
	cmpl	$4, %eax
	jle	.L7
	movl	$53, %edi
	call	putchar@PLT
.L8:
	addq	$4, %rbx
	cmpq	%rbx, %rbp
	je	.L19
.L10:
	movl	(%rbx), %eax
	cmpl	$2, %eax
	jg	.L20
	je	.L9
	movl	$49, %edi
	addq	$4, %rbx
	call	putchar@PLT
	cmpq	%rbx, %rbp
	jne	.L10
.L19:
	movq	4104(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L21
	addq	$4120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	.cfi_restore_state
	movl	$51, %edi
	call	putchar@PLT
	jmp	.L8
	.p2align 4,,10
	.p2align 3
.L9:
	movl	$55, %edi
	call	putchar@PLT
	jmp	.L8
.L21:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE34:
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	5
	.long	5
	.long	5
	.long	5
	.align 16
.LC1:
	.long	3
	.long	3
	.long	3
	.long	3
	.align 16
.LC2:
	.long	7
	.long	7
	.long	7
	.long	7
	.align 16
.LC3:
	.long	1
	.long	1
	.long	1
	.long	1
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
