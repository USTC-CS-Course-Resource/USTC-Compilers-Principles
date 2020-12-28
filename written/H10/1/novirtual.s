	.file	"novirtual.cpp"
	.text
	.section	.rodata
	.type	_ZStL19piecewise_construct, @object
	.size	_ZStL19piecewise_construct, 1
_ZStL19piecewise_construct:
	.zero	1
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.section	.text._ZN6ClassAC2Ei,"axG",@progbits,_ZN6ClassAC5Ei,comdat
	.align 2
	.weak	_ZN6ClassAC2Ei
	.type	_ZN6ClassAC2Ei, @function
_ZN6ClassAC2Ei:
.LFB1523:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	-8(%rbp), %rax
	movl	-12(%rbp), %edx
	movl	%edx, (%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1523:
	.size	_ZN6ClassAC2Ei, .-_ZN6ClassAC2Ei
	.weak	_ZN6ClassAC1Ei
	.set	_ZN6ClassAC1Ei,_ZN6ClassAC2Ei
	.section	.text._ZN6ClassA4getaEv,"axG",@progbits,_ZN6ClassA4getaEv,comdat
	.align 2
	.weak	_ZN6ClassA4getaEv
	.type	_ZN6ClassA4getaEv, @function
_ZN6ClassA4getaEv:
.LFB1525:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1525:
	.size	_ZN6ClassA4getaEv, .-_ZN6ClassA4getaEv
	.section	.text._ZN6ClassBC2Eii,"axG",@progbits,_ZN6ClassBC5Eii,comdat
	.align 2
	.weak	_ZN6ClassBC2Eii
	.type	_ZN6ClassBC2Eii, @function
_ZN6ClassBC2Eii:
.LFB1527:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movq	-8(%rbp), %rax
	movl	-12(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	call	_ZN6ClassAC2Ei
	movq	-8(%rbp), %rax
	movl	-16(%rbp), %edx
	movl	%edx, 4(%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1527:
	.size	_ZN6ClassBC2Eii, .-_ZN6ClassBC2Eii
	.weak	_ZN6ClassBC1Eii
	.set	_ZN6ClassBC1Eii,_ZN6ClassBC2Eii
	.section	.text._ZN6ClassB4getbEv,"axG",@progbits,_ZN6ClassB4getbEv,comdat
	.align 2
	.weak	_ZN6ClassB4getbEv
	.type	_ZN6ClassB4getbEv, @function
_ZN6ClassB4getbEv:
.LFB1529:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	4(%rax), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1529:
	.size	_ZN6ClassB4getbEv, .-_ZN6ClassB4getbEv
	.section	.text._ZN6ClassCC2Eii,"axG",@progbits,_ZN6ClassCC5Eii,comdat
	.align 2
	.weak	_ZN6ClassCC2Eii
	.type	_ZN6ClassCC2Eii, @function
_ZN6ClassCC2Eii:
.LFB1531:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movq	-8(%rbp), %rax
	movl	-12(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	call	_ZN6ClassAC2Ei
	movq	-8(%rbp), %rax
	movl	-16(%rbp), %edx
	movl	%edx, 4(%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1531:
	.size	_ZN6ClassCC2Eii, .-_ZN6ClassCC2Eii
	.weak	_ZN6ClassCC1Eii
	.set	_ZN6ClassCC1Eii,_ZN6ClassCC2Eii
	.section	.text._ZN6ClassC4getcEv,"axG",@progbits,_ZN6ClassC4getcEv,comdat
	.align 2
	.weak	_ZN6ClassC4getcEv
	.type	_ZN6ClassC4getcEv, @function
_ZN6ClassC4getcEv:
.LFB1533:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	4(%rax), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1533:
	.size	_ZN6ClassC4getcEv, .-_ZN6ClassC4getcEv
	.section	.text._ZN6ClassDC2Eiii,"axG",@progbits,_ZN6ClassDC5Eiii,comdat
	.align 2
	.weak	_ZN6ClassDC2Eiii
	.type	_ZN6ClassDC2Eiii, @function
_ZN6ClassDC2Eiii:
.LFB1535:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	-8(%rbp), %rax
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %ecx
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	_ZN6ClassBC2Eii
	movq	-8(%rbp), %rax
	leaq	8(%rax), %rcx
	movl	-20(%rbp), %edx
	movl	-12(%rbp), %eax
	movl	%eax, %esi
	movq	%rcx, %rdi
	call	_ZN6ClassCC2Eii
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1535:
	.size	_ZN6ClassDC2Eiii, .-_ZN6ClassDC2Eiii
	.weak	_ZN6ClassDC1Eiii
	.set	_ZN6ClassDC1Eiii,_ZN6ClassDC2Eiii
	.section	.rodata
	.align 8
.LC0:
	.string	"================================= My Test Output ==============================="
.LC1:
	.string	"a.a: %d\n"
.LC2:
	.string	"b.a: %d\tb.b: %d\n"
.LC3:
	.string	"c.a: %d\tc.b: %d\n"
	.align 8
.LC4:
	.string	"d.ClassB::a: %d\td.ClassC::a: %d\td.b: %d\td.c: %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1537:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-52(%rbp), %rax
	movl	$1, %esi
	movq	%rax, %rdi
	call	_ZN6ClassAC1Ei
	leaq	-48(%rbp), %rax
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	_ZN6ClassBC1Eii
	leaq	-40(%rbp), %rax
	movl	$3, %edx
	movl	$-1, %esi
	movq	%rax, %rdi
	call	_ZN6ClassCC1Eii
	leaq	-32(%rbp), %rax
	movl	$3, %ecx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	_ZN6ClassDC1Eiii
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	-52(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-44(%rbp), %edx
	movl	-44(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-36(%rbp), %edx
	movl	-40(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-20(%rbp), %esi
	movl	-28(%rbp), %ecx
	movl	-24(%rbp), %edx
	movl	-32(%rbp), %eax
	movl	%esi, %r8d
	movl	%eax, %esi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-52(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6ClassA4getaEv
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6ClassA4getaEv
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6ClassB4getbEv
	leaq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6ClassA4getaEv
	leaq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6ClassC4getcEv
	leaq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6ClassA4getaEv
	leaq	-32(%rbp), %rax
	addq	$8, %rax
	movq	%rax, %rdi
	call	_ZN6ClassC4getcEv
	leaq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6ClassB4getbEv
	leaq	-32(%rbp), %rax
	addq	$8, %rax
	movq	%rax, %rdi
	call	_ZN6ClassC4getcEv
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L13
	call	__stack_chk_fail@PLT
.L13:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1537:
	.size	main, .-main
	.type	_Z41__static_initialization_and_destruction_0ii, @function
_Z41__static_initialization_and_destruction_0ii:
.LFB2018:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	cmpl	$1, -4(%rbp)
	jne	.L16
	cmpl	$65535, -8(%rbp)
	jne	.L16
	leaq	_ZStL8__ioinit(%rip), %rdi
	call	_ZNSt8ios_base4InitC1Ev@PLT
	leaq	__dso_handle(%rip), %rdx
	leaq	_ZStL8__ioinit(%rip), %rsi
	movq	_ZNSt8ios_base4InitD1Ev@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	__cxa_atexit@PLT
.L16:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2018:
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.type	_GLOBAL__sub_I_main, @function
_GLOBAL__sub_I_main:
.LFB2019:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$65535, %esi
	movl	$1, %edi
	call	_Z41__static_initialization_and_destruction_0ii
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2019:
	.size	_GLOBAL__sub_I_main, .-_GLOBAL__sub_I_main
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I_main
	.hidden	__dso_handle
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
