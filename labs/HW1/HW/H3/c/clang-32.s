        .text
        .file   "sort.c"
        .globl  my_sort                 # -- Begin function my_sort
        .p2align        4, 0x90
        .type   my_sort,@function
my_sort:                                # @my_sort
# %bb.0:
        pushl   %ebp
        movl    %esp, %ebp
        subl    $12, %esp
        movl    12(%ebp), %eax
        movl    8(%ebp), %ecx
        movl    $0, -4(%ebp)
.LBB0_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
        movl    -4(%ebp), %eax
        cmpl    12(%ebp), %eax
        jge     .LBB0_10
# %bb.2:                                #   in Loop: Header=BB0_1 Depth=1
        movl    -4(%ebp), %eax
        addl    $1, %eax
        movl    %eax, -8(%ebp)
.LBB0_3:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
        movl    -8(%ebp), %eax
        cmpl    12(%ebp), %eax
        jge     .LBB0_8
# %bb.4:                                #   in Loop: Header=BB0_3 Depth=2
        movl    8(%ebp), %eax
        movl    -4(%ebp), %ecx
        movl    (%eax,%ecx,4), %eax
        movl    8(%ebp), %ecx
        movl    -8(%ebp), %edx
        cmpl    (%ecx,%edx,4), %eax
        jle     .LBB0_6
# %bb.5:                                #   in Loop: Header=BB0_3 Depth=2
        movl    8(%ebp), %eax
        movl    -4(%ebp), %ecx
        movl    (%eax,%ecx,4), %eax
        movl    %eax, -12(%ebp)
        movl    8(%ebp), %eax
        movl    -8(%ebp), %ecx
        movl    (%eax,%ecx,4), %eax
        movl    8(%ebp), %ecx
        movl    -4(%ebp), %edx
        movl    %eax, (%ecx,%edx,4)
        movl    -12(%ebp), %eax
        movl    8(%ebp), %ecx
        movl    -8(%ebp), %edx
        movl    %eax, (%ecx,%edx,4)
.LBB0_6:                                #   in Loop: Header=BB0_3 Depth=2
        jmp     .LBB0_7
.LBB0_7:                                #   in Loop: Header=BB0_3 Depth=2
        movl    -8(%ebp), %eax
        addl    $1, %eax
        movl    %eax, -8(%ebp)
        jmp     .LBB0_3
.LBB0_8:                                #   in Loop: Header=BB0_1 Depth=1
        jmp     .LBB0_9
.LBB0_9:                                #   in Loop: Header=BB0_1 Depth=1
        movl    -4(%ebp), %eax
        addl    $1, %eax
        movl    %eax, -4(%ebp)
        jmp     .LBB0_1
.LBB0_10:
        addl    $12, %esp
        popl    %ebp
        retl
.Lfunc_end0:
        .size   my_sort, .Lfunc_end0-my_sort
                                        # -- End function
        .globl  main                    # -- Begin function main
        .p2align        4, 0x90
        .type   main,@function
main:                                   # @main
# %bb.0:
        pushl   %ebp
        movl    %esp, %ebp
        subl    $40, %esp
        movl    $0, -4(%ebp)
        leal    .L.str, %eax            # %eax = "%d"的地址                     -------\
        movl    %eax, (%esp)            # 传参("%d")                                   |
        leal    -8(%ebp), %eax          # %eax = &n                                   | scanf("%d", &n);
        movl    %eax, 4(%esp)           # 传参&n                                       |
        calll   __isoc99_scanf          # 调用scanf                             -------/
        movl    -8(%ebp), %ecx
        shll    $2, %ecx
        movl    %ecx, (%esp)
        movl    %eax, -24(%ebp)         # 4-byte Spill
        calll   malloc
        movl    %eax, -12(%ebp)
        movl    $0, -16(%ebp)
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
        movl    -16(%ebp), %eax
        cmpl    -8(%ebp), %eax
        jge     .LBB1_4
# %bb.2:                                #   in Loop: Header=BB1_1 Depth=1
        movl    -12(%ebp), %eax
        movl    -16(%ebp), %ecx
        shll    $2, %ecx
        addl    %ecx, %eax
        leal    .L.str, %ecx            # %eax = "%d"的地址                     -------\
        movl    %ecx, (%esp)            # 传参("%d")                                   |
        movl    %eax, 4(%esp)           # 传参nums + i                                 | scanf("%d", nums+i);
        calll   __isoc99_scanf          # 调用scanf                             -------/
# %bb.3:                                #   in Loop: Header=BB1_1 Depth=1
        movl    -16(%ebp), %eax
        addl    $1, %eax
        movl    %eax, -16(%ebp)
        jmp     .LBB1_1
.LBB1_4:
        movl    -12(%ebp), %eax         # %eax = num                           -------\
        movl    -8(%ebp), %ecx          # %eax = n                                    |
        movl    %eax, (%esp)            # 传参num                                      | my_sort(nums, n);
        movl    %ecx, 4(%esp)           # 传参n                                        |
        calll   my_sort                 # 调用my_sort                          -------/
        movl    -12(%ebp), %eax
        movl    (%eax), %eax
        leal    .L.str, %ecx
        movl    %ecx, (%esp)
        movl    %eax, 4(%esp)
        calll   printf
        movl    $1, -20(%ebp)
.LBB1_5:                                # =>This Inner Loop Header: Depth=1
        movl    -20(%ebp), %eax
        cmpl    -8(%ebp), %eax
        jge     .LBB1_8
# %bb.6:                                #   in Loop: Header=BB1_5 Depth=1
        movl    -12(%ebp), %eax
        movl    -20(%ebp), %ecx
        movl    (%eax,%ecx,4), %eax
        leal    .L.str.1, %ecx
        movl    %ecx, (%esp)
        movl    %eax, 4(%esp)
        calll   printf
# %bb.7:                                #   in Loop: Header=BB1_5 Depth=1
        movl    -20(%ebp), %eax
        addl    $1, %eax
        movl    %eax, -20(%ebp)
        jmp     .LBB1_5
.LBB1_8:
        leal    .L.str.2, %eax
        movl    %eax, (%esp)
        calll   printf
        movl    -4(%ebp), %ecx
        movl    %eax, -28(%ebp)         # 4-byte Spill
        movl    %ecx, %eax
        addl    $40, %esp
        popl    %ebp
        retl
.Lfunc_end1:
        .size   main, .Lfunc_end1-main
                                        # -- End function
        .type   .L.str,@object          # @.str
        .section        .rodata.str1.1,"aMS",@progbits,1
.L.str:
        .asciz  "%d"
        .size   .L.str, 3

        .type   .L.str.1,@object        # @.str.1
.L.str.1:
        .asciz  " %d"
        .size   .L.str.1, 4

        .type   .L.str.2,@object        # @.str.2
.L.str.2:
        .asciz  "\n"
        .size   .L.str.2, 2

        .ident  "clang version 10.0.1 "
        .section        ".note.GNU-stack","",@progbits
        .addrsig
        .addrsig_sym my_sort
        .addrsig_sym __isoc99_scanf
        .addrsig_sym malloc
        .addrsig_sym printf