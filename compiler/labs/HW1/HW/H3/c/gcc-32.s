        .file   "sort.c"
        .text
        .globl  my_sort
        .type   my_sort, @function
my_sort:                                # 函数my_sort标签
.LFB2:
        .cfi_startproc
        pushl   %ebp                    # 保存基址寄存器
        .cfi_def_cfa_offset 8
        .cfi_offset 5, -8
        movl    %esp, %ebp              # 把栈顶寄存器值存入%ebp
        .cfi_def_cfa_register 5
        subl    $16, %esp               # 扩栈
        movl    $0, -12(%ebp)           # i = 0
        jmp     .L2                     # 跳转到.L2
.L6:
        movl    -12(%ebp), %eax         # %eax = i
        addl    $1, %eax                # %eax = i + 1
        movl    %eax, -8(%ebp)          # j = i + 1
        jmp     .L3                     # 跳转到.L3
.L5:
        movl    -12(%ebp), %eax         # %eax = i                              -------\
        leal    0(,%eax,4), %edx        # %edx = 4 * %eax                              |
        movl    8(%ebp), %eax           # %eax = nums                                  |
        addl    %edx, %eax              # %eax = nums + i                              |
        movl    (%eax), %edx            # %edx = nums[i]                               |
        movl    -8(%ebp), %eax          # %eax = j                                     |
        leal    0(,%eax,4), %ecx        # %ecx = 4 * %eax                              | if(nums[i] > nums[j])
        movl    8(%ebp), %eax           # %eax = nums                                  |
        addl    %ecx, %eax              # %eax = nums + j                              |
        movl    (%eax), %eax            # %eax = nums[j]                               |
        cmpl    %eax, %edx              # 比较nums[j]和nums[i]                          |
        jle     .L4                     # 如果nums[i] <= nums[j], 就跳转到.L4     -------/
        movl    -12(%ebp), %eax         # %eax = i                              -------\
        leal    0(,%eax,4), %edx        # %edx = 4 * %eax                              |
        movl    8(%ebp), %eax           # %eax = nums                                  |
        addl    %edx, %eax              # %eax = nums + i                              | tmp = nums[i]
        movl    (%eax), %eax            # %eax = nums[i]                               |
        movl    %eax, -4(%ebp)          # tmp = nums[i]                         -------/
        movl    -12(%ebp), %eax         # %eax = i                              -------\
        leal    0(,%eax,4), %edx        # %edx = 4 * %eax                              |
        movl    8(%ebp), %eax           # %eax = nums                                  |
        addl    %eax, %edx              # %edx = nums + i                              |
        movl    -8(%ebp), %eax          # %eax = j                                     |
        leal    0(,%eax,4), %ecx        # %ecx = 4 * %eax                              | nums[i] = nums[j]
        movl    8(%ebp), %eax           # %eax = nums                                  |
        addl    %ecx, %eax              # %eax = nums + j                              |
        movl    (%eax), %eax            # %eax = nums[j]                               |
        movl    %eax, (%edx)            # nums[i] = nums[j]                     -------/
        movl    -8(%ebp), %eax          # %eax = j                              -------\
        leal    0(,%eax,4), %edx        # %edx = 4 * %eax                              |
        movl    8(%ebp), %eax           # %eax = i                                     |
        addl    %eax, %edx              # %edx = nums + j                              | nums[j] = tmp
        movl    -4(%ebp), %eax          # %eax = tmp                                   |
        movl    %eax, (%edx)            # nums[j] = tmp                         -------/
.L4:
        addl    $1, -8(%ebp)            # j++
.L3:
        movl    -8(%ebp), %eax          # %eax = j
        cmpl    12(%ebp), %eax          # 比较n和j
        jl      .L5                     # 如果j < n跳转到.L5
        addl    $1, -12(%ebp)           # i++
