### 相关知识

RTTI是指运行时类型信息(run-time type information)或运行时类型识别(run-time type identification)，是一种编程特性，用于让程序在运行时获取对象的实际类型。这些对象可以是简单的整型或者是复杂的class类等。在C++中，提供两种编程机制获取对象的实际类型，分别是
- `typeid`：用于获取对象的实际类型
- `dynamic_cast`：用于安全地进行类型转换

RTTI这一编程特性不只是C++特有，在[Java](http://nicolas.blancpain.free.fr/Documents/Java/online/Chapter12.html)、[Object Pascal](https://en.wikipedia.org/wiki/Object_Pascal) ([Delphi](https://en.wikipedia.org/wiki/Delphi_(programming_language)))等语言中也有类似的机制。

#### typeid运算符
[`typeid`](https://en.cppreference.com/w/cpp/language/typeid)用于查询类型信息，在头文件 [`<typeinfo>`](https://en.cppreference.com/w/cpp/header/typeinfo) 中声明。
语法形式：
```markdown
typeid ( type )	
typeid ( expression )
```
`typeid`的参数`type`是指传入变量或对象的运行时类型信息;`expression`是指传入表达式的类型信息，该表达式要先被求值。

`typeid`的返回值是给定参数的运行时类型信息，即一个对`std::type_info`对象的引用，这个对象的生命期一直到程序结束。使用`std::type_info::name()`方法可以获得类型的名称(`char*`字符串)，这个名称取决于编译器。

##### 代码示例：用`typeid`识别静态类型
下面结合代码示例来理解，该代码示例见版本库的
`Examples/typeid-s1.cpp`。你可以在右边窗口`代码文件`标签页浏览代码，在`命令行`标签页进行编译和运行，版本库位于`../data/workspace/myshixun`下；你还可以复制版本库到本地机器进行编译和运行。
```cpp
#include <iostream>
#include <typeinfo>
using namespace std;

int main()
{
    int i = 5;
    float j = 1.0;
    char c = 'a';

    // get the type info
    const type_info& ti1 = typeid(i);
    const type_info& ti2 = typeid(j);
    const type_info& ti3 = typeid(c);
    const type_info& ti4 = typeid(i*j);
    const type_info& ti5 = typeid(i*c);

    // check if both types are same
    if (ti1 == ti2)
	    cout << "i and j are of"
		 << "similar type" << endl;
    else
	    cout << "i and j are of"
		 << "different type" << endl;
    
    if (ti1 == ti3)
	    cout << "i and c are of"
		 << "similar type" << endl;
    else
	    cout << "i and c are of"
		 << "different type" << endl;

    // print the types
    cout << "ti1 is of type " << ti1.name() << endl;
    cout << "ti2 is of type " << ti2.name() << endl;
    cout << "ti3 is of type " << ti3.name() << endl;
    cout << "ti4 is of type " << ti4.name() << endl;
    cout << "ti5 is of type " << ti5.name() << endl;
    return 0;
}
```
上述代码获取参数为变量或表达式的类型信息，检查类型是否相等，并输出类型信息的名字。你在命令行下用`g++ typeid-s1.cpp`编译，可得到可执行文件`a.out`，再运行之，得到如下的输出：
```
i and j are of different type
i and c are of different type
ti1 is of type i
ti2 is of type f
ti3 is of type c
ti4 is of type f
ti5 is of type i
```
##### 代码示例：用`typeid`识别多态类型
下面结合代码示例来理解，该代码示例见版本库的
`Examples/typeid-s2.cpp`。
```cpp
#include <iostream>
#include <typeinfo>
using namespace std;

class B {
public:
    virtual void fun() {cout << "base fun" << endl; }  
};

class D: public B {
public:
    void fun() { cout << "derived fun" << endl; }
};

void printTypeinfo(const char *n, const B* pb)
{
    cout << "typeid(*" << n << "pb) is " << typeid(*pb).name() << endl;
}

int main()
{
    B b;
    D d;
    B *ptr = new D;
    ptr->fun();
    printTypeinfo("&b", &b);
    printTypeinfo("&d", &d);
    printTypeinfo("ptr", ptr);

    return 0;
}
```
上述代码定义了基类`B`及派生类`D`，`B`中定义有虚函数`fun`；`main`函数中分别创建了运行时类型和声明类型一致的对象`b, d`以及运行时类型与声明类型不一致的对象引用`ptr`，然后调用虚函数，再输出类型信息的名字。你在命令行下用`g++ typeid-s2.cpp`编译，可得到可执行文件`a.out`，再运行之，得到如下的输出：
```
derived fun
typeid(*&b) is 1B
typeid(*&d) is 1D
typeid(*ptr) is 1D
```
#### `static_cast`强制类型转换
语法形式：`static_cast < new-type > ( expression )`

`static_cast` 只能用于良性转换，例如：
- 原有的自动类型转换，例如 `short` 转 `int`、`int` 转 `double`向上转型等；
- `void` 指针和具体类型指针之间的转换，例如`void *`转`int *`、`char *`转`void *`等；
- 有转换构造函数或者类型转换函数的类与其它类型之间的转换，例如 `double` 转 `Complex`（调用转换构造函数）、`Complex` 转 `double`（调用类型转换函数）

需要注意的是，`static_cast` 不能用于无关类型之间的转换，因为这些转换都是有风险的，两个具体类型指针之间的转换，例如
- `int *`转`double *`、`Inst *`转`int *`等。不同类型的数据存储格式不一样，长度也不一样，用 `A` 类型的指针指向 `B` 类型的数据后，会按照 `A` 类型的方式来处理数据：如果是读取操作，可能会得到一堆没有意义的值；如果是写入操作，可能会使 `B` 类型的数据遭到破坏，当再次以 `B` 类型的方式读取数据时会得到一堆没有意义的值。
- `int` 和指针之间的转换。将一个具体的地址赋值给指针变量是非常危险的，因为该地址上的内存可能没有分配，也可能没有读写权限。

`static_cast` 也不能用来去掉表达式的 `const` 修饰和 `volatile` 修饰。换句话说，不能将 `const/volatile` 类型转换为非 `const/volatile` 类型。

`static_cast` 是“静态转换”的意思，也就是在编译期间转换，转换失败的话会抛出一个编译错误。

这里，简要给出使用`static_cast` 的代码片段，你可以自行编写完整的程序学习使用并进行编译和运行。
```cpp
int m = 100;
long n = static_cast<long>(m);  //宽转换，没有信息丢失
char ch = static_cast<char>(m);  //窄转换，可能会丢失信息
int *p1 = static_cast<int*>( malloc(10 * sizeof(int)) );  //将void指针转换为具体类型指针
void *p2 = static_cast<void*>(p1);  //将具体类型指针，转换为void指针

//下面的用法是错误的
float *p3 = static_cast<float*>(p1);  //不能在两个具体类型的指针之间进行转换
p3 = static_cast<float*>(100);  //不能将整数转换为指针类型
```


#### `dynamic_cast`强制类型转换
和[`static_cast`](https://en.cppreference.com/w/cpp/language/static_cast)一样，`dynamic_cast`用于类型的转换。不同的是，[`dynamic_cast`](https://en.cppreference.com/w/cpp/language/dynamic_cast)是“动态转换”，在程序运行时会借助RTTI进行类型转换，并且要求基类必须包含虚函数，这样派生类可以重写虚函数。

语法形式：`dynamic_cast < new-type > ( expression )`
`new-type` 和 `expression` 必须同时是指针类型或者引用类型，也即`dynamic_cast`只能转换指针类型和引用类型。

对于指针，如果转换失败将返回 `NULL`；对于引用，如果转换失败将抛出`std::bad_cast`异常。

##### 向上转型(Upcasting)
向上转型时，只要待转换的两个类型之间存在继承关系，并且基类包含了虚函数（这些信息在编译期间就能确定），就一定能转换成功。因为向上转型始终是安全的，所以 dynamic_cast 不会进行任何运行期间的检查，这个时候的 dynamic_cast 和 static_cast 就没有什么区别了。向上转型的例子示意如下：
```cpp
Derived *pd = new Derived();
Base *pb = dynamic_cast<Base*>(pd);
```
其中派生类指针`pd`被向上转型为基类指针并赋值给`pb`。

##### 向下转型(Downcasting)
向下转型是有风险的，`dynamic_cast` 会借助 RTTI 信息进行检测，确定安全的才能转换成功，否则就转换失败。安全的向下转型是指，声明为基类的指针实际指向的是派生类对象，这时就可以将该指针向下转型为派生类指针，例如：
```cpp
Base *pb = new Derived();
Derived *pd = dynamic_cast<Derived*>(pb);
```
其中基类指针`pb`被向下转型为派生类指针并赋值给`pd`，这种转型安全的原因是`pb`实际指向的是派生类对象。

##### 代码示例
在版本库中提供了示例代码`Examples/dynamic_cast-s.cpp`展示了动态转型。代码如下：
```cpp
#include <iostream>
#include <typeinfo>
using namespace std;

class B {
public:
    virtual void fun() {cout << "base fun" << endl; }  
};

class D: public B {
public:
    void fun() { cout << "derived fun" << endl; }
};

void printTypeinfo(const char *n, const B* pb)
{
    cout << "typeid(*" << n << "pb) is " << typeid(*pb).name() << endl;
}

int main()
{
    B b;
    D d;
    D *ptr = new D;
    B *p = new D;
    b.fun();
    d.fun();
    ptr->fun();
    p->fun();

    B* ptrb = dynamic_cast<B*>(ptr);  // upcasting
    cout << "ptr is " << ptr << endl;
    cout << "ptrb is " << ptrb << endl;
    D* pd = dynamic_cast<D*>(p);      // downcasting
    cout << "p is " << p << endl;
    cout << "pd is " << pd << endl;
    B* pb = dynamic_cast<B*>(p);
    cout << "pb is " << pb << endl;

    return 0;
}
```
编译并运行，将得到如下的输出结果：
```C++
base fun
derived fun
derived fun
derived fun
ptr is 0x632e70
ptrb is 0x632e70
p is 0x632e90
pd is 0x632e90
pb is 0x632e90
```

----

### 相关知识

#### RTTI机制

RTTI(run-time type information or run-time type identification)是一种编程特性，用于在运行时获取对象的类型信息。这些对象可以是简单的整型或者是复杂的class类等。在C++中，提供了两种编程机制获取对象的运行时类型信息，分别是
- `dynamic_cast`：用于安全地进行类型转换
- `typeid`：用于获取对象的类型信息

RTTI这一编程特性不只是C++特有，在[Java](http://nicolas.blancpain.free.fr/Documents/Java/online/Chapter12.html)、[Object Pascal](https://en.wikipedia.org/wiki/Object_Pascal) ([Delphi](https://en.wikipedia.org/wiki/Delphi_(programming_language)))中也有类似的机制。

#### typeid 运算符

[`typeid`](https://en.cppreference.com/w/cpp/language/typeid)用于在运行时获取对象的实际类型信息。`typeid`的返回值是一个对`std::type_info`对象的引用，这个对象的生命期一直到程序结束。使用`std::type_info::name()`方法可以获得类型的名称(`char*`字符串)，这个名称取决于编译器。

#### dynamic_cast 强制转型

`dynamic_cast < new-type > ( expression )`

和[`static_cast`](https://en.cppreference.com/w/cpp/language/static_cast)一样，`dynamic_cast`用于类型的转换。不同的是，[`dynamic_cast`](https://en.cppreference.com/w/cpp/language/dynamic_cast)在运行时会进行类型检查，同时，`dynamic_cast`只能作用于引用和指针。

---
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
