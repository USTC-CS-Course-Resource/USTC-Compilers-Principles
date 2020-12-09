	.text
	.file	"func1.c"
	.globl	fun1                    // -- Begin function fun1
	.p2align	2
	.type	fun1,@function
fun1:                                   // @fun1
// %bb.0:
	sub	sp, sp, #16             // =16
	str	w0, [sp, #12]
	ldr	w8, [sp, #12]
	scvtf	s0, w8
	add	sp, sp, #16             // =16
	ret
.Lfunc_end0:
	.size	fun1, .Lfunc_end0-fun1
                                        // -- End function
	.globl	fun2                    // -- Begin function fun2
	.p2align	2
	.type	fun2,@function
fun2:                                   // @fun2
// %bb.0:
	sub	sp, sp, #16             // =16
	str	w0, [sp, #12]
	ldr	w8, [sp, #12]
	scvtf	d0, w8
	add	sp, sp, #16             // =16
	ret
.Lfunc_end1:
	.size	fun2, .Lfunc_end1-fun2
                                        // -- End function
	.globl	main                    // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
// %bb.0:
	sub	sp, sp, #32             // =32
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w8, #26214
	movk	w8, #16486, lsl #16
	fmov	s0, w8
	mov	x9, #-3689348814741910324
	movk	x9, #52429
	movk	x9, #16406, lsl #48
	fmov	d1, x9
	stur	s0, [x29, #-4]
	str	d1, [sp]
	ldur	s0, [x29, #-4]
	fcvtzs	w0, s0
	bl	fun1
	ldr	d1, [sp]
	fcvtzs	w0, d1
	bl	fun2
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	add	sp, sp, #32             // =32
	ret
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        // -- End function
	.ident	"clang version 10.0.1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym fun1
	.addrsig_sym fun2
