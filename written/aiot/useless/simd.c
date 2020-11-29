#include <stdio.h>

int main() {
    int a[128];
    int b[128];
    int c[128];
    for (int i = 0; i < 128; i++) {
        a[i] = i;
        b[i] = i;
    }
    for (int i = 0; i < 128; i++) {
        c[i] = a[i] + b[i];
    }
    for (int i = 0; i < 128; i++) {
        printf("%d", c[i]);
    }
}
