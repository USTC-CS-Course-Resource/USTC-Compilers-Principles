# HW3-step1

## 问题

> 你认为unique_ptr可以作为实参传递给函数吗，为什么？请将你的思考放在src/step1/文件夹下，并且命名为answer.md。

> Hint: 从值传递和[引用传递](https://en.wikipedia.org/wiki/Evaluation_strategy#Call_by_reference)两方面考虑。

## 回答

`c++ 11`明确禁止了 `copy assignment`(但不排除可以使用 `move` 进行"值传递"), 因此不能作为实参传递给函数.

但引用传递是可以的.

下面进行详细说明.

### 对 `=` 的重载

#### 重载后格式

`unique_ptr` [重载](http://www.cplusplus.com/reference/memory/unique_ptr/operator=/)了 `=` 运算符, 重载结果如下:

|说明|格式|
|:-|:-|
|move assignment (1)|unique_ptr& operator= (unique_ptr&& x) noexcept;|
|assign null pointer (2)|unique_ptr& operator= (nullptr_t) noexcept;|
|type-cast assignment (3)|template <class U, class E><br>unique_ptr& operator= (unique_ptr<U,E>&& x) noexcept;|
|copy assignment (**deleted!**) (4)|unique_ptr& operator= (const unique_ptr&) = delete;|

因此传参数时, 只能是引用传递, 并且可以看到, `copy assignment` 是被禁止的.

#### 重载后行为

此外, 根据文档, 
- 如果传入的是空指针, 那么赋值就等价于
    ```c++
    reset()
    ```
- 否则, 赋值行为等价于:
    ```c++
    reset(u.release());
    get_deleter() = forward<deleter_type>(u.get_deleter());
    ```

### 值传递

综上所述, 值传递是不被允许的.

但实际上, 可以通过move进行传递, 但这时, 所有权将会移交到 `callee` 的参数. 这样, 函数调用结束后, 这个对象也就被删除, 从 `caller` 也就不再能访问到这个对象了(`caller` 中的智能指针在 `move` 之后就指向NULL了);

### 引用传递

而若是引用传递, 当传入非空 `unique_ptr` 时, 参数就得以引用到该指针, 从而进行操作. 函数调用结束后, `caller` 仍然拥有对该对象的所有权

### 代码验证

这里用了一小块代码验证了用 `move` 进行值传递的行为, 和直接用引用传递的行为.  
由于这并不是作业要求, 只是我出于好奇的验证, 因此就不作过多解释了.

```c++
#include <iostream>
#include <memory>

using namespace std;

// 助教写的 Test 类非常经典, 因此引用之
class Test
{
public:
    Test(string s) {
        str = s;
        cout << "Test creat\n";
    }
    ~Test() {
        cout << "Test delete:" << str << endl;
    }
    string& getStr() {
        return str;
    }
    void setStr(string s) {
        str = s;
    }
    void print() {
        cout << str << endl;
    }
private:
    string str;
};

void func1(unique_ptr<Test> uptr) {
    cout << "address of unique_ptr in callee:  " << uptr.get() << endl;
    uptr->setStr("after called");
}

void func2(unique_ptr<Test> &uptr) {
    cout << "address of unique_ptr in callee:  " << uptr.get() << endl;
    uptr->setStr("after called");
}


int main() {
    cout << "-------------------------test1-------------------------" << endl;
    unique_ptr<Test> uptr1(new Test("before called"));
    cout << "address in caller before calling: " << uptr1.get() << endl;
    func1(move(uptr1));
    cout << "address in caller after calling:  " << uptr1.get() << endl;

    cout << "-------------------------test2-------------------------" << endl;
    unique_ptr<Test> uptr2(new Test("before called"));
    cout << "address in caller before calling: " << uptr2.get() << endl;
    func2(uptr2);
    cout << "address in caller after calling:  " << uptr2.get() << endl;

}
```

其输出是
```text
-------------------------test1-------------------------
Test creat
address in caller before calling: 0x55fda74162c0
address of unique_ptr in callee:  0x55fda74162c0
Test delete:after called
address in caller after calling:  0
-------------------------test2-------------------------
Test creat
address in caller before calling: 0x55fda74162c0
address of unique_ptr in callee:  0x55fda74162c0
address in caller after calling:  0x55fda74162c0
Test delete:after called
```