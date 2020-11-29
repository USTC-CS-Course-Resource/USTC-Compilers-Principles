#include <iostream>
#include <memory>

using namespace std;

// 助教写的 Test 类非常经典, 因此引用之
class Test {
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