	.file	"control.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, -4(%rbp)			; i = 0;		   int i = 0;				
	cmpl	$0, -4(%rbp)			; 比较 i 和 0	
	jne	.L8							; 若i != 0, 转.L8	if(i == 0) {
.L6:								;					  while(1) {
	cmpl	$5, -4(%rbp)			; 否则就进入了 .L6	      if (i == 5)
	je	.L9							;						  break;
	jmp	.L4							;						else {
.L5:								;						  for (; i < 5; i++)
	addl	$1, -4(%rbp)			; for 循环自加
.L4:
	cmpl	$4, -4(%rbp)			; for 循环判i<5
	jle	.L5							;						    continue
	jmp	.L6							;					  }
.L9:
	nop								;					
.L8:								;					}
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
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
