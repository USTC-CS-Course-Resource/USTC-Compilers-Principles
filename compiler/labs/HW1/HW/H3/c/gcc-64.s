        .file   "sort.c"
        .text
        .globl  my_sort
        .type   my_sort, @function
my_sort:
.LFB2:
        .cfi_startproc
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        movq    %rsp, %rbp
        .cfi_def_cfa_register 6
        movq    %rdi, -24(%rbp)
        movl    %esi, -28(%rbp)
        movl    $0, -12(%rbp)
        jmp     .L2
.L6:
        movl    -12(%rbp), %eax
        addl    $1, %eax
        movl    %eax, -8(%rbp)
        jmp     .L3
.L5:
        movl    -12(%rbp), %eax
        cltq                                # 将32位%eax扩展为64位%rax
        leaq    0(,%rax,4), %rdx
        movq    -24(%rbp), %rax
        addq    %rdx, %rax
        movl    (%rax), %edx
        movl    -8(%rbp), %eax
        cltq                                # 将32位%eax扩展为64位%rax
        leaq    0(,%rax,4), %rcx
        movq    -24(%rbp), %rax
        addq    %rcx, %rax
        movl    (%rax), %eax
        cmpl    %eax, %edx
        jle     .L4
        movl    -12(%rbp), %eax
        cltq                                # 将32位%eax扩展为64位%rax
        leaq    0(,%rax,4), %rdx
        movq    -24(%rbp), %rax
        addq    %rdx, %rax
        movl    (%rax), %eax
        movl    %eax, -4(%rbp)
        movl    -12(%rbp), %eax
        cltq                                # 将32位%eax扩展为64位%rax
        leaq    0(,%rax,4), %rdx
        movq    -24(%rbp), %rax
        addq    %rax, %rdx
        movl    -8(%rbp), %eax
        cltq                                # 将32位%eax扩展为64位%rax
        leaq    0(,%rax,4), %rcx
        movq    -24(%rbp), %rax
        addq    %rcx, %rax
        movl    (%rax), %eax
        movl    %eax, (%rdx)
        movl    -8(%rbp), %eax
        cltq                                # 将32位%eax扩展为64位%rax
        leaq    0(,%rax,4), %rdx
        movq    -24(%rbp), %rax
        addq    %rax, %rdx
        movl    -4(%rbp), %eax
        movl    %eax, (%rdx)
.L4:
        addl    $1, -8(%rbp)
.L3:
        movl    -8(%rbp), %eax
        cmpl    -28(%rbp), %eax
        jl      .L5
        addl    $1, -12(%rbp)
.L2:
        movl    -12(%rbp), %eax
        cmpl    -28(%rbp), %eax
        jl      .L6
        nop
        popq    %rbp
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE2:
        .size   my_sort, .-my_sort
        .section        .rodata
.LC0:
        .string "%d"
.LC1:
        .string " %d"
        .text
        .globl  main
        .type   main, @function
main:
.LFB3:
        .cfi_startproc
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        movq    %rsp, %rbp
        .cfi_def_cfa_register 6
        subq    $32, %rsp
        movq    %fs:40, %rax
        movq    %rax, -8(%rbp)
        xorl    %eax, %eax
        leaq    -28(%rbp), %rax
        movq    %rax, %rsi                  # 为scanf传参(&n)                   -------\
        movl    $.LC0, %edi                 # 为scanf传参("%d")                        |
        movl    $0, %eax                    # 设置%eax为0                              | scanf("%d", &n);
        call    __isoc99_scanf              # 调用scanf                        -------/
        movl    -28(%rbp), %eax             # %eax = n                               
        cltq                                # 扩展%eax的32位到%rax的64位
        salq    $2, %rax
        movq    %rax, %rdi                  # 为malloc传参                      -------\
        call    malloc                      # 调用malloc                        -------/ malloc(sizeof(int)*n)
        movq    %rax, -16(%rbp)
        movl    $0, -24(%rbp)
        jmp     .L8
.L9:
        movl    -24(%rbp), %eax
        cltq
        leaq    0(,%rax,4), %rdx
        movq    -16(%rbp), %rax
        addq    %rdx, %rax
        movq    %rax, %rsi                  # 为scanf传参(&n)                   -------\
        movl    $.LC0, %edi                 # 为scanf传参("%d")                        |
        movl    $0, %eax                    #                                         | scanf("%d", &n);
        call    __isoc99_scanf              # 调用scanf                        -------/
        addl    $1, -24(%rbp)
.L8:
        movl    -28(%rbp), %eax
        cmpl    %eax, -24(%rbp)
        jl      .L9
        movl    -28(%rbp), %edx
        movq    -16(%rbp), %rax             # %rax = nums
        movl    %edx, %esi                  # 为my_sort传参(n)                 -------\
        movq    %rax, %rdi                  # 为my_sort传参(nums)                     | my_sort(nums, n);
        call    my_sort                     # 调用my_sort                     -------/
        movq    -16(%rbp), %rax
        movl    (%rax), %eax
        movl    %eax, %esi                  # 为printf传参(nums[0])            -------\
        movl    $.LC0, %edi                 # 为printf传参("%d")                      | printf("%d", nums[0]);
        movl    $0, %eax                    #                                        |
        call    printf                      # 调用printf                      -------/
        movl    $1, -20(%rbp)
        jmp     .L10
.L11:
        movl    -20(%rbp), %eax
        cltq                                # 将32位%eax扩展为64位%rax
        leaq    0(,%rax,4), %rdx
        movq    -16(%rbp), %rax
        addq    %rdx, %rax
        movl    (%rax), %eax
        movl    %eax, %esi
        movl    $.LC1, %edi
        movl    $0, %eax
        call    printf
        addl    $1, -20(%rbp)
.L10:
        movl    -28(%rbp), %eax
        cmpl    %eax, -20(%rbp)
        jl      .L11
        movl    $10, %edi                   # 为putchar传参('\n')              -------\ putchar('\n')
        call    putchar                     # 调用putchar                      -------/
        movl    $0, %eax
        movq    -8(%rbp), %rcx
        xorq    %fs:40, %rcx                #                                 -------\
        je      .L13                        #                                        | 栈检验
        call    __stack_chk_fail            #                                 -------/
.L13:
        leave
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE3:
        .size   main, .-main
        .ident  "GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
        .section        .note.GNU-stack,"",@progbits