	.text
	.file	"switch.c"
	.globl	main                    // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
// %bb.0:
	sub	sp, sp, #32             // =32
	mov	w8, #50
	str	wzr, [sp, #28]
	str	w8, [sp, #24]
	ldr	w8, [sp, #24]
	ldr	w9, [sp, #24]
	mul	w8, w8, w9
	cmp	w8, #10                 // =10
	str	w8, [sp, #20]           // 4-byte Folded Spill
	b.eq	.LBB0_5
	b	.LBB0_1
.LBB0_1:
	ldr	w8, [sp, #20]           // 4-byte Folded Reload
	cmp	w8, #20                 // =20
	b.eq	.LBB0_9
	b	.LBB0_2
.LBB0_2:
	ldr	w8, [sp, #20]           // 4-byte Folded Reload
	cmp	w8, #50                 // =50
	b.eq	.LBB0_7
	b	.LBB0_3
.LBB0_3:
	ldr	w8, [sp, #20]           // 4-byte Folded Reload
	cmp	w8, #70                 // =70
	b.eq	.LBB0_8
	b	.LBB0_4
.LBB0_4:
	ldr	w8, [sp, #20]           // 4-byte Folded Reload
	cmp	w8, #80                 // =80
	b.eq	.LBB0_6
	b	.LBB0_10
.LBB0_5:
	mov	w8, #10
	str	w8, [sp, #24]
	b	.LBB0_11
.LBB0_6:
	mov	w8, #80
	str	w8, [sp, #24]
	b	.LBB0_11
.LBB0_7:
	mov	w8, #50
	str	w8, [sp, #24]
	b	.LBB0_11
.LBB0_8:
	mov	w8, #70
	str	w8, [sp, #24]
	b	.LBB0_11
.LBB0_9:
	mov	w8, #20
	str	w8, [sp, #24]
	b	.LBB0_11
.LBB0_10:
	mov	w8, #40
	str	w8, [sp, #24]
.LBB0_11:
	ldr	w8, [sp, #24]
	ldr	w9, [sp, #24]
	mul	w8, w8, w9
	subs	w8, w8, #1              // =1
	mov	w10, w8
	ubfx	x10, x10, #0, #32
	cmp	x10, #9                 // =9
	str	x10, [sp, #8]           // 8-byte Folded Spill
	b.hi	.LBB0_20
// %bb.12:
	adrp	x8, .LJTI0_0
	add	x8, x8, :lo12:.LJTI0_0
	ldr	x11, [sp, #8]           // 8-byte Folded Reload
	ldrsw	x10, [x8, x11, lsl #2]
	add	x9, x8, x10
	br	x9
.LBB0_13:
	mov	w8, #7
	str	w8, [sp, #24]
	b	.LBB0_21
.LBB0_14:
	mov	w8, #1
	str	w8, [sp, #24]
	b	.LBB0_21
.LBB0_15:
	mov	w8, #6
	str	w8, [sp, #24]
	b	.LBB0_21
.LBB0_16:
	mov	w8, #9
	str	w8, [sp, #24]
	b	.LBB0_21
.LBB0_17:
	mov	w8, #5
	str	w8, [sp, #24]
	b	.LBB0_21
.LBB0_18:
	mov	w8, #10
	str	w8, [sp, #24]
	b	.LBB0_21
.LBB0_19:
	mov	w8, #2
	str	w8, [sp, #24]
	b	.LBB0_21
.LBB0_20:
	mov	w8, #40
	str	w8, [sp, #24]
.LBB0_21:
	ldr	w0, [sp, #28]
	add	sp, sp, #32             // =32
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.section	.rodata,"a",@progbits
	.p2align	2
.LJTI0_0:
	.word	.LBB0_14-.LJTI0_0
	.word	.LBB0_19-.LJTI0_0
	.word	.LBB0_20-.LJTI0_0
	.word	.LBB0_20-.LJTI0_0
	.word	.LBB0_17-.LJTI0_0
	.word	.LBB0_15-.LJTI0_0
	.word	.LBB0_13-.LJTI0_0
	.word	.LBB0_20-.LJTI0_0
	.word	.LBB0_16-.LJTI0_0
	.word	.LBB0_18-.LJTI0_0
                                        // -- End function
	.ident	"clang version 10.0.1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
