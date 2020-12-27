	.file	"test.cpp"
	.text
	.section	.text._ZN9TestClassC2Eiii,"axG",@progbits,_ZN9TestClassC5Eiii,comdat
	.align 2
	.weak	_ZN9TestClassC2Eiii
	.type	_ZN9TestClassC2Eiii, @function
_ZN9TestClassC2Eiii:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	_ZN9TestClassC2Eiii, .-_ZN9TestClassC2Eiii
	.weak	_ZN9TestClassC1Eiii
	.set	_ZN9TestClassC1Eiii,_ZN9TestClassC2Eiii
	.section	.text._ZN9TestClassC2Eii,"axG",@progbits,_ZN9TestClassC5Eii,comdat
	.align 2
	.weak	_ZN9TestClassC2Eii
	.type	_ZN9TestClassC2Eii, @function
_ZN9TestClassC2Eii:
.LFB4:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	_ZN9TestClassC2Eii, .-_ZN9TestClassC2Eii
	.weak	_ZN9TestClassC1Eii
	.set	_ZN9TestClassC1Eii,_ZN9TestClassC2Eii
	.section	.text._ZN9TestClass10publictestEv,"axG",@progbits,_ZN9TestClass10publictestEv,comdat
	.align 2
	.weak	_ZN9TestClass10publictestEv
	.type	_ZN9TestClass10publictestEv, @function
_ZN9TestClass10publictestEv:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN9TestClass11privatetestEv
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN9TestClass13protectedtestEv
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	_ZN9TestClass10publictestEv, .-_ZN9TestClass10publictestEv
	.section	.text._ZN9TestClass11privatetestEv,"axG",@progbits,_ZN9TestClass11privatetestEv,comdat
	.align 2
	.weak	_ZN9TestClass11privatetestEv
	.type	_ZN9TestClass11privatetestEv, @function
_ZN9TestClass11privatetestEv:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	_ZN9TestClass11privatetestEv, .-_ZN9TestClass11privatetestEv
	.section	.text._ZN9TestClass13protectedtestEv,"axG",@progbits,_ZN9TestClass13protectedtestEv,comdat
	.align 2
	.weak	_ZN9TestClass13protectedtestEv
	.type	_ZN9TestClass13protectedtestEv, @function
_ZN9TestClass13protectedtestEv:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	_ZN9TestClass13protectedtestEv, .-_ZN9TestClass13protectedtestEv
	.text
	.globl	main
	.type	main, @function
main:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-10(%rbp), %rax
	movl	$3, %ecx
	movl	$3, %edx
	movl	$5, %esi
	movq	%rax, %rdi
	call	_ZN9TestClassC1Eiii
	leaq	-9(%rbp), %rax
	movl	$3, %edx
	movl	$5, %esi
	movq	%rax, %rdi
	call	_ZN9TestClassC1Eii
	leaq	-9(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN9TestClass10publictestEv
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L8
	call	__stack_chk_fail@PLT
.L8:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
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
