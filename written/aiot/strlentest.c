#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define N 300000

#ifndef OUT
int main() {
    char* str = (char*)malloc(sizeof(char)*N);
    for (int i = 0; i < N-1; i++) {
        str[i] = 'a';
    }
    str[N-1] = 0;
    int i = 0;
    while (1) {
        int len = strlen(str);
        if (i < len) i++;
        else break;
        printf("%d\n", i);
    }
}
#else
int main() {
    char* str = (char*)malloc(sizeof(char)*N);
    for (int i = 0; i < N-1; i++) {
        str[i] = 'a';
    }
    str[N-1] = 0;
    int i = 0;
    int len = strlen(str);
    while (1) {
        if (i < len) i++;
        else break;
        printf("%d\n", i);
    }
}
#endif