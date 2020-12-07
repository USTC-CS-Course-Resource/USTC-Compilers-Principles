	.file	"switch.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$50, -4(%ebp)
	movl	-4(%ebp), %eax
	imull	-4(%ebp), %eax
	cmpl	$50, %eax
	je	.L3
	cmpl	$50, %eax
	jg	.L4
	cmpl	$10, %eax
	je	.L5
	cmpl	$20, %eax
	je	.L6
	jmp	.L2
.L4:
	cmpl	$70, %eax
	je	.L7
	cmpl	$80, %eax
	je	.L8
	jmp	.L2
.L5:
	movl	$10, -4(%ebp)
	jmp	.L9
.L8:
	movl	$80, -4(%ebp)
	jmp	.L9
.L3:
	movl	$50, -4(%ebp)
	jmp	.L9
.L7:
	movl	$70, -4(%ebp)
	jmp	.L9
.L6:
	movl	$20, -4(%ebp)
	jmp	.L9
.L2:
	movl	$40, -4(%ebp)
.L9:
	movl	-4(%ebp), %eax
	imull	-4(%ebp), %eax
	cmpl	$10, %eax
	ja	.L10
	movl	.L12(,%eax,4), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L12:
	.long	.L10
	.long	.L11
	.long	.L13
	.long	.L10
	.long	.L10
	.long	.L14
	.long	.L15
	.long	.L16
	.long	.L10
	.long	.L17
	.long	.L18
	.text
.L16:
	movl	$7, -4(%ebp)
	jmp	.L19
.L11:
	movl	$1, -4(%ebp)
	jmp	.L19
.L15:
	movl	$6, -4(%ebp)
	jmp	.L19
.L17:
	movl	$9, -4(%ebp)
	jmp	.L19
.L14:
	movl	$5, -4(%ebp)
	jmp	.L19
.L18:
	movl	$10, -4(%ebp)
	jmp	.L19
.L13:
	movl	$2, -4(%ebp)
	jmp	.L19
.L10:
	movl	$40, -4(%ebp)
.L19:
	movl	$0, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~16.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
