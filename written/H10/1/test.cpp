class TestClass {
public:
    TestClass(int a, int b, int c) {}
    TestClass(int c, int d) {}

    void publictest() {privatetest();protectedtest();}
private:
    void privatetest() {}
protected:
    void protectedtest() {}
};

int main() {
    TestClass tc(5,3,3);
    TestClass tc1(5,3);
    tc1.publictest();

}