	.text
	.file	"control.c"
	.globl	main                    // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
// %bb.0:
	sub	sp, sp, #16             // =16
	str	wzr, [sp, #12]
	ldr	w8, [sp, #12]			// 读 i 到 w8
	cbnz	w8, .LBB0_11		// 若非零则跳到.LBB0_11
// %bb.1:
.LBB0_2:                                // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_5 Depth 2
	ldr	w8, [sp, #12]			// i
	cmp	w8, #5                  // =5 // i 和 5比较
	b.ne	.LBB0_4				// 若 i != 5就跳转到.LBB0_4
// %bb.3:
	b	.LBB0_10				// 否则 break
.LBB0_4:                                //   in Loop: Header=BB0_2 Depth=1
.LBB0_5:                                //   Parent Loop BB0_2 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldr	w8, [sp, #12]
	cmp	w8, #5                  // =5, for loop 里的判断 i < 5
	b.ge	.LBB0_8				// for loop 的结束跳转
// %bb.6:                               //   in Loop: Header=BB0_5 Depth=2
// %bb.7:                               //   in Loop: Header=BB0_5 Depth=2
	ldr	w8, [sp, #12]			// 
	add	w8, w8, #1              // =1  for loop 里的 i++
	str	w8, [sp, #12]
	b	.LBB0_5					// for loop 循环结束的跳转(也是continue)
.LBB0_8:                                //   in Loop: Header=BB0_2 Depth=1
// %bb.9:                               //   in Loop: Header=BB0_2 Depth=1
	b	.LBB0_2
.LBB0_10:
.LBB0_11:
	add	sp, sp, #16             // =16
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        // -- End function
	.ident	"clang version 10.0.1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
