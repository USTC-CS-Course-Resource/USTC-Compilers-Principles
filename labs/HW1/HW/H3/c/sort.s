	.file	"sort.c"
	.text
.Ltext0:
	.globl	my_sort
	.type	my_sort, @function
my_sort:
.LFB6:
	.file 1 "sort.c"
	.loc 1 4 32
	.cfi_startproc
	endbr32
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
.LBB2:
	.loc 1 5 13
	movl	$0, -12(%ebp)
	.loc 1 5 5
	jmp	.L2
.L6:
.LBB3:
	.loc 1 6 17
	movl	-12(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -8(%ebp)
	.loc 1 6 9
	jmp	.L3
.L5:
	.loc 1 7 20
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %edx
	.loc 1 7 30
	movl	-8(%ebp), %eax
	leal	0(,%eax,4), %ecx
	movl	8(%ebp), %eax
	addl	%ecx, %eax
	movl	(%eax), %eax
	.loc 1 7 15
	cmpl	%eax, %edx
	jle	.L4
.LBB4:
	.loc 1 8 31
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	.loc 1 8 21
	movl	(%eax), %eax
	movl	%eax, -4(%ebp)
	.loc 1 9 31
	movl	-8(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	.loc 1 9 21
	movl	-12(%ebp), %edx
	leal	0(,%edx,4), %ecx
	movl	8(%ebp), %edx
	addl	%ecx, %edx
	.loc 1 9 31
	movl	(%eax), %eax
	.loc 1 9 25
	movl	%eax, (%edx)
	.loc 1 10 21
	movl	-8(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	.loc 1 10 25
	movl	-4(%ebp), %eax
	movl	%eax, (%edx)
.L4:
.LBE4:
	.loc 1 6 36 discriminator 2
	addl	$1, -8(%ebp)
.L3:
	.loc 1 6 9 discriminator 1
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jl	.L5
.LBE3:
	.loc 1 5 28 discriminator 2
	addl	$1, -12(%ebp)
.L2:
	.loc 1 5 5 discriminator 1
	movl	-12(%ebp), %eax
	cmpl	12(%ebp), %eax
	jl	.L6
.LBE2:
	.loc 1 14 1
	nop
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE6:
	.size	my_sort, .-my_sort
	.section	.rodata
.LC0:
	.string	"%d"
.LC1:
	.string	" %d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB7:
	.loc 1 16 12
	.cfi_startproc
	endbr32
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
	subl	$32, %esp
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	.loc 1 16 12
	movl	%gs:20, %eax
	movl	%eax, -12(%ebp)
	xorl	%eax, %eax
	.loc 1 20 5
	subl	$8, %esp
	leal	-28(%ebp), %eax
	pushl	%eax
	leal	.LC0@GOTOFF(%ebx), %eax
	pushl	%eax
	call	__isoc99_scanf@PLT
	addl	$16, %esp
	.loc 1 21 18
	movl	-28(%ebp), %eax
	sall	$2, %eax
	subl	$12, %esp
	pushl	%eax
	call	malloc@PLT
	addl	$16, %esp
	movl	%eax, -16(%ebp)
.LBB5:
	.loc 1 22 13
	movl	$0, -24(%ebp)
	.loc 1 22 5
	jmp	.L8
.L9:
	.loc 1 23 25 discriminator 3
	movl	-24(%ebp), %eax
	leal	0(,%eax,4), %edx
	.loc 1 23 9 discriminator 3
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	subl	$8, %esp
	pushl	%eax
	leal	.LC0@GOTOFF(%ebx), %eax
	pushl	%eax
	call	__isoc99_scanf@PLT
	addl	$16, %esp
	.loc 1 22 28 discriminator 3
	addl	$1, -24(%ebp)
.L8:
	.loc 1 22 22 discriminator 1
	movl	-28(%ebp), %eax
	.loc 1 22 5 discriminator 1
	cmpl	%eax, -24(%ebp)
	jl	.L9
.LBE5:
	.loc 1 27 5
	movl	-28(%ebp), %eax
	subl	$8, %esp
	pushl	%eax
	pushl	-16(%ebp)
	call	my_sort
	addl	$16, %esp
	.loc 1 30 5
	movl	-16(%ebp), %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	%eax
	leal	.LC0@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
.LBB6:
	.loc 1 31 13
	movl	$1, -20(%ebp)
	.loc 1 31 5
	jmp	.L10
.L11:
	.loc 1 32 27 discriminator 3
	movl	-20(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	.loc 1 32 9 discriminator 3
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	%eax
	leal	.LC1@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
	.loc 1 31 28 discriminator 3
	addl	$1, -20(%ebp)
.L10:
	.loc 1 31 22 discriminator 1
	movl	-28(%ebp), %eax
	.loc 1 31 5 discriminator 1
	cmpl	%eax, -20(%ebp)
	jl	.L11
.LBE6:
	.loc 1 34 5
	subl	$12, %esp
	pushl	$10
	call	putchar@PLT
	addl	$16, %esp
	movl	$0, %eax
	.loc 1 36 1
	movl	-12(%ebp), %ecx
	xorl	%gs:20, %ecx
	je	.L13
	call	__stack_chk_fail_local
.L13:
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
.LFE7:
	.size	main, .-main
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
.LFB8:
	.cfi_startproc
	movl	(%esp), %eax
	ret
	.cfi_endproc
.LFE8:
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
.LFB9:
	.cfi_startproc
	movl	(%esp), %ebx
	ret
	.cfi_endproc
.LFE9:
	.text
.Letext0:
	.file 2 "/usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h"
	.file 3 "/usr/include/bits/types.h"
	.file 4 "/usr/include/bits/types/struct_FILE.h"
	.file 5 "/usr/include/bits/types/FILE.h"
	.file 6 "/usr/include/stdio.h"
	.file 7 "/usr/include/bits/sys_errlist.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x3d6
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF53
	.byte	0xc
	.long	.LASF54
	.long	.LASF55
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF7
	.byte	0x2
	.byte	0xd1
	.byte	0x16
	.long	0x31
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF0
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF1
	.uleb128 0x4
	.long	0x38
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF2
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF3
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF4
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF5
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF6
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.long	.LASF8
	.byte	0x3
	.byte	0x2f
	.byte	0x2c
	.long	0x7a
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF9
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF10
	.uleb128 0x2
	.long	.LASF11
	.byte	0x3
	.byte	0x98
	.byte	0x20
	.long	0x94
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.long	.LASF12
	.uleb128 0x2
	.long	.LASF13
	.byte	0x3
	.byte	0x99
	.byte	0x21
	.long	0x6e
	.uleb128 0x6
	.byte	0x4
	.uleb128 0x7
	.byte	0x4
	.long	0x38
	.uleb128 0x8
	.long	.LASF56
	.byte	0x94
	.byte	0x4
	.byte	0x31
	.byte	0x8
	.long	0x236
	.uleb128 0x9
	.long	.LASF14
	.byte	0x4
	.byte	0x33
	.byte	0x7
	.long	0x67
	.byte	0
	.uleb128 0x9
	.long	.LASF15
	.byte	0x4
	.byte	0x36
	.byte	0x9
	.long	0xa9
	.byte	0x4
	.uleb128 0x9
	.long	.LASF16
	.byte	0x4
	.byte	0x37
	.byte	0x9
	.long	0xa9
	.byte	0x8
	.uleb128 0x9
	.long	.LASF17
	.byte	0x4
	.byte	0x38
	.byte	0x9
	.long	0xa9
	.byte	0xc
	.uleb128 0x9
	.long	.LASF18
	.byte	0x4
	.byte	0x39
	.byte	0x9
	.long	0xa9
	.byte	0x10
	.uleb128 0x9
	.long	.LASF19
	.byte	0x4
	.byte	0x3a
	.byte	0x9
	.long	0xa9
	.byte	0x14
	.uleb128 0x9
	.long	.LASF20
	.byte	0x4
	.byte	0x3b
	.byte	0x9
	.long	0xa9
	.byte	0x18
	.uleb128 0x9
	.long	.LASF21
	.byte	0x4
	.byte	0x3c
	.byte	0x9
	.long	0xa9
	.byte	0x1c
	.uleb128 0x9
	.long	.LASF22
	.byte	0x4
	.byte	0x3d
	.byte	0x9
	.long	0xa9
	.byte	0x20
	.uleb128 0x9
	.long	.LASF23
	.byte	0x4
	.byte	0x40
	.byte	0x9
	.long	0xa9
	.byte	0x24
	.uleb128 0x9
	.long	.LASF24
	.byte	0x4
	.byte	0x41
	.byte	0x9
	.long	0xa9
	.byte	0x28
	.uleb128 0x9
	.long	.LASF25
	.byte	0x4
	.byte	0x42
	.byte	0x9
	.long	0xa9
	.byte	0x2c
	.uleb128 0x9
	.long	.LASF26
	.byte	0x4
	.byte	0x44
	.byte	0x16
	.long	0x24f
	.byte	0x30
	.uleb128 0x9
	.long	.LASF27
	.byte	0x4
	.byte	0x46
	.byte	0x14
	.long	0x255
	.byte	0x34
	.uleb128 0x9
	.long	.LASF28
	.byte	0x4
	.byte	0x48
	.byte	0x7
	.long	0x67
	.byte	0x38
	.uleb128 0x9
	.long	.LASF29
	.byte	0x4
	.byte	0x49
	.byte	0x7
	.long	0x67
	.byte	0x3c
	.uleb128 0x9
	.long	.LASF30
	.byte	0x4
	.byte	0x4a
	.byte	0xb
	.long	0x88
	.byte	0x40
	.uleb128 0x9
	.long	.LASF31
	.byte	0x4
	.byte	0x4d
	.byte	0x12
	.long	0x4b
	.byte	0x44
	.uleb128 0x9
	.long	.LASF32
	.byte	0x4
	.byte	0x4e
	.byte	0xf
	.long	0x59
	.byte	0x46
	.uleb128 0x9
	.long	.LASF33
	.byte	0x4
	.byte	0x4f
	.byte	0x8
	.long	0x25b
	.byte	0x47
	.uleb128 0x9
	.long	.LASF34
	.byte	0x4
	.byte	0x51
	.byte	0xf
	.long	0x26b
	.byte	0x48
	.uleb128 0x9
	.long	.LASF35
	.byte	0x4
	.byte	0x59
	.byte	0xd
	.long	0x9b
	.byte	0x4c
	.uleb128 0x9
	.long	.LASF36
	.byte	0x4
	.byte	0x5b
	.byte	0x17
	.long	0x276
	.byte	0x54
	.uleb128 0x9
	.long	.LASF37
	.byte	0x4
	.byte	0x5c
	.byte	0x19
	.long	0x281
	.byte	0x58
	.uleb128 0x9
	.long	.LASF38
	.byte	0x4
	.byte	0x5d
	.byte	0x14
	.long	0x255
	.byte	0x5c
	.uleb128 0x9
	.long	.LASF39
	.byte	0x4
	.byte	0x5e
	.byte	0x9
	.long	0xa7
	.byte	0x60
	.uleb128 0x9
	.long	.LASF40
	.byte	0x4
	.byte	0x5f
	.byte	0xa
	.long	0x25
	.byte	0x64
	.uleb128 0x9
	.long	.LASF41
	.byte	0x4
	.byte	0x60
	.byte	0x7
	.long	0x67
	.byte	0x68
	.uleb128 0x9
	.long	.LASF42
	.byte	0x4
	.byte	0x62
	.byte	0x8
	.long	0x287
	.byte	0x6c
	.byte	0
	.uleb128 0x2
	.long	.LASF43
	.byte	0x5
	.byte	0x7
	.byte	0x19
	.long	0xaf
	.uleb128 0xa
	.long	.LASF57
	.byte	0x4
	.byte	0x2b
	.byte	0xe
	.uleb128 0xb
	.long	.LASF44
	.uleb128 0x7
	.byte	0x4
	.long	0x24a
	.uleb128 0x7
	.byte	0x4
	.long	0xaf
	.uleb128 0xc
	.long	0x38
	.long	0x26b
	.uleb128 0xd
	.long	0x31
	.byte	0
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0x242
	.uleb128 0xb
	.long	.LASF45
	.uleb128 0x7
	.byte	0x4
	.long	0x271
	.uleb128 0xb
	.long	.LASF46
	.uleb128 0x7
	.byte	0x4
	.long	0x27c
	.uleb128 0xc
	.long	0x38
	.long	0x297
	.uleb128 0xd
	.long	0x31
	.byte	0x27
	.byte	0
	.uleb128 0xe
	.long	.LASF47
	.byte	0x6
	.byte	0x89
	.byte	0xe
	.long	0x2a3
	.uleb128 0x7
	.byte	0x4
	.long	0x236
	.uleb128 0xe
	.long	.LASF48
	.byte	0x6
	.byte	0x8a
	.byte	0xe
	.long	0x2a3
	.uleb128 0xe
	.long	.LASF49
	.byte	0x6
	.byte	0x8b
	.byte	0xe
	.long	0x2a3
	.uleb128 0xe
	.long	.LASF50
	.byte	0x7
	.byte	0x1a
	.byte	0xc
	.long	0x67
	.uleb128 0xc
	.long	0x2e3
	.long	0x2d8
	.uleb128 0xf
	.byte	0
	.uleb128 0x4
	.long	0x2cd
	.uleb128 0x7
	.byte	0x4
	.long	0x3f
	.uleb128 0x4
	.long	0x2dd
	.uleb128 0xe
	.long	.LASF51
	.byte	0x7
	.byte	0x1b
	.byte	0x1a
	.long	0x2d8
	.uleb128 0x10
	.long	.LASF58
	.byte	0x1
	.byte	0x10
	.byte	0x5
	.long	0x67
	.long	.LFB7
	.long	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x35d
	.uleb128 0x11
	.string	"n"
	.byte	0x1
	.byte	0x11
	.byte	0x9
	.long	0x67
	.uleb128 0x2
	.byte	0x75
	.sleb128 -28
	.uleb128 0x12
	.long	.LASF52
	.byte	0x1
	.byte	0x11
	.byte	0xd
	.long	0x35d
	.uleb128 0x2
	.byte	0x75
	.sleb128 -16
	.uleb128 0x13
	.long	.LBB5
	.long	.LBE5-.LBB5
	.long	0x345
	.uleb128 0x11
	.string	"i"
	.byte	0x1
	.byte	0x16
	.byte	0xd
	.long	0x67
	.uleb128 0x2
	.byte	0x75
	.sleb128 -24
	.byte	0
	.uleb128 0x14
	.long	.LBB6
	.long	.LBE6-.LBB6
	.uleb128 0x11
	.string	"i"
	.byte	0x1
	.byte	0x1f
	.byte	0xd
	.long	0x67
	.uleb128 0x2
	.byte	0x75
	.sleb128 -20
	.byte	0
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.long	0x67
	.uleb128 0x15
	.long	.LASF59
	.byte	0x1
	.byte	0x4
	.byte	0x6
	.long	.LFB6
	.long	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x16
	.long	.LASF52
	.byte	0x1
	.byte	0x4
	.byte	0x13
	.long	0x35d
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.string	"n"
	.byte	0x1
	.byte	0x4
	.byte	0x1d
	.long	0x67
	.uleb128 0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x14
	.long	.LBB2
	.long	.LBE2-.LBB2
	.uleb128 0x11
	.string	"i"
	.byte	0x1
	.byte	0x5
	.byte	0xd
	.long	0x67
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x14
	.long	.LBB3
	.long	.LBE3-.LBB3
	.uleb128 0x11
	.string	"j"
	.byte	0x1
	.byte	0x6
	.byte	0x11
	.long	0x67
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x14
	.long	.LBB4
	.long	.LBE4-.LBB4
	.uleb128 0x11
	.string	"tmp"
	.byte	0x1
	.byte	0x8
	.byte	0x15
	.long	0x67
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x1c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x4
	.byte	0
	.value	0
	.value	0
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	0
	.long	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF11:
	.string	"__off_t"
.LASF15:
	.string	"_IO_read_ptr"
.LASF27:
	.string	"_chain"
.LASF7:
	.string	"size_t"
.LASF33:
	.string	"_shortbuf"
.LASF21:
	.string	"_IO_buf_base"
.LASF10:
	.string	"long long unsigned int"
.LASF8:
	.string	"__int64_t"
.LASF55:
	.string	"/home/rabbit/compiler/labs/HW1/HW/H3/c"
.LASF36:
	.string	"_codecvt"
.LASF9:
	.string	"long long int"
.LASF5:
	.string	"signed char"
.LASF28:
	.string	"_fileno"
.LASF16:
	.string	"_IO_read_end"
.LASF12:
	.string	"long int"
.LASF14:
	.string	"_flags"
.LASF22:
	.string	"_IO_buf_end"
.LASF31:
	.string	"_cur_column"
.LASF45:
	.string	"_IO_codecvt"
.LASF30:
	.string	"_old_offset"
.LASF35:
	.string	"_offset"
.LASF44:
	.string	"_IO_marker"
.LASF47:
	.string	"stdin"
.LASF0:
	.string	"unsigned int"
.LASF39:
	.string	"_freeres_buf"
.LASF4:
	.string	"long unsigned int"
.LASF19:
	.string	"_IO_write_ptr"
.LASF50:
	.string	"sys_nerr"
.LASF3:
	.string	"short unsigned int"
.LASF23:
	.string	"_IO_save_base"
.LASF34:
	.string	"_lock"
.LASF29:
	.string	"_flags2"
.LASF41:
	.string	"_mode"
.LASF48:
	.string	"stdout"
.LASF59:
	.string	"my_sort"
.LASF54:
	.string	"sort.c"
.LASF20:
	.string	"_IO_write_end"
.LASF57:
	.string	"_IO_lock_t"
.LASF56:
	.string	"_IO_FILE"
.LASF51:
	.string	"sys_errlist"
.LASF53:
	.string	"GNU C17 9.3.0 -m32 -mtune=generic -march=i686 -g -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection"
.LASF26:
	.string	"_markers"
.LASF2:
	.string	"unsigned char"
.LASF6:
	.string	"short int"
.LASF46:
	.string	"_IO_wide_data"
.LASF32:
	.string	"_vtable_offset"
.LASF43:
	.string	"FILE"
.LASF1:
	.string	"char"
.LASF52:
	.string	"nums"
.LASF13:
	.string	"__off64_t"
.LASF17:
	.string	"_IO_read_base"
.LASF25:
	.string	"_IO_save_end"
.LASF40:
	.string	"__pad5"
.LASF42:
	.string	"_unused2"
.LASF49:
	.string	"stderr"
.LASF24:
	.string	"_IO_backup_base"
.LASF38:
	.string	"_freeres_list"
.LASF37:
	.string	"_wide_data"
.LASF58:
	.string	"main"
.LASF18:
	.string	"_IO_write_base"
	.hidden	__stack_chk_fail_local
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 4
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 4
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 4
4:
