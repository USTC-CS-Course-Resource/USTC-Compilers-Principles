	.text
	.file	"fact.c"
	.globl	f2                      // -- Begin function f2
	.p2align	2
	.type	f2,@function
f2:                                     // @f2
// %bb.0:
	sub	sp, sp, #48             // =48
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	adrp	x8, f2.m
	add	x8, x8, :lo12:f2.m
	stur	w0, [x29, #-8]
	ldur	w9, [x29, #-8]
	str	w9, [x8]
	ldr	w9, [x8]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	cbnz	w9, .LBB0_2
// %bb.1:
	mov	w8, #1
	stur	w8, [x29, #-4]
	b	.LBB0_3
.LBB0_2:
	ldr	x8, [sp, #16]           // 8-byte Folded Reload
	ldr	w9, [x8]
	ldr	w10, [x8]
	subs	w0, w10, #1             // =1
	str	w9, [sp, #12]           // 4-byte Folded Spill
	bl	f2
	ldr	w9, [sp, #12]           // 4-byte Folded Reload
	mul	w10, w9, w0
	stur	w10, [x29, #-4]
.LBB0_3:
	ldur	w0, [x29, #-4]
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	add	sp, sp, #48             // =48
	ret
.Lfunc_end0:
	.size	f2, .Lfunc_end0-f2
                                        // -- End function
	.globl	f1                      // -- Begin function f1
	.p2align	2
	.type	f1,@function
f1:                                     // @f1
// %bb.0:
	sub	sp, sp, #32             // =32
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	str	w0, [sp, #8]
	ldr	w8, [sp, #8]
	cbnz	w8, .LBB1_2
// %bb.1:
	mov	w8, #1
	stur	w8, [x29, #-4]
	b	.LBB1_3
.LBB1_2:
	ldr	w8, [sp, #8]
	ldr	w9, [sp, #8]
	subs	w0, w9, #1              // =1
	str	w8, [sp, #4]            // 4-byte Folded Spill
	bl	f1
	ldr	w8, [sp, #4]            // 4-byte Folded Reload
	mul	w9, w8, w0
	stur	w9, [x29, #-4]
.LBB1_3:
	ldur	w0, [x29, #-4]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	add	sp, sp, #32             // =32
	ret
.Lfunc_end1:
	.size	f1, .Lfunc_end1-f1
                                        // -- End function
	.globl	f3                      // -- Begin function f3
	.p2align	2
	.type	f3,@function
f3:                                     // @f3
// %bb.0:
	sub	sp, sp, #48             // =48
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	adrp	x8, n
	add	x8, x8, :lo12:n
	adrp	x9, f3
	add	x9, x9, :lo12:f3
	ldr	w10, [x8]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	str	x9, [sp, #8]            // 8-byte Folded Spill
	cbnz	w10, .LBB2_2
// %bb.1:
	mov	w8, #1
	stur	w8, [x29, #-4]
	b	.LBB2_3
.LBB2_2:
	ldr	x8, [sp, #16]           // 8-byte Folded Reload
	ldr	w9, [x8]
	ldr	w10, [x8]
	subs	w0, w10, #1             // =1
	ldr	x11, [sp, #8]           // 8-byte Folded Reload
	str	w9, [sp, #4]            // 4-byte Folded Spill
	blr	x11
	ldr	w9, [sp, #4]            // 4-byte Folded Reload
	mul	w10, w9, w0
	stur	w10, [x29, #-4]
.LBB2_3:
	ldur	w0, [x29, #-4]
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	add	sp, sp, #48             // =48
	ret
.Lfunc_end2:
	.size	f3, .Lfunc_end2-f3
                                        // -- End function
	.globl	main                    // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
// %bb.0:
	sub	sp, sp, #48             // =48
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	w8, #3
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	mov	w9, wzr
	stur	x0, [x29, #-8]          // 8-byte Folded Spill
	mov	w0, w8
	stur	w8, [x29, #-12]         // 4-byte Folded Spill
	str	w9, [sp, #16]           // 4-byte Folded Spill
	bl	f1
	ldur	w8, [x29, #-12]         // 4-byte Folded Reload
	str	w0, [sp, #12]           // 4-byte Folded Spill
	mov	w0, w8
	bl	f2
	ldur	x10, [x29, #-8]         // 8-byte Folded Reload
	str	w0, [sp, #8]            // 4-byte Folded Spill
	mov	x0, x10
	ldr	w1, [sp, #12]           // 4-byte Folded Reload
	ldr	w2, [sp, #8]            // 4-byte Folded Reload
	bl	printf
	ldr	w8, [sp, #16]           // 4-byte Folded Reload
	mov	w0, w8
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	add	sp, sp, #48             // =48
	ret
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
                                        // -- End function
	.type	f2.m,@object            // @f2.m
	.local	f2.m
	.comm	f2.m,4,4
	.type	n,@object               // @n
	.data
	.globl	n
	.p2align	2
n:
	.word	3                       // 0x3
	.size	n, 4

	.type	.L.str,@object          // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d, %d"
	.size	.L.str, 7

	.ident	"clang version 10.0.1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym f2
	.addrsig_sym f1
	.addrsig_sym f3
	.addrsig_sym printf
	.addrsig_sym f2.m
	.addrsig_sym n
