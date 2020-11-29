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

    D() {}
    D(const B& b) {}
};

class X {
public:
    void fun() {cout << "base fun" << endl; } 
};
class Y: public X {
public:
    Y() {}
    Y(const X& x) {}
    void fun() {cout << "derived fun" << endl; } 
};

const char format[] = "\033[1m%-32s\033[0m: \033[4m%-4s\033[0m\n";
const char format_with_d[] = "\033[1m%-32s\033[0m: \033[4m%-4s\033[0m\t[%d]\n";
const char format_with_ld[] = "\033[1m%-32s\033[0m: \033[4m%-4s\033[0m\t[%ld]\n";
const char format_with_e[] = "\033[1m%-32s\033[0m: \033[4m%-4s\033[0m\t[%e]\n";

int main() {
    int* pi = new int(300);
    float* pf = new float(1.5);
    void *pv = new int(8);
    B* pb = new B();
    D* pd = new D();
    B& atb = *pb;
    D& atd = *pd;
    X* px = new X();
    Y* py = new Y();
    X& atx = *px;
    Y& aty = *py;

    printf("**本程序展示 static_cast 类型转换的一些结果**\n\n");

    // 初始信息
    printf("---------------初始信息---------------\n");
    printf("typeid(*pi)): %s\n", typeid(*pi).name());
    printf("typeid(*pf)): %s\n", typeid(*pf).name());
    printf("typeid(pv)):  %s\n", typeid(pv).name());
    printf("typeid(*pb)): %s\n", typeid(*pb).name());
    printf("typeid(*pd)): %s\n", typeid(*pd).name());
    printf("typeid(atb)): %s\n", typeid(atb).name());
    printf("typeid(atd)): %s\n", typeid(atd).name());
    printf("\n");

    // 自动类型转换
    printf("---------------静态自动类型转换---------------\n");
    // 1. static(<int> -> <float>)
    printf(format_with_e,
        "1. static(<int> -> <float>)",
        typeid(static_cast<float>(*pi)).name(),
        static_cast<float>(*pi));
    // 2. static(<float> -> <int>)
    printf(format_with_d,
        "2. static(<float> -> <int>)",
        typeid(static_cast<int>(*pf)).name(),
        static_cast<int>(*pf));
    // 3. static(<int> -> <int64_t>) 信息不丢失
    printf(format_with_ld,
        "1. static(<int> -> <int64_t>)",
        typeid(static_cast<int64_t>(*pi)).name(),
        static_cast<int64_t>(*pi));
    // 4. static(<int> -> <int8_t>) 信息丢失
    printf(format_with_d,
        "1. static(<int> -> <int8_t>)",
        typeid(static_cast<int8_t>(*pi)).name(),
        static_cast<int8_t>(*pi));
    printf("\n");

    // 静态 void* 相关转换
    printf("---------------静态 void* 相关转换---------------\n");
    // 1. static(<void*> -> <int*>)
    printf(format_with_d,
        "3. static(<void*> -> <int*>)",
        typeid(static_cast<int*>(pv)).name(),
        *static_cast<int*>(pv));
    // 2. static(<void*> -> <float*>)
    // 此处会造成值出问题, 因为是把一个int强行转化为float
    printf(format_with_e,
        "4. static(<void*> -> <float*>)",
        typeid(static_cast<float*>(pv)).name(),
        *static_cast<float*>(pv));
    printf("\n");

    // 静态保留类型指针间转换(不允许)
    // 1. static(<int*> -> <float*>) 这是不被允许的
    // static_cast<float*>(i);
    // 2. static(<int> -> <int*>) 也是不被允许的
    // static_cast<int*>(*i);

    // 多态关系的类间转换
    printf("---------------多态关系的类间转换, 看虚表---------------\n");
    // 1. static(<D> -> <B>) 转换了并且fun也变了
    printf(format,
        "1. static(<D> -> <B>)",
        typeid(static_cast<B>(*pd)).name());
    printf("\t"); static_cast<B>(*pd).fun();
    // 2. static(<B> -> <D>) 这里需要用户自定义转换
    printf(format,
        "2. static(<B> -> <D>)",
        typeid(static_cast<D>(*pb)).name());
    printf("\t"); static_cast<D>(*pb).fun();
    // 3. static(<D*> -> <B*>) 转换了但fun没变
    printf(format,
        "3. static(<D*> -> <B*>)",
        typeid(static_cast<B*>(pd)).name());
    printf("\t"); static_cast<B*>(pd)->fun();
    // 4. static(<D*> -> <B*>) 转换了但fun()没变
    printf(format,
        "4. static(<B*> -> <D*>)",
        typeid(static_cast<D*>(pb)).name());
    printf("\t"); static_cast<D*>(pb)->fun();
    // 5. static(<D&> -> <B&>) 转换失败, fun没变
    printf(format,
        "5. static(<D&> -> <B&>)",
        typeid(static_cast<B&>(atd)).name());
    printf("\t"); static_cast<B&>(atd).fun();
    // 6. static(<D&> -> <B&>) 转换失败, fun没变
    printf(format,
        "6. static(<B&> -> <D&>)",
        typeid(static_cast<D&>(atb)).name());
    printf("\t"); static_cast<D&>(atb).fun();

    // 无多态关系的类间转换
    printf("---------------无多态关系的类间转换, 该啥就啥---------------\n");
    // 1. static(<Y> -> <X>) 转换成功
    printf(format,
        "1. static(<Y> -> <X>)",
        typeid(static_cast<X>(*py)).name());
    printf("\t"); static_cast<X>(*py).fun();
    // 2. static(<X> -> <Y>) 这里需要用户自定义转换
    printf(format,
        "2. static(<X> -> <Y>)",
        typeid(static_cast<Y>(*px)).name());
    printf("\t"); static_cast<Y>(*px).fun();
    // 3. static(<Y*> -> <X*>) 转换成功
    printf(format,
        "3. static(<Y*> -> <X*>)",
        typeid(static_cast<X*>(py)).name());
    printf("\t"); static_cast<X*>(py)->fun();
    // 4. static(<Y*> -> <X*>) 转换成功
    printf(format,
        "4. static(<X*> -> <Y*>)",
        typeid(static_cast<Y*>(px)).name());
    printf("\t"); static_cast<Y*>(px)->fun();
    // 5. static(<Y&> -> <X&>) 转换成功
    printf(format,
        "5. static(<Y&> -> <X&>)",
        typeid(static_cast<X&>(aty)).name());
    printf("\t"); static_cast<X&>(aty).fun();
    // 6. static(<Y&> -> <X&>) 转换成功
    printf(format,
        "6. static(<X&> -> <Y&>)",
        typeid(static_cast<Y&>(atx)).name());
    printf("\t"); static_cast<Y&>(atx).fun();

}