.L2:
        movl    -12(%ebp), %eax         # %eax = i
        cmpl    12(%ebp), %eax          # 比较n和i
        jl      .L6                     # 如果i < n跳转到.L6
        nop                             # 空指令
        leave                           # 相当于pop %ebp
        .cfi_restore 5
        .cfi_def_cfa 4, 4
        ret                             # 返回
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
        leal    4(%esp), %ecx           # 加载有效地址, %ecx = %esp + 4
        .cfi_def_cfa 1, 0
        andl    $-16, %esp              # 置%esp的末四位成0, 相当于栈指针跳到某地址为用户写的程序开了一段全新的栈
        pushl   -4(%ecx)                # 原栈顶(cfi程序的)入栈
        pushl   %ebp                    # %ebp入栈, 保存基址寄存器
        .cfi_escape 0x10,0x5,0x2,0x75,0
        movl    %esp, %ebp              # %ebp = %esp, %ebp置为栈顶指针
        pushl   %ecx                    # %ecx入栈, 保存返回地址
        .cfi_escape 0xf,0x3,0x75,0x7c,0x6
        subl    $36, %esp               # 扩栈, 为main函数提供栈
        movl    %gs:20, %eax            #      
        movl    %eax, -12(%ebp)         # 将%gs:20存入-12(%ebp)
        xorl    %eax, %eax              # %eax = 0, 清零%eax          
        subl    $8, %esp                # %esp -= 8, 扩栈             -------\  
        leal    -28(%ebp), %eax         # %eax = %ebp - 28, 计算出n的地址      | scanf("%d", &n);
        pushl   %eax                    # %eax入栈, n的地址入栈                |
        pushl   $.LC0                   # .LC0地址入栈                        |
        call    __isoc99_scanf          # 调用scanf函数                       |
        addl    $16, %esp               # 函数调用结束, 退栈            -------/
        movl    -28(%ebp), %eax         # 取出n, 存入%eax              -------\
        sall    $2, %eax                # sizeof(int)*%eax                   |
        subl    $12, %esp               # 扩栈12字                            | malloc(sizeof(int)*n);
        pushl   %eax                    # %eax入栈                            |
        call    malloc                  # 调用malloc函数                       |
        addl    $16, %esp               # 调用函数结束, 退栈                    |
        movl    %eax, -16(%ebp)         # 保存返回值                           |
        movl    $0, -24(%ebp)           # i = 0                       -------/
        jmp     .L8                     # 跳转到.L8
.L9:
        movl    -24(%ebp), %eax         # %eax = i
        leal    0(,%eax,4), %edx        # %edx = %eax * 4
        movl    -16(%ebp), %eax         # %eax = nums
        addl    %edx, %eax              # %eax += %edx, 即取num+i
        subl    $8, %esp                # 扩栈                         -------\
        pushl   %eax                    # num+i入栈                           |
        pushl   $.LC0                   # "%d"入栈                            | scanf("%d", nums+i);
        call    __isoc99_scanf          # 调用scanf                           |
        addl    $16, %esp               # 退栈                         -------/
        addl    $1, -24(%ebp)           # i++
.L8:
        movl    -28(%ebp), %eax         # 取出n, 存入%eax
        cmpl    %eax, -24(%ebp)         # 比较n和i
        jl      .L9                     # 若i<n就跳转到循环体.L9
        movl    -28(%ebp), %eax         # 取出n, 存入%eax
        subl    $8, %esp                # 扩栈                         -------\
        pushl   %eax                    # %eax, 即n, 入栈                      |
        pushl   -16(%ebp)               # nums入栈                             | my_sort(nums, n);
        call    my_sort                 # 调用函数my_sort                      |
        addl    $16, %esp               # 退栈                         -------/
        movl    -16(%ebp), %eax         # %eax = nums
        movl    (%eax), %eax            # %eax = nums[0]
        subl    $8, %esp                # 扩栈                         -------\
        pushl   %eax                    # nums[0]入栈                         |
        pushl   $.LC0                   # "%d"入栈                            | printf("%d", nums[0]);
        call    printf                  # 调用printf                          |
        addl    $16, %esp               # 退栈                         -------/
        movl    $1, -20(%ebp)           # print的i = 1
        jmp     .L10                    # 跳转到.L10准备开始循环print
.L11:
        movl    -20(%ebp), %eax         # %eax = i
        leal    0(,%eax,4), %edx        # %edx = 4 * %eax
        movl    -16(%ebp), %eax         # %eax = nums
        addl    %edx, %eax              # %eax = nums + i
        movl    (%eax), %eax            # 即%eax = nums[i]
        subl    $8, %esp                # 扩栈                         -------\
        pushl   %eax                    # nums[i]入栈                         |
        pushl   $.LC1                   # " %d"入栈                           | printf(" %d", nums[i]);
        call    printf                  # 调用printf                          |
        addl    $16, %esp               # 退栈                         -------/
        addl    $1, -20(%ebp)           # i++
.L10:
        movl    -28(%ebp), %eax         # %eax = n
        cmpl    %eax, -20(%ebp)         # 比较n和i
        jl      .L11                    # 跳转到.L11
        subl    $12, %esp               # 扩栈                         -------\
        pushl   $10                     # 10(换行)入栈                         |
        call    putchar                 # 调用putchar                         | putchar('\n');
        addl    $16, %esp               # 退栈                         -------/  
        movl    $0, %eax                # %eax = 0                      
        movl    -12(%ebp), %ecx         # 读出之前的%gs:20
        xorl    %gs:20, %ecx            # 和现在的%gs:20作比较, 相等的话就会置ZF
        je      .L13                    # 检查返回地址和%ebp的值
        call    __stack_chk_fail        # 栈检查失败
.L13:
        movl    -4(%ebp), %ecx          # 前栈帧的%ebp
        .cfi_def_cfa 1, 0
        leave                           # 相当于pop %ebp
        .cfi_restore 5
        leal    -4(%ecx), %esp          # %esp = 恢复好%esp
        .cfi_def_cfa 4, 4
        ret                             # 返回
        .cfi_endproc
.LFE3:
        .size   main, .-main
        .ident  "GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
        .section        .note.GNU-stack,"",@progbits