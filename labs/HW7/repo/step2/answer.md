# 中间代码与汇编码理解

## step2

### 1. 分析 `src/switch.c` 文件及其汇编码和中间码

#### 1)

经过对比, 其 `main` 函数内所有内容都是一致的, 区别在于其他边边角角的地方, 下面列举之:

- `target datalayout` 和 `target triple` 的不同: 这是很自然的, 因为目标平台不同.
- `x86-32` 的结果中 `frame-pointer=non-leaf`
- `target-cpu` 取值不同: 这是由于目标平台不同导致的.
- 64位平台有 `target-feature`: 可用来指示使用如 `mmx` 这样的长寄存器.

#### 2)
二者结构上没什么太大区别.

##### 以第一个为例讲述其特征
- 特征就是用了一个 `switch` 语句来跳转到指定位置, 以执行指定语句.
- 由于有 `break`, 每个块最后又有一句跳转出去的 `br` 指令.

##### 在 `LLVM IR` 上引入 `switch` 的好处
- 首先是方便了程序员观察与描写
- 其次, `switch` 是一个可以根据其特征进行不同优化的语句, 如果保留住 `switch`, 将很可能有利于编译器的进一步优化

#### 3)
- 前一个因为每个取值比较稀疏, 因此就是直接进行 `比较 + 跳转` 这样的一系列动作. 但值得一提的是, 编译器会把整个跳转弄成一个 `二分查找` 的结构, 而非线性查找结构, 这有利于提高效率.
- 而后一个中, 编译器观察到了其每个取值的相近, 因此使用了跳转表(`.L12`处)来进行直接跳转, 这样有利于提高 cache hit ratio, 且也能快速到达目标代码位置.

#### 4)
13-32 行注释如下
```arm
    mul    w0, w1, w0                ; w0 和 w1 分别是 50 和 50, 这句是为了计算 i*i
    cmp    w0, 50                    ; 比较 i*i 和 50 的大小关系
    beq    .L3                        ; 如果 i*i == 50, 跳转到 .L3
    cmp    w0, 50                    ; 比较 i*i 和 50 的大小关系
    bgt    .L4                        ; 如果 i*i > 50, 跳转到 .L4
    cmp    w0, 10                    ; 比较 i*i 和 10
    beq    .L5                        ; 如果 i*i == 10, 跳转到 .L5
    cmp    w0, 20                    ; 比较 i*i 和 20
    beq    .L6                        ; 如果 i*i == 20, 跳转到 .L6
    b    .L2
.L4:
    cmp    w0, 70                    ; 比较 i*i 和 70
    beq    .L7                        ; 如果 i*i == 70, 跳转到 .L7
    cmp    w0, 80                    ; 比较 i*i 和 80
    beq    .L8                        ; 如果 i*i == 80, 跳转到 .L8
    b    .L2
.L5:
    mov    w0, 10                    ; 如果跳转到此说明 i*i==10, 故赋值 10 给 i
    str    w0, [sp, 12]            ; 然后把 i 存回内存
    b    .L9                        ; 相当于 break
```

52-84行注释如下:
```asm
.L9:
    ldr    w1, [sp, 12]                    ; i = w1 = 50
    ldr    w0, [sp, 12]                    ; i = w0 = 50
    mul    w0, w1, w0                        ; i*i = w1 * w0
    sub    w0, w0, #1                        ; w0 = i*i-1
    cmp    w0, 9                            ; i*i-1 和 9 比较 
    bhi    .L10                            ; 如果大于, 则跳转到 default(.L10)
    adrp    x1, .L12                    ; 读取 .L12 的页基址
    add    x1, x1, :lo12:.L12                ; 读取 .L12 的地址
    ldr    w0, [x1,w0,uxtw #2]                ; 从x1开始w0*4处取值. 这里uxtw #2 是扩展, 相当于左移两位, 这里是为了取地址.
    adr    x1, .Lrtx12                        ; 取 .Lrtx12 地址 到 x1
    add    x0, x1, w0, sxtw #2                ; 计算跳转目标为 x0=x1 + w0*4
    br    x0                                ; 跳转到 x0
.Lrtx12:
    .section    .rodata
    .align    0
    .align    2
.L12:                                    ; 这就是一系列跳转表
    .word    (.L11 - .Lrtx12) / 4
    .word    (.L13 - .Lrtx12) / 4
    .word    (.L10 - .Lrtx12) / 4
    .word    (.L10 - .Lrtx12) / 4
    .word    (.L14 - .Lrtx12) / 4
    .word    (.L15 - .Lrtx12) / 4
    .word    (.L16 - .Lrtx12) / 4
    .word    (.L10 - .Lrtx12) / 4
    .word    (.L17 - .Lrtx12) / 4
    .word    (.L18 - .Lrtx12) / 4
    .text
.L16:
    mov    w0, 7                            ; 如果跳转到这, 则 i = w0 = 7
    str    w0, [sp, 12]                    ; 存数 i
    b    .L19                            ; 跳转, 相当于 break
```

#### 5)

