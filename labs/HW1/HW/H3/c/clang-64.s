        .text
        .file   "sort.c"
        .globl  my_sort                 # -- Begin function my_sort
        .p2align        4, 0x90
        .type   my_sort,@function
my_sort:                                # @my_sort
        .cfi_startproc
# %bb.0:
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset %rbp, -16
        movq    %rsp, %rbp
        .cfi_def_cfa_register %rbp
        movq    %rdi, -8(%rbp)
        movl    %esi, -12(%rbp)
        movl    $0, -16(%rbp)
.LBB0_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
        movl    -16(%rbp), %eax
        cmpl    -12(%rbp), %eax
        jge     .LBB0_10
# %bb.2:                                #   in Loop: Header=BB0_1 Depth=1
        movl    -16(%rbp), %eax
        addl    $1, %eax
        movl    %eax, -20(%rbp)
.LBB0_3:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
        movl    -20(%rbp), %eax
        cmpl    -12(%rbp), %eax
        jge     .LBB0_8
# %bb.4:                                #   in Loop: Header=BB0_3 Depth=2
        movq    -8(%rbp), %rax
        movslq  -16(%rbp), %rcx         # 使用`movslq`进行带符号扩展的mov
        movl    (%rax,%rcx,4), %edx
        movq    -8(%rbp), %rax
        movslq  -20(%rbp), %rcx         # 使用`movslq`进行带符号扩展的mov
        cmpl    (%rax,%rcx,4), %edx
        jle     .LBB0_6
# %bb.5:                                #   in Loop: Header=BB0_3 Depth=2
        movq    -8(%rbp), %rax
        movslq  -16(%rbp), %rcx         # 使用`movslq`进行带符号扩展的mov
        movl    (%rax,%rcx,4), %edx
        movl    %edx, -24(%rbp)
        movq    -8(%rbp), %rax
        movslq  -20(%rbp), %rcx         # 使用`movslq`进行带符号扩展的mov
        movl    (%rax,%rcx,4), %edx
        movq    -8(%rbp), %rax
        movslq  -16(%rbp), %rcx         # 使用`movslq`进行带符号扩展的mov
        movl    %edx, (%rax,%rcx,4)
        movl    -24(%rbp), %edx
        movq    -8(%rbp), %rax
        movslq  -20(%rbp), %rcx         # 使用`movslq`进行带符号扩展的mov
        movl    %edx, (%rax,%rcx,4)
.LBB0_6:                                #   in Loop: Header=BB0_3 Depth=2
        jmp     .LBB0_7
.LBB0_7:                                #   in Loop: Header=BB0_3 Depth=2
        movl    -20(%rbp), %eax
        addl    $1, %eax
        movl    %eax, -20(%rbp)
        jmp     .LBB0_3
.LBB0_8:                                #   in Loop: Header=BB0_1 Depth=1
        jmp     .LBB0_9
.LBB0_9:                                #   in Loop: Header=BB0_1 Depth=1
        movl    -16(%rbp), %eax
        addl    $1, %eax
        movl    %eax, -16(%rbp)
        jmp     .LBB0_1
.LBB0_10:
        popq    %rbp
        .cfi_def_cfa %rsp, 8
        retq
.Lfunc_end0:
        .size   my_sort, .Lfunc_end0-my_sort
        .cfi_endproc
                                        # -- End function
        .globl  main                    # -- Begin function main
        .p2align        4, 0x90
        .type   main,@function
main:                                   # @main
        .cfi_startproc
# %bb.0:
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset %rbp, -16
        movq    %rsp, %rbp
        .cfi_def_cfa_register %rbp
        subq    $32, %rsp
        movl    $0, -4(%rbp)
        movabsq $.L.str, %rdi           # 用movabsq取字符串地址
        leaq    -8(%rbp), %rsi
        movb    $0, %al
        callq   __isoc99_scanf
        movslq  -8(%rbp), %rcx         # 使用`movslq`进行带符号扩展的mov
        shlq    $2, %rcx
        movq    %rcx, %rdi
        movl    %eax, -28(%rbp)         # 4-byte Spill
        callq   malloc
        movq    %rax, -16(%rbp)
        movl    $0, -20(%rbp)
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
        movl    -20(%rbp), %eax
        cmpl    -8(%rbp), %eax
        jge     .LBB1_4
# %bb.2:                                #   in Loop: Header=BB1_1 Depth=1
        movq    -16(%rbp), %rax
        movslq  -20(%rbp), %rcx         # 使用`movslq`进行带符号扩展的mov
        shlq    $2, %rcx
        addq    %rcx, %rax
        movabsq $.L.str, %rdi           # 用movabsq取字符串地址
        movq    %rax, %rsi
        movb    $0, %al
        callq   __isoc99_scanf
# %bb.3:                                #   in Loop: Header=BB1_1 Depth=1
        movl    -20(%rbp), %eax
        addl    $1, %eax
        movl    %eax, -20(%rbp)
        jmp     .LBB1_1
.LBB1_4:
        movq    -16(%rbp), %rdi
        movl    -8(%rbp), %esi
        callq   my_sort
        movq    -16(%rbp), %rax
        movl    (%rax), %esi
        movabsq $.L.str, %rdi           # 用movabsq取字符串地址
        movb    $0, %al
        callq   printf
        movl    $1, -24(%rbp)
.LBB1_5:                                # =>This Inner Loop Header: Depth=1
        movl    -24(%rbp), %eax
        cmpl    -8(%rbp), %eax
        jge     .LBB1_8
# %bb.6:                                #   in Loop: Header=BB1_5 Depth=1
        movq    -16(%rbp), %rax
        movslq  -24(%rbp), %rcx         # 使用`movslq`进行带符号扩展的mov
        movl    (%rax,%rcx,4), %esi
        movabsq $.L.str.1, %rdi           # 用movabsq取字符串地址
        movb    $0, %al
        callq   printf
# %bb.7:                                #   in Loop: Header=BB1_5 Depth=1
        movl    -24(%rbp), %eax
        addl    $1, %eax
        movl    %eax, -24(%rbp)
        jmp     .LBB1_5
.LBB1_8:
        movabsq $.L.str.2, %rdi           # 用movabsq取字符串地址
        movb    $0, %al
        callq   printf
        movl    -4(%rbp), %ecx
        movl    %eax, -32(%rbp)         # 4-byte Spill
        movl    %ecx, %eax
        addq    $32, %rsp
        popq    %rbp
        .cfi_def_cfa %rsp, 8
        retq
.Lfunc_end1:
        .size   main, .Lfunc_end1-main
        .cfi_endproc
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