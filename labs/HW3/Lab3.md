
#### 基本知识
- `std::auto_ptr`指针最早在C++98标准中被引入，但它在 C++11（[ISO 14882:2011](https://www.iso.org/standard/50372.html)）中被设为不推荐使用(deprecated、弃用)，在C++17（[ISO/IEC 14882:2017](https://www.iso.org/standard/68564.html)）中被完全删除。
- `std::unique_ptr`指针在 C++11（[ISO 14882:2011](https://www.iso.org/standard/50372.html)）中被引入，用来取代`std::auto_ptr`。
- `std::auto_ptr`和`std::unique_ptr`都用于管理具有唯一所有权(ownership)的对象，但是对象所有权的转移有不同的语义，前者基于复制，后者基于移动move。

参考资料：
- [15.1 — Intro to smart pointers and move semantics](https://www.learncpp.com/cpp-tutorial/15-1-intro-to-smart-pointers-move-semantics/)
- [15.5 — std::unique_ptr](https://www.learncpp.com/cpp-tutorial/15-5-stdunique_ptr/)
- ...

##### std::auto_ptr指针
在头文件[`<memory>`](https://en.cppreference.com/w/cpp/memory/auto_ptr)中定义：
`template <class X> class auto_ptr;`

###### 基本概念

该模板类对象提供对指针的受限垃圾收集能力，允许在`auto_ptr`对象被销毁时，指针指向的元素被自动销毁。`auto_ptr`对象具有对分配给它们的指针拥有**所有权**的特性：对一个元素拥有所有权的`auto_ptr`对象负责销毁它指向的元素，并在销毁它时销毁分配给它的内存。析构函数通过调用算子`delete`来自动执行此操作。

因此，**不会有两个`auto_ptr`对象拥有相同的元素**。当在两个`auto_ptr`对象之间发生复制操作时，所有权被转移，也即失去所有权的`auto_ptr`对象不再指向该元素，即被设置为空指针。

<a name="Risk">`std::auto_ptr`**存在的风险**： </a>
- `std::auto_ptr` 通过**复制**构造函数和赋值运算符实现移动语义，因此将`std::auto_ptr`按值传递给函数将导致您的资源转移至函数参数（并在函数末尾(超出函数参数的作用域)被销毁）。这之后，当需要从调用方访问`std::auto_ptr` 参数时（没有意识到它已被转移和删除），这时已是空引用指针！
- `std::auto_ptr`始终使用非数组的`delete`来删除其指向的元素。这意味着`auto_ptr`无法正确使用动态分配的数组，因为它使用了错误的释放类型。更糟的是，它不会阻止你将其传递给动态数组，否则动态数组将导致管理不善，从而导致内存泄漏。
- `auto_ptr`在标准库的许多其他类（包括大多数容器和算法）上不能很好地发挥作用。这是因为那些标准库类往往假定它们在复制元素项时实际上是在复制而不是移动。

###### 代码示例
请阅读并运行如下[示例代码](https://git.lug.ustc.edu.cn/compiler/course/-/blob/master/SmartPtr/auto_ptr.cpp)，并运行程序，理解程序结果。
示例代码见本实训项目版本库的`Examples/auto_ptr.cpp`。你可以在在线实训界面右边窗口的`代码文件`标签页中选择`Examples/auto_ptr.cpp`进行浏览，并在`命令行`标签页中进行编译和运行等。

```cpp
#include<iostream>
#include<memory>	//auto_ptr的头文件
#include<cassert>
using namespace std;
class Test
{
public:
    Test(string s)
    {
        str = s;
       cout<<"Test creat\n";
    }
    ~Test()
    {
        cout<<"Test delete:"<<str<<endl;
    }
    string& getStr()
    {
        return str;
    }
    void setStr(string s)
    {
        str = s;
    }
    void print()
    {
        cout<<str<<endl;
    }
private:
    string str;
};
  
void func(auto_ptr<Test> ptest){
    return;
}
  
int main()
{
    auto_ptr<Test> ptest(new Test("123"));	//调用构造函数输出Test creat
    ptest->setStr("hello ");				//修改成员变量的值
    ptest->print();							//输出hello
    ptest.get()->print();					//输出hello
    ptest->getStr() += "world !";
    (*ptest).print();						//输出hello world
    ptest.reset(new Test("123"));//成员函数reset()重新绑定指向的对象，而原来的对象则会被释放，所以这里会调用一次构造函数，还有调用一次析构函数释放掉之前的对象
    ptest->print();							//输出123
    func(ptest);
    ptest->print();
    assert(ptest.get()  && "it is NULL now");
    return 0;								//此时还剩下一个对象，调用一次析构函数释放该对象
}
```
智能指针可以像类的原始指针一样访问类的public成员，成员函数`get()`返回一个原始的指针，成员函数`reset()`重新绑定指向的对象，而原来的对象则会被释放。访问`auto_ptr`的成员函数时用的是`“.”`，访问指向对象的成员时用的是`“->”`。

##### std::unique_ptr指针
在头文件[`<memory>`](https://en.cppreference.com/w/cpp/memory/unique_ptr)中定义：
`template <class X> class unique_ptr;`

###### 基本概念

`std::unique_ptr`是用于取代`std::auto_ptr`的产物,在C++11中引入。在C++11之前，C++语言没有区分**复制语义**和**移动语义**的机制，重载复制语义来实现移动语义会导致怪异的情况和无意的错误。例如，对于`r1 = r2`，无法判断 `r2` 是否会被改变。

在C++11中正式定义**移动**(move)的概念，并增加**移动语义**([move semantics](https://en.cppreference.com/w/cpp/utility/move))，从而将复制和移动区别开来。
在C++11中，`std::auto_ptr`已经被一系列移动感知的(move-aware)智能指针取代：`std::unique_ptr`、`std::weak_ptr`、`std::shared_ptr`。

`std::unique_ptr`正确地实现了移动语义。如果希望转移`std::unique_ptr`对象`r2`管理的内容，则需要通过`r1 = std::move(r2)`，将`r2`转换成右值，这将触发移动赋值而不是复制赋值。

`std::unique_ptr`具有重载的`operator *`和`operator ->`，可用于返回被管理的资源。 `Operator *`返回对托管资源的引用，`operator ->`返回指针。在使用这些运算符之前，应检查`std::unique_ptr`对象`r`是否确实有管理的资源，这可以简单地通过判断 `r` 是否为真来做到，因为`std::unique_ptr`在条件判断中能隐式强制转换为布尔值。

###### 代码示例
请阅读[示例代码](https://git.lug.ustc.edu.cn/compiler/course/-/blob/master/SmartPtr/unique_ptr.cpp)并运行程序，理解程序结果。
示例代码见本实训项目版本库的`Examples/unique_ptr.cpp`。你可以在在线实训界面右边窗口的`代码文件`标签页中选择`Examples/unique_ptr.cpp`进行浏览，并在`命令行`标签页中进行编译和运行等。

```cpp
#include<iostream>
#include<memory>
using namespace std;
class Test
{
public:
    Test(string s)
    {
        str = s;
       cout<<"Test creat\n";
    }
    ~Test()
    {
        cout<<"Test delete:"<<str<<endl;
    }
    string& getStr()
    {
        return str;
    }
    void setStr(string s)
    {
        str = s;
    }
    void print()
    {
        cout<<str<<endl;
    }
private:
    string str;
};
unique_ptr<Test> fun()
{
    return unique_ptr<Test>(new Test("789"));//调用了构造函数，输出Test creat
}

void func(unique_ptr<Test> & ptest){
    return;
} 

int main()
{
    unique_ptr<Test> ptest(new Test("123"));	//调用构造函数，输出Test creat
    func(ptest);
    unique_ptr<Test> ptest2(new Test("456"));	//调用构造函数，输出Test creat
    ptest->print();								//输出123
    ptest2 = std::move(ptest);	//不能直接ptest2 = ptest，调用了move后ptest2原本的对象会被释放，ptest2对象指向原本ptest对象的内存，输出Test delete 456
    if(ptest == NULL)cout<<"ptest = NULL\n";	//因为两个unique_ptr不能指向同一内存地址，所以经过前面move后ptest会被赋值NULL，输出ptest=NULL
    Test* p = ptest2.release();	//release成员函数把ptest2指针赋为空，但是并没有释放指针指向的内存，所以此时p指针指向原本ptest2指向的内存
    p->print();					//输出123
    ptest.reset(p);				//重新绑定对象，原来的对象会被释放掉，但是ptest对象本来就释放过了，所以这里就不会再调用析构函数了
    ptest->print();				//输出123
    ptest2 = fun(); 			//这里可以用=，因为使用了移动构造函数，函数返回一个unique_ptr会自动调用移动构造函数
    ptest2->print();			//输出789
    return 0;					//此时程序中还有两个对象，调用两次析构函数释放对象
}
```

---

### 基本知识
- `std::shared_ptr`和`std::weak_ptr`指针在C++11（[ISO 14882:2011](https://www.iso.org/standard/50372.html)）中被引入，用来通过指针共享一个对象。
- `std::shared_ptr`是一个基于引用计数管理所共享的对象的智能指针。
- `std::weak_ptr`用来配合`std::shared_ptr`使用，它指向`std::shared_ptr`管理的对象而不改变该对象的引用计算。

参考资料：
- [15.6 — std::shared_ptr](https://www.learncpp.com/cpp-tutorial/15-6-stdshared_ptr/)
- [15.7 — Circular dependency issues with std::shared_ptr, and std::weak_ptr](https://www.learncpp.com/cpp-tutorial/15-7-circular-dependency-issues-with-stdshared_ptr-and-stdweak_ptr/)
- ...


#### std::shared_ptr指针
在头文件[`<memory>`](https://en.cppreference.com/w/cpp/memory/shared_ptr)中定义：
`template< class T > class shared_ptr;`

##### 基本概念
多个`std::shared_ptr`可以管理同一对象，即共享对象的所有权，并且采用引用计数管理所共享的对象。每个`shared_ptr`对象关联有一个共享的引用计数。
- 当拷贝一个 `shared_ptr` ，将其引用计数值加 1；
- `shared_ptr`提供`unique()`和`use_count()`两个函数来检查其共享的引用计数值，前者测试该`shared_ptr`是否是唯一拥有者（即引用计数值为1），后者返回引用计数值；
- 当`shared_ptr`共享的引用计数降低到 0 的时候，所管理的对象自动被析构（调用其析构函数释放对象）。

**`std::make_shared`** 可以用`std::make_shared`创建`std::shared_ptr`。 [`std::make_shared`](https://en.cppreference.com/w/cpp/memory/shared_ptr/make_shared)在C++11中可用。

**可以从唯一指针创建共享指针** 一个`std::unique_ptr`可以通过接受该`std::unique_ptr`右值的`std::shared_ptr`构造函数转化为`std::shared_ptr`，则该`std::unique_ptr`的内容将移动到`std::shared_ptr`。但是，`std::shared_ptr`不能安全地转化为`std::unique_ptr`。

**`std::shared_ptr`的风险** 如果管理资源的任何`std :: shared_ptr`未被正确销毁，则资源将无法正确释放。

**`std::shared_ptr`与数组** 在C++14及更早的版本中，`std::shared_ptr`并没有管理数组的支持；在C++17中，`std::shared_ptr`提供对数组的支持，但是`std::make_shared`仍缺乏对数组的支持，不能用于创建共享数组，这个问题将在C++20中解决。

##### 代码示例
请阅读[示例代码](https://git.lug.ustc.edu.cn/compiler/course/-/blob/master/SmartPtr/shared_ptr.cpp)并运行程序，理解程序结果。
示例代码见本实训项目版本库的`Examples/shared_ptr.cpp`。你可以在在线实训界面右边窗口的`代码文件`标签页中选择`Examples/shared_ptr.cpp`进行浏览，并在`命令行`标签页中进行编译和运行等。
```c++
#include<iostream>
#include<memory>
using namespace std;
class Test
{
public:
    Test(string s)
    {
        str = s;
       cout<<"Test creat\n";
    }
    ~Test()
    {
        cout<<"Test delete:"<<str<<endl;
    }
    string& getStr()
    {
        return str;
    }
    void setStr(string s)
    {
        str = s;
    }
    void print()
    {
        cout<<str<<endl;
    }
private:
    string str;
};
unique_ptr<Test> fun()
{
    return unique_ptr<Test>(new Test("789"));
}
int main()
{
    shared_ptr<Test> ptest(new Test("123"));	//调用构造函数输出Test create
    shared_ptr<Test> ptest2(new Test("456"));	//调用构造函数输出 Test creat
    cout<<ptest2->getStr()<<endl;				//输出456
    cout<<ptest2.use_count()<<endl;				//显示此时资源被几个指针共享，输出1
    ptest = ptest2;		//"456"引用次数加1，“123”销毁，输出Test delete：123
    ptest->print();		//输出456
    cout<<ptest2.use_count()<<endl;				//该指针指向的资源被几个指针共享，输出2
    cout<<ptest.use_count()<<endl;				//2
    ptest.reset();	//重新绑定对象，绑定一个空对象，当时此时指针指向的对象还有其他指针能指向就不会释放该对象的内存空间，
    ptest2.reset();	//此时“456”销毁，此时指针指向的内存空间上的指针为0，就释放了该内存，输出Test delete
    cout<<"done !\n";
    return 0;
}
```

#### std::weak_ptr指针
在头文件[`<memory>`](https://en.cppreference.com/w/cpp/memory/weak_ptr)中定义：
`template< class T > class weak_ptr;`

##### 基本概念
`std::weak_ptr`是用来解决`std::shared_ptr`循环引用时的死锁问题。如果说两个`std::shared_ptr`相互引用形成环,那么这两个指针的引用计数永远不可能下降为0,资源永远不会释放。`std::weak_ptr`是对共享对象的一种弱引用，不会增加对象的引用计数值；`std::weak_ptr`和`std::shared_ptr`之间可以相互转化，`std::shared_ptr`可以直接赋值给`std::weak_ptr`，它可以通过调用`lock`函数来获得`std::shared_ptr`。

##### 代码示例
请阅读[示例代码](https://git.lug.ustc.edu.cn/compiler/course/-/blob/master/SmartPtr/weak_ptr.cpp)并运行程序。
示例代码见本实训项目版本库的`Examples/weak_ptr.cpp`。你可以在在线实训界面右边窗口的`代码文件`标签页中选择`Examples/weak_ptr.cpp`进行浏览，并在`命令行`标签页中进行编译和运行等。

```c++
#include<iostream>
#include<memory>
using namespace std;

template <typename T>
class B;

class A
{
public:
    shared_ptr<B<A>> pb_;
    ~A()
    {
        cout<<"A delete\n";
    }
};

class A1
{
public:
    weak_ptr<B<A1>> pb_;
    ~A1()
    {
        cout<<"A1 delete\n";
    }
};

template <typename T>
class B
{
public:
    shared_ptr<T> pa_;
    ~B()
    {
        cout<<"B delete\n";
    }
};
  
void fun()
{
    shared_ptr<B<A>> pb(new B<A>());
    shared_ptr<A> pa(new A());
    pb->pa_ = pa;
    pa->pb_ = pb;
    cout<<"fun : "<<pb.use_count()<<endl;
    cout<<"fun : "<<pa.use_count()<<endl;
    // 这个函数执行完会出现相互引用导致的内存泄漏
}

void fun1()
{
    shared_ptr<B<A1>> pb(new B<A1>());
    shared_ptr<A1> pa(new A1());
    pb->pa_ = pa;
    pa->pb_ = pb;
    cout<<"fun1 : "<<pb.use_count()<<endl;
    cout<<"fun1 : "<<pa.use_count()<<endl;
}

int main()
{
    fun();
    fun1();
    return 0;
}

```

可以看到`fun`函数中 `pa` 、`pb` 之间互相引用，两个资源的引用计数为2，当要跳出函数时，智能指针`pa`、`pb`析构时两个资源引用计数会减一，得到计数值1，导致跳出函数时资源没有被释放（`A`、`B`的析构函数没有被调用）。
如果把其中一个改为`weak_ptr`就可以了，例如，我们把类`A`里面的`shared_ptr< B> pb_;` 改为`weak_ptr< B> pb_; `。运行结果为：资源`B`的引用开始时只有1，当`pb`析构时，`B`的计数变为0，`B`得到释放，`B`释放的同时也会使`A`的计数减一，同时`pa`析构时使A的计数减一，那么`A`的计数为0，`A`得到释放。

我们不能通过`weak_ptr`直接访问对象的方法，比如`B`对象中有一个方法`print()`,我们不能这样访问，`pa->pb_->print()`; `pb_`是一个`weak_ptr`，应该先把它转化为`shared_ptr`,如：
```
shared_ptr<B> p= pa->pb_.lock();
p->print();
```
