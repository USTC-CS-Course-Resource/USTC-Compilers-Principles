	.file	"virtual.cpp"
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
	.section	.text._ZN6ClassBC2Eii,"axG",@progbits,_ZN6ClassBC2Eii,comdat
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
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-8(%rbp), %rax
	movl	-24(%rbp), %edx
	movl	%edx, 8(%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1527:
	.size	_ZN6ClassBC2Eii, .-_ZN6ClassBC2Eii
	.section	.text._ZN6ClassBC1Eii,"axG",@progbits,_ZN6ClassBC1Eii,comdat
	.align 2
	.weak	_ZN6ClassBC1Eii
	.type	_ZN6ClassBC1Eii, @function
_ZN6ClassBC1Eii:
.LFB1528:
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
	leaq	12(%rax), %rdx
	movl	-12(%rbp), %eax
	movl	%eax, %esi
	movq	%rdx, %rdi
	call	_ZN6ClassAC2Ei
	leaq	24+_ZTV6ClassB(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-8(%rbp), %rax
	movl	-16(%rbp), %edx
	movl	%edx, 8(%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1528:
	.size	_ZN6ClassBC1Eii, .-_ZN6ClassBC1Eii
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
	movl	8(%rax), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1529:
	.size	_ZN6ClassB4getbEv, .-_ZN6ClassB4getbEv
	.section	.text._ZN6ClassCC2Eii,"axG",@progbits,_ZN6ClassCC2Eii,comdat
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
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	%ecx, -24(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-8(%rbp), %rax
	movl	-24(%rbp), %edx
	movl	%edx, 8(%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1531:
	.size	_ZN6ClassCC2Eii, .-_ZN6ClassCC2Eii
	.section	.text._ZN6ClassCC1Eii,"axG",@progbits,_ZN6ClassCC1Eii,comdat
	.align 2
	.weak	_ZN6ClassCC1Eii
	.type	_ZN6ClassCC1Eii, @function
_ZN6ClassCC1Eii:
.LFB1532:
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
	leaq	12(%rax), %rdx
	movl	-12(%rbp), %eax
	movl	%eax, %esi
	movq	%rdx, %rdi
	call	_ZN6ClassAC2Ei
	leaq	24+_ZTV6ClassC(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-8(%rbp), %rax
	movl	-16(%rbp), %edx
	movl	%edx, 8(%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1532:
	.size	_ZN6ClassCC1Eii, .-_ZN6ClassCC1Eii
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
	movl	8(%rax), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1533:
	.size	_ZN6ClassC4getcEv, .-_ZN6ClassC4getcEv
	.section	.text._ZN6ClassDC1Eiii,"axG",@progbits,_ZN6ClassDC1Eiii,comdat
	.align 2
	.weak	_ZN6ClassDC1Eiii
	.type	_ZN6ClassDC1Eiii, @function
_ZN6ClassDC1Eiii:
.LFB1536:
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
	leaq	28(%rax), %rdx
	movl	-12(%rbp), %eax
	movl	%eax, %esi
	movq	%rdx, %rdi
	call	_ZN6ClassAC2Ei
	movq	-8(%rbp), %rax
	leaq	8+_ZTT6ClassD(%rip), %rsi
	movl	-16(%rbp), %ecx
	movl	-12(%rbp), %edx
	movq	%rax, %rdi
	call	_ZN6ClassBC2Eii
	movq	-8(%rbp), %rax
	leaq	16(%rax), %rdi
	leaq	16+_ZTT6ClassD(%rip), %rsi
	movl	-20(%rbp), %edx
	movl	-12(%rbp), %eax
	movl	%edx, %ecx
	movl	%eax, %edx
	call	_ZN6ClassCC2Eii
	leaq	24+_ZTV6ClassD(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	leaq	48+_ZTV6ClassD(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 16(%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1536:
	.size	_ZN6ClassDC1Eiii, .-_ZN6ClassDC1Eiii
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
	.string	"d.a: %d\td.ClassB::a: %d\td.ClassC::a: %d\td.b: %d\td.c: %d\n"
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
	subq	$96, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-84(%rbp), %rax
	movl	$1, %esi
	movq	%rax, %rdi
	call	_ZN6ClassAC1Ei
	leaq	-80(%rbp), %rax
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	_ZN6ClassBC1Eii
	leaq	-64(%rbp), %rax
	movl	$3, %edx
	movl	$-1, %esi
	movq	%rax, %rdi
	call	_ZN6ClassCC1Eii
	leaq	-48(%rbp), %rax
	movl	$3, %ecx
	movl	$2, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	_ZN6ClassDC1Eiii
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	-84(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-72(%rbp), %edx
	movl	-68(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-56(%rbp), %edx
	movl	-52(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-24(%rbp), %edi
	movl	-40(%rbp), %esi
	movl	-20(%rbp), %ecx
	movl	-20(%rbp), %edx
	movl	-20(%rbp), %eax
	movl	%edi, %r9d
	movl	%esi, %r8d
	movl	%eax, %esi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-84(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6ClassA4getaEv
	leaq	-80(%rbp), %rax
	addq	$12, %rax
	movq	%rax, %rdi
	call	_ZN6ClassA4getaEv
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6ClassB4getbEv
	leaq	-64(%rbp), %rax
	addq	$12, %rax
	movq	%rax, %rdi
	call	_ZN6ClassA4getaEv
	leaq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6ClassC4getcEv
	leaq	-48(%rbp), %rax
	addq	$28, %rax
	movq	%rax, %rdi
	call	_ZN6ClassA4getaEv
	leaq	-48(%rbp), %rax
	addq	$28, %rax
	movq	%rax, %rdi
	call	_ZN6ClassA4getaEv
	leaq	-48(%rbp), %rax
	addq	$16, %rax
	movq	%rax, %rdi
	call	_ZN6ClassC4getcEv
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN6ClassB4getbEv
	leaq	-48(%rbp), %rax
	addq	$16, %rax
	movq	%rax, %rdi
	call	_ZN6ClassC4getcEv
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L15
	call	__stack_chk_fail@PLT
.L15:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1537:
	.size	main, .-main
	.weak	_ZTV6ClassD
	.section	.data.rel.ro.local._ZTV6ClassD,"awG",@progbits,_ZTV6ClassD,comdat
	.align 8
	.type	_ZTV6ClassD, @object
	.size	_ZTV6ClassD, 48
_ZTV6ClassD:
	.quad	28
	.quad	0
	.quad	_ZTI6ClassD
	.quad	12
	.quad	-16
	.quad	_ZTI6ClassD
	.weak	_ZTT6ClassD
	.section	.data.rel.ro.local._ZTT6ClassD,"awG",@progbits,_ZTV6ClassD,comdat
	.align 8
	.type	_ZTT6ClassD, @object
	.size	_ZTT6ClassD, 32
_ZTT6ClassD:
	.quad	_ZTV6ClassD+24
	.quad	_ZTC6ClassD0_6ClassB+24
	.quad	_ZTC6ClassD16_6ClassC+24
	.quad	_ZTV6ClassD+48
	.hidden	_ZTC6ClassD0_6ClassB
	.weak	_ZTC6ClassD0_6ClassB
	.section	.data.rel.ro.local._ZTC6ClassD0_6ClassB,"awG",@progbits,_ZTV6ClassD,comdat
	.align 8
	.type	_ZTC6ClassD0_6ClassB, @object
	.size	_ZTC6ClassD0_6ClassB, 24
_ZTC6ClassD0_6ClassB:
	.quad	28
	.quad	0
	.quad	_ZTI6ClassB
	.hidden	_ZTC6ClassD16_6ClassC
	.weak	_ZTC6ClassD16_6ClassC
	.section	.data.rel.ro.local._ZTC6ClassD16_6ClassC,"awG",@progbits,_ZTV6ClassD,comdat
	.align 8
	.type	_ZTC6ClassD16_6ClassC, @object
	.size	_ZTC6ClassD16_6ClassC, 24
_ZTC6ClassD16_6ClassC:
	.quad	12
	.quad	0
	.quad	_ZTI6ClassC
	.weak	_ZTV6ClassC
	.section	.data.rel.ro.local._ZTV6ClassC,"awG",@progbits,_ZTV6ClassC,comdat
	.align 8
	.type	_ZTV6ClassC, @object
	.size	_ZTV6ClassC, 24
_ZTV6ClassC:
	.quad	12
	.quad	0
	.quad	_ZTI6ClassC
	.weak	_ZTT6ClassC
	.section	.data.rel.ro.local._ZTT6ClassC,"awG",@progbits,_ZTV6ClassC,comdat
	.align 8
	.type	_ZTT6ClassC, @object
	.size	_ZTT6ClassC, 8
_ZTT6ClassC:
	.quad	_ZTV6ClassC+24
	.weak	_ZTV6ClassB
	.section	.data.rel.ro.local._ZTV6ClassB,"awG",@progbits,_ZTV6ClassB,comdat
	.align 8
	.type	_ZTV6ClassB, @object
	.size	_ZTV6ClassB, 24
_ZTV6ClassB:
	.quad	12
	.quad	0
	.quad	_ZTI6ClassB
	.weak	_ZTT6ClassB
	.section	.data.rel.ro.local._ZTT6ClassB,"awG",@progbits,_ZTV6ClassB,comdat
	.align 8
	.type	_ZTT6ClassB, @object
	.size	_ZTT6ClassB, 8
_ZTT6ClassB:
	.quad	_ZTV6ClassB+24
	.weak	_ZTI6ClassD
	.section	.data.rel.ro._ZTI6ClassD,"awG",@progbits,_ZTI6ClassD,comdat
	.align 8
	.type	_ZTI6ClassD, @object
	.size	_ZTI6ClassD, 56
_ZTI6ClassD:
	.quad	_ZTVN10__cxxabiv121__vmi_class_type_infoE+16
	.quad	_ZTS6ClassD
	.long	2
	.long	2
	.quad	_ZTI6ClassB
	.quad	2
	.quad	_ZTI6ClassC
	.quad	4098
	.weak	_ZTS6ClassD
	.section	.rodata._ZTS6ClassD,"aG",@progbits,_ZTS6ClassD,comdat
	.align 8
	.type	_ZTS6ClassD, @object
	.size	_ZTS6ClassD, 8
_ZTS6ClassD:
	.string	"6ClassD"
	.weak	_ZTI6ClassC
	.section	.data.rel.ro._ZTI6ClassC,"awG",@progbits,_ZTI6ClassC,comdat
	.align 8
	.type	_ZTI6ClassC, @object
	.size	_ZTI6ClassC, 40
_ZTI6ClassC:
	.quad	_ZTVN10__cxxabiv121__vmi_class_type_infoE+16
	.quad	_ZTS6ClassC
	.long	0
	.long	1
	.quad	_ZTI6ClassA
	.quad	-6141
	.weak	_ZTS6ClassC
	.section	.rodata._ZTS6ClassC,"aG",@progbits,_ZTS6ClassC,comdat
	.align 8
	.type	_ZTS6ClassC, @object
	.size	_ZTS6ClassC, 8
_ZTS6ClassC:
	.string	"6ClassC"
	.weak	_ZTI6ClassB
	.section	.data.rel.ro._ZTI6ClassB,"awG",@progbits,_ZTI6ClassB,comdat
	.align 8
	.type	_ZTI6ClassB, @object
	.size	_ZTI6ClassB, 40
_ZTI6ClassB:
	.quad	_ZTVN10__cxxabiv121__vmi_class_type_infoE+16
	.quad	_ZTS6ClassB
	.long	0
	.long	1
	.quad	_ZTI6ClassA
	.quad	-6141
	.weak	_ZTS6ClassB
	.section	.rodata._ZTS6ClassB,"aG",@progbits,_ZTS6ClassB,comdat
	.align 8
	.type	_ZTS6ClassB, @object
	.size	_ZTS6ClassB, 8
_ZTS6ClassB:
	.string	"6ClassB"
	.text
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
	jne	.L18
	cmpl	$65535, -8(%rbp)
	jne	.L18
	leaq	_ZStL8__ioinit(%rip), %rdi
	call	_ZNSt8ios_base4InitC1Ev@PLT
	leaq	__dso_handle(%rip), %rdx
	leaq	_ZStL8__ioinit(%rip), %rsi
	movq	_ZNSt8ios_base4InitD1Ev@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	__cxa_atexit@PLT
.L18:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2018:
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.weak	_ZTI6ClassA
	.section	.data.rel.ro._ZTI6ClassA,"awG",@progbits,_ZTI6ClassA,comdat
	.align 8
	.type	_ZTI6ClassA, @object
	.size	_ZTI6ClassA, 16
_ZTI6ClassA:
	.quad	_ZTVN10__cxxabiv117__class_type_infoE+16
	.quad	_ZTS6ClassA
	.weak	_ZTS6ClassA
	.section	.rodata._ZTS6ClassA,"aG",@progbits,_ZTS6ClassA,comdat
	.align 8
	.type	_ZTS6ClassA, @object
	.size	_ZTS6ClassA, 8
_ZTS6ClassA:
	.string	"6ClassA"
	.text
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
