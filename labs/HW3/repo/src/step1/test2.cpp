#include <iostream>
#include <memory>
#include <cassert>
#include <sstream>
#include <cstring>

using namespace std;

int main() {
    while (true) {
        size_t N = 1 << 28;
        /*auto_ptr<int> ptest(new int[N]); // 分配一个数组
        memset(ptest.get(), 1, sizeof(int) * N);
        ptest.reset();  // 释放第一元(实际上行为似乎是释放了前几元)*/
        int *p = new int[N];
        memset(p, 1, sizeof(int) * N);
    }
}
