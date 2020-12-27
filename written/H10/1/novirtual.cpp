#include <iostream>

using namespace std;

class ClassA {
public:
    int a;
    ClassA(int a): a(a) {}
    int geta() { return a; };
};

class ClassB: public ClassA {
public:
    int b;
    ClassB(int a, int b): ClassA(a), b(b) {}
    int getb() { return b; };
};

class ClassC: public ClassA {
public:
    int c;
    ClassC(int a, int c): ClassA(a), c(c) {}
    int getc() { return c; };
};

class ClassD: public ClassB, public ClassC {
public:
    ClassD(int a, int b, int c): ClassB(a, b), ClassC(a, c) {}
};

int main() {
    ClassA a(1);
    ClassB b(1,  2);
    ClassC c(-1, 3);
    ClassD d(1, 2, 3);

    printf("================================= My Test Output ===============================\n");
    printf("a.a: %d\n", a.a);
    printf("b.a: %d\tb.b: %d\n", b.b, b.b);
    printf("c.a: %d\tc.b: %d\n", c.a, c.c);
    printf("d.ClassB::a: %d\td.ClassC::a: %d\td.b: %d\td.c: %d\n",
        d.ClassB::a, d.ClassC::a, d.b, d.c);
    a.geta();
    b.geta(); b.getb();
    c.geta(); c.getc();
    d.ClassB::geta(); d.ClassC::getc(); d.getb(); d.getc();
}