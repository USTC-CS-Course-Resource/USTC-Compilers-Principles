# HW3-Step2

## 问题1
> 1. weak_ptr可以直接通过普通指针引用对象吗？

不能. `weak_ptr`的构造方法只能是以下几种(c++14)
|说明|构造方法|
|:-|:-|
|default (1)||constexpr weak_ptr() noexcept;|
|copy (2)|weak_ptr (const weak_ptr& x) noexcept;\<br\>template \<class U\> weak_ptr (const weak_ptr\<U\>& x) noexcept;|
|from shared_ptr (3)|template \<class U\> weak_ptr (const shared_ptr\<U\>& x) noexcept;|
|move (4)|weak_ptr (weak_ptr&& x) noexcept;\<br\>template \<class U\> weak_ptr (weak_ptr\<U\>&& x) noexcept;|

因此显然不可能通过普通指针去直接构造`weak_ptr`.

## 问题2
> 2. 在程序中，如果管理weak_ptr的shared_ptr释放了，那么还可以通过weak_ptr去引用对象吗？

下面这个函数证明了**不能**.  

首先建一个 `shared_ptr`, 并由它产生对应 `weak_ptr`, 然后 `reset()` 这个 `shared_ptr`, 再尝试通过 `weak_ptr` 去引用这个对象(这里根据其使用方法, 需要先 `lock()` 以转化为 `shared_ptr`), 然后发现这个从 `weak_ptr` 构造的 `shared_ptr` 指向 `NULL`, 因此不能通过其引用了.

```c++
void fun2() {
    shared_ptr<int> sp(new int(5));  // 创建一个 shared_ptr
    weak_ptr<int> wp(sp);  // 根据这个 shared_ptr 创建 weak_ptr
    sp.reset();  // 释放了管理 weak_ptr 的 shared_ptr
    shared_ptr<int> sp_from_wp = wp.lock();  // 尝试通过 weak_ptr 引用对象, 先 lock
    assert(sp_from_wp.get() == NULL);  // 断言: 该得到的对象指针是NULL, 即证明了不能.
    cout << "shared_ptr from the weak_ptr is NULL" << endl;
}
```

## 问题3
> 3. 请大家在src/step2/test1.cpp文件中构造样例来找到上述两个问题的答案，请给你的样例加上必要的注释，并将你的答案写在src/step2/answer.md中。

如上.