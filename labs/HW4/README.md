# 个人笔记

## 学到的函数

- typeid()
- `static_cast<new-type>(expression)`
- `dynamic_cast<new-type>(expression)`: 
    - 必须同时是指针类型或引用类型
    - 指针转换失败返回`NULL`; 引用转换失败抛出 `std::bad_cast`
    - 可用于
        - 向上转型(upcasting)
        - 向下转型(downcasting): 有风险, 确定安全才能正常转换
        