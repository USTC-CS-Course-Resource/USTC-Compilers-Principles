	.file	"switch.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$50, -4(%rbp)			; 存入 50
	movl	-4(%rbp), %eax			; i=%eax=50
	imull	-4(%rbp), %eax			; i*i
	cmpl	$50, %eax				; i*i 和 50 比较
	je	.L3							; 如果 i*i==50, 跳转到 .L3
	cmpl	$50, %eax				; 
	jg	.L4							; 如果 i*i > 50, 跳转到 .L4
	cmpl	$10, %eax				;
	je	.L5							; 如果 i*i == 10, 跳转到 .L5
	cmpl	$20, %eax				;
	je	.L6							; 如果 i*i == 20, 跳转到 .L6
	jmp	.L2							; 默认跳转为 .L2
.L4:
	cmpl	$70, %eax				; 
	je	.L7							; 如果 i*i==70, 跳转到 .L7
	cmpl	$80, %eax				;
	je	.L8							; 如果 i*i==80, 跳转到 .L8
	jmp	.L2							; 默认跳转为 .L2
.L5:
	movl	$10, -4(%rbp)			; 如果跳转到此, 说明 i*i==10, 故赋值i=10(直接存入地址)
	jmp	.L9							; 相当于 break
.L8:
	movl	$80, -4(%rbp)
	jmp	.L9
.L3:
	movl	$50, -4(%rbp)
	jmp	.L9
.L7:
	movl	$70, -4(%rbp)
	jmp	.L9
.L6:
	movl	$20, -4(%rbp)
	jmp	.L9
.L2:
	movl	$40, -4(%rbp)
.L9:
	movl	-4(%rbp), %eax			; 取 i
	imull	-4(%rbp), %eax			; 求 i*i
	cmpl	$10, %eax				; 比较 10 和 i*i
	ja	.L10						; 如果 i*i>10, 跳转到 .L10
	movl	%eax, %eax				; 
	movq	.L12(,%rax,8), %rax		; 计算偏移, %rax = .L12地址+8*%rax
	jmp	*%rax						; 直接跳转过去
	.section	.rodata				; 对齐等
	.align 8
	.align 4
.L12:								; 跳转表
	.quad	.L10
	.quad	.L11
	.quad	.L13
	.quad	.L10
	.quad	.L10
	.quad	.L14
	.quad	.L15
	.quad	.L16
	.quad	.L10
	.quad	.L17
	.quad	.L18
	.text
.L16:
	movl	$7, -4(%rbp)			; 如果跳转到这, 说明i*i==7, 赋值即可
	jmp	.L19						; 相当于 break
.L11:
	movl	$1, -4(%rbp)
	jmp	.L19
.L15:
	movl	$6, -4(%rbp)
	jmp	.L19
.L17:
	movl	$9, -4(%rbp)
	jmp	.L19
.L14:
	movl	$5, -4(%rbp)
	jmp	.L19
.L18:
	movl	$10, -4(%rbp)
	jmp	.L19
.L13:
	movl	$2, -4(%rbp)
	jmp	.L19
.L10:
	movl	$40, -4(%rbp)
.L19:
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~16.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
