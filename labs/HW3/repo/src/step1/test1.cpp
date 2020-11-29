#include <iostream>
#include <memory>
#include <cassert>

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

int main() {
    // 创建一个 auto_ptr 指向 new 出来的 Test("123") 对象
    // 这时因为对象创建, 打印了 "Test create"
    std::auto_ptr<Test> ptest1(new Test("123"));
    // 在一个环境中将其赋值给 ptest2, 以此转移 ownership
    {std::auto_ptr<Test> ptest2 = ptest1;}
    // 离开此上下文后, ptest2 指向空间被释放, 打印 "Test delete:123"
    // 断言 ptest1.get() 已经空指针
    assert(!ptest1.get());
    // 断言成功, 输出信息
    cout << "ptest1 is null" << endl;
    
}