不同之处:
1. `clang` 对于每个 `比较 + 跳转` 块都有一个标签, 感觉和 LLVM 有关系
2. `clang` 的跳转表中地址计算没有 `/4` 的操作, 故计算目标代码标签地址的时候也没有左移操作.
3. 其他都是一些顺序上之类的不同, 我认为不必过于细究

#### 6)
二者除了指令和寄存器上的区别可以说是几乎一样的, 甚至行数只差了一行, 通过观察, 这行多的代码并不是核心代码. 非要说有什么区别的话, 有
1. `%rbp` 和 `%ebp` 之分

#### 7)
13-33行注释:
```asm
    movl    $50, -4(%rbp)            ; 存入 50
    movl    -4(%rbp), %eax            ; i=%eax=50
    imull    -4(%rbp), %eax            ; i*i
    cmpl    $50, %eax                ; i*i 和 50 比较
    je    .L3                            ; 如果 i*i==50, 跳转到 .L3
    cmpl    $50, %eax                ; 
    jg    .L4                            ; 如果 i*i > 50, 跳转到 .L4
    cmpl    $10, %eax                ;
    je    .L5                            ; 如果 i*i == 10, 跳转到 .L5
    cmpl    $20, %eax                ;
    je    .L6                            ; 如果 i*i == 20, 跳转到 .L6
    jmp    .L2                            ; 默认跳转为 .L2
.L4:
    cmpl    $70, %eax                ; 
    je    .L7                            ; 如果 i*i==70, 跳转到 .L7
    cmpl    $80, %eax                ;
    je    .L8                            ; 如果 i*i==80, 跳转到 .L8
    jmp    .L2                            ; 默认跳转为 .L2
.L5:
    movl    $10, -4(%rbp)            ; 如果跳转到此, 说明 i*i==10, 故赋值i=10(直接存入地址)
    jmp    .L9                            ; 相当于 break
```

48-74行注释:
```asm
.L9:
    movl    -4(%rbp), %eax            ; 取 i
    imull    -4(%rbp), %eax            ; 求 i*i
    cmpl    $10, %eax                ; 比较 10 和 i*i
    ja    .L10                        ; 如果 i*i>10, 跳转到 .L10
    movl    %eax, %eax                ; 
    movq    .L12(,%rax,8), %rax        ; 计算偏移, %rax = .L12地址+8*%rax
    jmp    *%rax                        ; 直接跳转过去
    .section    .rodata                ; 对齐等
    .align 8
    .align 4
.L12:                                ; 跳转表
    .quad    .L10
    .quad    .L11
    .quad    .L13
    .quad    .L10
    .quad    .L10
    .quad    .L14
    .quad    .L15
    .quad    .L16
    .quad    .L10
    .quad    .L17
    .quad    .L18
    .text
.L16:
    movl    $7, -4(%rbp)            ; 如果跳转到这, 说明i*i==7, 赋值即可
    jmp    .L19                        ; 相当于 break
```

### 2. 关于 `step2/control.c` 的分析

#### 总述

- 对于 `LLVM IR` 来说, 除了因为 `machine`, 版本 等带来的的不同外, 结果几乎没有差别, 特别是 main 函数内的结果可以说是一模一样
- 对于 `clang` 的汇编结果, 他自己就给出了一些关于 `loop` 的注释, 因此十分易读
- 对于 `gcc` 的汇编结果, 虽然没有注释, 但由于我写的 `control.c` 十分简练(而不失完整性), 因此也不会不好读
- 对于 `64位` 和 `32位` 平台的区别: 可以认为只有一些小细节不一样.

下面分述之:

#### LLVM IR

各种情况下的 `LLVM IR` 依然是基本一致的, 不同地方与前面第一题基本上一致, 即(从前面复制过来了):
- `target datalayout` 和 `target triple` 的不同: 这是很自然的, 因为目标平台不同.
- `x86-32` 的结果中 `frame-pointer=non-leaf`
- `target-cpu` 取值不同: 这是由于目标平台不同导致的.
- 64位平台有 `target-feature`: 可用来指示使用如 `mmx` 这样的长寄存器.

至于代码本身, 可以对 `arm` 下的相应 `LLVM IR` 核心代码做如下注释:
```llvm
  %1 = alloca i32, align 4          ; 
  store i32 0, i32* %1, align 4     ; i = 0
  %2 = load i32, i32* %1, align 4   ;
  %3 = icmp eq i32 %2, 0            ; if (i == 0)
  br i1 %3, label %4, label %20     ;   goto %4, else goto %20

4:                                                ; preds = %0
  br label %5                       ; while(1)

5:                                                ; preds = %4, %18
  %6 = load i32, i32* %1, align 4   ;
  %7 = icmp eq i32 %6, 5            ; if (i == 5)
  br i1 %7, label %8, label %9      ;   break; else for loop

8:                                                ; preds = %5
  br label %19                      ; break;

9:                                                ; preds = %5
  br label %10                      ; goto for loop

10:                                               ; preds = %14, %9
  %11 = load i32, i32* %1, align 4  ; 
  %12 = icmp slt i32 %11, 5         ; is i < 5 ?
  br i1 %12, label %13, label %17   ;  goto %13 else goto %17

13:                                               ; preds = %10
  br label %14                      ; goto %14

14:                                               ; preds = %13
  %15 = load i32, i32* %1, align 4  ;
  %16 = add nsw i32 %15, 1          ; i++
  store i32 %16, i32* %1, align 4   ;
  br label %10                      ; goto start of for loop 

17:                                               ; preds = %10
  br label %18

18:                                               ; preds = %17
  br label %5

19:                                               ; preds = %8
  br label %20
```

