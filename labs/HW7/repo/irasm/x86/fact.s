	.file	"fact.c"
	.text
	.globl	f2
	.type	f2, @function
f2:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, m.2248(%rip)
	movl	m.2248(%rip), %eax
	testl	%eax, %eax
	jne	.L2
	movl	$1, %eax
	jmp	.L3
.L2:
	movl	m.2248(%rip), %eax
	subl	$1, %eax
	movl	%eax, %edi
	call	f2
	movl	%eax, %edx
	movl	m.2248(%rip), %eax
	imull	%edx, %eax
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	f2, .-f2
	.globl	f1
	.type	f1, @function
f1:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jne	.L5
	movl	$1, %eax
	jmp	.L6
.L5:
	movl	-4(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %edi
	call	f1
	imull	-4(%rbp), %eax
.L6:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	f1, .-f1
	.globl	n
	.data
	.align 4
	.type	n, @object
	.size	n, 4
n:
	.long	3
	.text
	.globl	f3
	.type	f3, @function
f3:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	n(%rip), %eax
	testl	%eax, %eax
	jne	.L8
	movl	$1, %eax
	jmp	.L9
.L8:
	movl	n(%rip), %eax
	subl	$1, %eax
	movl	%eax, %edi
	movl	$0, %eax
	call	f3
	movl	%eax, %edx
	movl	n(%rip), %eax
	imull	%edx, %eax
.L9:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	f3, .-f3
	.section	.rodata
.LC0:
	.string	"%d, %d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$8, %rsp
	.cfi_offset 3, -24
	movl	$3, %edi
	call	f2
	movl	%eax, %ebx
	movl	$3, %edi
	call	f1
	movl	%ebx, %edx
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	main, .-main
	.local	m.2248
	.comm	m.2248,4,4
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~16.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
