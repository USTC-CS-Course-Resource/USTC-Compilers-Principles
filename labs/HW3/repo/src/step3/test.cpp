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

int main() {
    auto x = new Test("44");
    std::unique_ptr<Test> uptr(x);
    std::shared_ptr<Test> sptr(x);
    uptr->print();
    cout << uptr.get() << endl;
    cout << sptr.get() << endl;
    cout << (uptr.get() == NULL) << endl;
    cout << sptr.use_count() << endl;
}