#include <iostream>
#include <memory>
#include <cassert>
#include <sstream>

using namespace std;

// 助教写的 Test 类非常经典, 因此引用之
static int counter = 0;
class Test
{
public:
    Test() {
        stringstream ss;
        ss << string("default") << counter++;
        ss >> str;
        cout << "Test " + str + " creat\n";
    }
    Test(string s) {
        str = s;
        cout << "Test creat\n";
    }
    ~Test() {
        cout << "Test delete:" << str << endl;
        cout <<"1";
        cout <<"2";
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


void fun1() {
    Test * p = new Test("123");
    // weak_ptr<Test> wp(p);  // 这句编译是不会通过的.
}

void fun2() {
    shared_ptr<int> sp(new int(5));  // 创建一个 shared_ptr
    weak_ptr<int> wp(sp);  // 根据这个 shared_ptr 创建 weak_ptr
    sp.reset();  // 释放了管理 weak_ptr 的 shared_ptr
    shared_ptr<int> sp_from_wp = wp.lock();  // 尝试通过 weak_ptr 引用对象, 先 lock
    assert(sp_from_wp.get() == NULL);  // 断言: 该得到的对象指针是NULL, 即证明了不能.
    cout << "[fun2] shared_ptr from the weak_ptr is NULL" << endl;
}

int main() {
    fun1();
    fun2();
}