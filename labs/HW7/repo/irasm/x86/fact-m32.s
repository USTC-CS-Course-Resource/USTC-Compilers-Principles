	.file	"fact.c"
	.text
	.globl	f2
	.type	f2, @function
f2:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, m.1865
	movl	m.1865, %eax
	testl	%eax, %eax
	jne	.L2
	movl	$1, %eax
	jmp	.L3
.L2:
	movl	m.1865, %eax
	subl	$1, %eax
	subl	$12, %esp
	pushl	%eax
	call	f2
	addl	$16, %esp
	movl	%eax, %edx
	movl	m.1865, %eax
	imull	%edx, %eax
.L3:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	f2, .-f2
	.globl	f1
	.type	f1, @function
f1:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	cmpl	$0, 8(%ebp)
	jne	.L5
	movl	$1, %eax
	jmp	.L6
.L5:
	movl	8(%ebp), %eax
	subl	$1, %eax
	subl	$12, %esp
	pushl	%eax
	call	f1
	addl	$16, %esp
	imull	8(%ebp), %eax
.L6:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
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
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	n, %eax
	testl	%eax, %eax
	jne	.L8
	movl	$1, %eax
	jmp	.L9
.L8:
	movl	n, %eax
	subl	$1, %eax
	subl	$12, %esp
	pushl	%eax
	call	f3
	addl	$16, %esp
	movl	%eax, %edx
	movl	n, %eax
	imull	%edx, %eax
.L9:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
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
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	movl	%esp, %ebp
	pushl	%ebx
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x78,0x6
	.cfi_escape 0x10,0x3,0x2,0x75,0x7c
	subl	$12, %esp
	pushl	$3
	call	f2
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$12, %esp
	pushl	$3
	call	f1
	addl	$16, %esp
	subl	$4, %esp
	pushl	%ebx
	pushl	%eax
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	movl	$0, %eax
	leal	-8(%ebp), %esp
	popl	%ecx
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE3:
	.size	main, .-main
	.local	m.1865
	.comm	m.1865,4,4
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~16.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
