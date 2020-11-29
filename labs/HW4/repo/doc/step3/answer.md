# HW4-Step3

## dynamic_cast
> 阅读并运行程序src/step3/dynamic_cast.cpp。回答以下问题：
> 
> BasicBlock::print函数在62-73行的运行逻辑是怎么样的？这里 RTTI 机制是怎样起作用的？
> 如果没有 RTTI 机制（部分库会在编译时加上fno-rtti选项，因为 RTTI会带来一定的开销），这时应该如何实现BasicBlock::print函数，保持功能的一致性，在src/step3/static_cast.cpp里进行实现（注意：可以增加类成员和API）。
> 考虑实际场景里的使用，如果Instruction有很多个子类（不同的指令），那么你修改后的程序需要修改什么地方？

1. 
    - BasicBlock::print函数在62-73行的运行逻辑:
        1. `for` 循环遍历 `values` 中所有元素. 
        2. 依次识别其类型(用 `dynamic_cast`, 若成功则会返回正确的指针, 否则返回 `NULL`, 因此可以用 `if-else` 判断)
        3. 如果不是 `UnaryInst` 也不是 `BinaryInst`, 就报错.
    - 这里 `RTTI` 机制的作用是识别了元素的类型, 正确判断了基类指针指向的对象是哪个派生类.
2. 如果没有 `RTTI` 机制, 实现方法见 `src/step3/static_cast.cpp`. 只需要将用 `rtti` 识别类型的语句改成直接用一个用来指示类型的成员变量 `type` 判断类型即可.
3. 实际应用场景中, 如果有很多个子类, 那么程序需要
    - 为每个子类都指定一下这个`表示类型的类成员 type`的值
    - 修改所有判断rtti的地方, 改成用`表示类型的类成员 type`来判断

## typeid
> 阅读并运行程序src/step3/typeid.cpp。回答以下问题：
> 
> 分别使用g++和clang++运行并得到程序输出，并解释输出。
> 当去掉Instruction类的父类Value（删除: public Value）时，程序的输出是什么？对输出进行解释（编译器自选）。

1. 用 `g++` 和 `clang++` 运行, 解释输出结果:
    - `g++`的输出结果是
        ```
        P5Value
        10BasicBlock
        P11Instruction
        10BinaryInst
        ```
    - `clang++`的输出结果是
        ```
        P5Value
        10BasicBlock
        P11Instruction
        10BinaryInst
        ```
    发现结果是一样的. 解释其中一个即可, 以 `g++` 为例. 其中开头带 `P` 与否表示是否为指针, 其后的数字表示类名长度(如果是 `int` 之类的就没有类名长度, 而是用一个特定的字符串表示).
    - `P5Value`: 这是来自 `v` 的类型, `v` 是 `Value*` 类型的, 自然输出 `P5Value`
    其中 `P` 表示是指针类型, `5` 表示名字长度, `Value` 表示是 `Value` 类的.
    - `10BasicBlock`: 这里 `v` 实际指向对象, 也就是`*v`, 是 `BasicBlock` 类的, 因此判断结果就是 `BasicBlock` 类型
    其中`10` 是名长, `BasicBlock` 是类名
    - `P11Instruction`: `inst` 是 `Instruction*` 类的, 因此判断结果就是 `Instruction类指针`
    其中 `P` 表示指针, `11` 是名长, `Instruction` 是类名
    - `10BinaryInst`: 这里 `inst` 实际指向对象, 也就是`*inst`, 是 `BinaryInst` 类的, 因此判断结果就是 `BinaryInst` 类型
    其中 `10` 是名长, `BinaryInst` 是类名
2. 用 `g++` 说明. 去掉后输出是
    ```
    P5Value
    10BasicBlock
    P11Instruction
    11Instruction
    ```
    区别就在于第四行的输出从 `10BinaryInst` 变成了 `11Instruction`. 其原因就是
    - 此时 `UnaryInst` 和 `BinaryInst` 不再是多态关系了(没有对虚函数的重写了), 这时, `typeid` 就仅仅是编译期行为, 它是个什么类型的指针指向的东西, 它就被解释为什么样的类型, 也就返回了这样的类型.
    - 而如果涉及多态关系, `typeid` 就是 runtime行为, 通过查询虚表判断类型(所以得到了实际类型).
    > When applied to an expression of polymorphic type, evaluation of a typeid expression may involve runtime overhead (a virtual table lookup), otherwise typeid expression is resolved at compile time. 
