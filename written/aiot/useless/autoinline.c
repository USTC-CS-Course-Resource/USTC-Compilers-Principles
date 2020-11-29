#include <stdio.h>

inline int fun(int n) {
    if (n == 0) return 1;
    else return fun(n-1) * n;
}

int main() {
    for (int i = 0; i < 10000; i++) {
        printf("%d", fun(i));
    }
}