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

class X {};
class Y: public X {};

const char format[] = "\033[1m%-40s\033[0m: \033[4m%-4s\033[0m\n";
const char format_with_d[] = "\033[1m%-40s\033[0m: \033[4m%-4s\033[0m\t[%d]\n";
const char format_with_ld[] = "\033[1m%-40s\033[0m: \033[4m%-4s\033[0m\t[%ld]\n";
const char format_with_e[] = "\033[1m%-40s\033[0m: \033[4m%-4s\033[0m\t[%e]\n";

int main() {
    printf("**本程序展示 dynamic_cast 类型转换的一些结果**\n");
    printf("---------------涉及多态的类间转换---------------\n");
    // 涉及多态的类间转换
    B* pb = new B();
    B* pb_to_b = new D();
    D* pd = new D();
    B& B_ref_b = *pb;
    B& B_ref_d = *pd;
    D& D_ref_d = *pd;

    // 初始信息
    printf("---------------初始信息---------------\n");
    printf("typeid(*pb)): %s\n", typeid(*pb).name());
    printf("typeid(*pb_to_b)): %s\n", typeid(*pb_to_b).name());
    printf("typeid(*pd)): %s\n", typeid(*pd).name());
    printf("typeid(B_ref_b)): %s\n", typeid(B_ref_b).name());
    printf("typeid(B_ref_d)): %s\n", typeid(B_ref_d).name());
    printf("typeid(D_ref_d)): %s\n", typeid(D_ref_d).name());
    printf("\n");

    // 1. dynamic(<D> -> <B>) 这意味着有多态时, 引用类型转换结果最终还是取决于实际
    printf(format,
        "1. dynamic(<D&> -> <B&>)",
        typeid(dynamic_cast<B&>(D_ref_d)).name());
    printf("\t"); dynamic_cast<B&>(D_ref_d).fun();
    // 2. dynamic(<B> -> <D>) B实际引用B 转换失败
    try {
        printf(format,
            "2. dynamic(<B&> -> <D&>)",
            typeid(dynamic_cast<D&>(B_ref_b)).name());
        dynamic_cast<D&>(B_ref_b).fun();
    } catch(std::bad_cast bc) {
        printf("\033[1m2. dynamic(<B&> -> <D&>) B ref B\n\tstd::bad_cast\033[0m\n");
    }
    // 3. dynamic(<B&> -> <D&>) B实际引用D
    printf(format,
        "3. dynamic(<B&> -> <D&>) B ref D",
        typeid(dynamic_cast<D&>(B_ref_d)).name());
    printf("\t"); dynamic_cast<D&>(B_ref_d).fun();
    // 4. dynamic(<D*> -> <B*>) 成功将派生类转换为基类
    printf(format,
        "4. dynamic(<D*> -> <B*>)",
        typeid(dynamic_cast<B*>(pd)).name());
    printf("\t"); dynamic_cast<B*>(pd)->fun();
    // 5. dynamic(<B*> -> <D*>) 没成功转换
    printf(format,
        "5. dynamic(<B*> -> <D*>) B* points to <B>",
        typeid(dynamic_cast<D*>(pb)).name());
    if (dynamic_cast<D*>(pb) == NULL) {
        printf("\033[1m\t但实际上, cast failed\033[0m\n");
    }
    // 6. dynamic(<B*> -> <D*>) B*指向的是D
    printf(format,
        "6. dynamic(<B*> -> <D*>) B* points to <D>",
        typeid(dynamic_cast<D*>(pb_to_b)).name());
    printf("\t"); dynamic_cast<D*>(pb_to_b)->fun();


    // 不涉及多态的类间转换
    printf("---------------不涉及多态的类间转换---------------\n");
    X* px = new X();
    X* px_to_y = new Y();
    Y* py = new Y();
    X& X_ref_x = *px;
    X& X_ref_y = *py;
    Y& Y_ref_y = *py;

    // 初始信息
    printf("---------------初始信息---------------\n");
    printf("typeid(*px)): %s\n", typeid(*px).name());
    printf("typeid(*px_to_y)): %s\n", typeid(*px_to_y).name());
    printf("typeid(*py)): %s\n", typeid(*py).name());
    printf("typeid(X_ref_x)): %s\n", typeid(X_ref_x).name());
    printf("typeid(X_ref_y)): %s\n", typeid(X_ref_y).name());
    printf("typeid(Y_ref_y)): %s\n", typeid(Y_ref_y).name());
    printf("\n");

    // 1. dynamic(<Y> -> <X>) 这意味着有多态时, 引用类型转换结果最终还是取决于实际
    printf(format,
        "1. dynamic(<Y> -> <X>)",
        typeid(dynamic_cast<X&>(Y_ref_y)).name());
    // 2. dynamic(<X> -> <Y>) X实际引用X 这是不允许的, 源类型必须有多态
    // dynamic_cast<Y&>(X_ref_x));
    // 3. dynamic(<X> -> <Y>) X实际引用Y 这是不允许的, 源类型必须有多态
    // dynamic_cast<Y&>(X_ref_y);
    // 4. dynamic(<Y*> -> <X*>) 成功将派生类转换为基类
    printf(format,
        "4. dynamic(<Y*> -> <X*>)",
        typeid(dynamic_cast<X*>(py)).name());
    // 5. dynamic(<X*> -> <Y*>) 没成功转换
    typeid(static_cast<Y*>(px));
    // 6. dynamic(<X*> -> <Y*>), X*指向 <Y> 这是不允许的, 源类型必须有多态
    static_cast<Y*>(px_to_y);
}