#### x86 下的结果

经过对比, 同一种编译器, 为不同位机器生成的代码基本一致, 其微小的区别前面也已提过, 因此针对 64位 情况做一点说明:
- 对于 `gcc` 的结果中核心代码注释如下(因为已经注释很清楚了就不多做描述了):
    ```asm
        movl    $0, -4(%rbp)            ; i = 0;           int i = 0;                
        cmpl    $0, -4(%rbp)            ; 比较 i 和 0    
        jne    .L8                      ; 若i != 0, 转.L8    if(i == 0) {
    .L6:                                ;                      while(1) {
        cmpl    $5, -4(%rbp)            ; 否则就进入了 .L6          if (i == 5)
        je    .L9                       ;                          break;
        jmp    .L4                      ;                        else {
    .L5:                                ;                          for (; i < 5; i++)
        addl    $1, -4(%rbp)            ; for 循环自加
    .L4:
        cmpl    $4, -4(%rbp)            ; for 循环判i<5
        jle    .L5                      ;                            continue
        jmp    .L6                      ;                      }
    .L9:
        nop                             ;                    
    .L8:                                ;                    }
        nop
    ```
- 对于 `clang` 的结果则更为友好了, 它自动标注出了 loop 的地方, 对比一下 `gcc` 的结果发现其实大同小异, 因此就不多描述了.
    ```asm
        movl    $0, -4(%rbp)
        cmpl    $0, -4(%rbp)
        jne    .LBB0_11
    # %bb.1:
        jmp    .LBB0_2
    .LBB0_2:                                # =>This Loop Header: Depth=1
                                            #     Child Loop BB0_5 Depth 2
        cmpl    $5, -4(%rbp)
        jne    .LBB0_4
    # %bb.3:
        jmp    .LBB0_10
    .LBB0_4:                                #   in Loop: Header=BB0_2 Depth=1
        jmp    .LBB0_5
    .LBB0_5:                                #   Parent Loop BB0_2 Depth=1
                                            # =>  This Inner Loop Header: Depth=2
        cmpl    $5, -4(%rbp)
        jge    .LBB0_8
    # %bb.6:                                #   in Loop: Header=BB0_5 Depth=2
        jmp    .LBB0_7
    .LBB0_7:                                #   in Loop: Header=BB0_5 Depth=2
        movl    -4(%rbp), %eax
        addl    $1, %eax
        movl    %eax, -4(%rbp)
        jmp    .LBB0_5
    .LBB0_8:                                #   in Loop: Header=BB0_2 Depth=1
        jmp    .LBB0_9
    .LBB0_9:                                #   in Loop: Header=BB0_2 Depth=1
        jmp    .LBB0_2
    .LBB0_10:
        jmp    .LBB0_11
    ```

#### ARM 下汇编结果

`clang` 的结果依然是十分清晰, 因为编译器已经注释好了很多东西, 而上面已经用 `gcc` 的结果介绍过了 `x86` 的结果, 为了有所不同, 这里就干脆用 `clang` 来说明了.

下面对 `arm-clang-64` 汇编结果进行注释以阐述:

```asm
    ldr    w8, [sp, #12]        // 读 i 到 w8
    cbnz    w8, .LBB0_11        // 若非零则跳到.LBB0_11
// %bb.1:
.LBB0_2:                        // =>This Loop Header: Depth=1
                                //     Child Loop BB0_5 Depth 2
    ldr    w8, [sp, #12]        // i
    cmp    w8, #5               // =5 // i 和 5比较
    b.ne    .LBB0_4             // 若 i != 5就跳转到.LBB0_4
// %bb.3:
    b    .LBB0_10               // 否则 break
.LBB0_4:                        //   in Loop: Header=BB0_2 Depth=1
.LBB0_5:                        //   Parent Loop BB0_2 Depth=1
                                // =>  This Inner Loop Header: Depth=2
    ldr    w8, [sp, #12]
    cmp    w8, #5               // =5, for loop 里的判断 i < 5
    b.ge    .LBB0_8             // for loop 的结束跳转
// %bb.6:                       //   in Loop: Header=BB0_5 Depth=2
// %bb.7:                       //   in Loop: Header=BB0_5 Depth=2
    ldr    w8, [sp, #12]        // 
    add    w8, w8, #1           // =1  for loop 里的 i++
    str    w8, [sp, #12]
    b    .LBB0_5                // for loop 循环结束的跳转(也是continue)
.LBB0_8:                        //   in Loop: Header=BB0_2 Depth=1
// %bb.9:                       //   in Loop: Header=BB0_2 Depth=1
    b    .LBB0_2
.LBB0_10:
```