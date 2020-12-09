	.file	"fact.c"
	.text
	.globl	f2						; 全局符号
	.type	f2, @function			; 类型为函数
f2:
.LFB0:
	.cfi_startproc					
	pushq	%rbp					; 基址寄存器入栈
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp				; %rbp = %rsp
	.cfi_def_cfa_register 6
	subq	$16, %rsp				; 扩栈
	movl	%edi, -4(%rbp)			; 存 n
	movl	-4(%rbp), %eax			; %eax = n
	movl	%eax, m.2248(%rip)		; m = n
	movl	m.2248(%rip), %eax		; %eax = m
	testl	%eax, %eax				; 
	jne	.L2							; 如不相等则跳转到 .L2
	movl	$1, %eax				; 准备返回值
	jmp	.L3							; 跳转到返回
.L2:
	movl	m.2248(%rip), %eax		; %eax = m
	subl	$1, %eax				; 求 m-1
	movl	%eax, %edi				; 通过 %edi 传参
	call	f2						; 调用函数
	movl	%eax, %edx				; 取返回值
	movl	m.2248(%rip), %eax		; 取 m
	imull	%edx, %eax				; 计算 m*f2(m-1)
.L3:
	leave							
	.cfi_def_cfa 7, 8
	ret								; 返回
	.cfi_endproc
.LFE0:
	.size	f2, .-f2				; 符号大小
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
	movl	$3, %edi		; 准备参数 3
	call	f2				; 调用 f2
	movl	%eax, %ebx		; %ebx = f2(3)
	movl	$3, %edi		; 准备参数 3
	call	f1				; 调用 f1
	movl	%ebx, %edx		; %edx = f3(3)
	movl	%eax, %esi		; 准备参数 f(2)
	movl	$.LC0, %edi		; 准备参数 "%d, %d"
	movl	$0, %eax		; 
	call	printf			; 调用 printf
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
