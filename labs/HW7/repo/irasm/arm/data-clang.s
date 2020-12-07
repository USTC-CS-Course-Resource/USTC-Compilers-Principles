	.text
	.file	"data.c"
	.globl	func                    // -- Begin function func
	.p2align	2
	.type	func,@function
func:                                   // @func
// %bb.0:
	sub	sp, sp, #16             // =16
	mov	w8, #40
	strh	w8, [sp, #14]
	add	sp, sp, #16             // =16
	ret
.Lfunc_end0:
	.size	func, .Lfunc_end0-func
                                        // -- End function
	.type	bb,@object              // @bb
	.data
	.globl	bb
	.p2align	1
bb:
	.hword	20                      // 0x14
	.size	bb, 2

	.type	func.cc,@object         // @func.cc
	.p2align	3
func.cc:
	.xword	30                      // 0x1e
	.size	func.cc, 8

	.ident	"clang version 10.0.1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
