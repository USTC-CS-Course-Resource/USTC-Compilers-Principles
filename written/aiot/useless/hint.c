#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define N 99999999

int main() {
    double count=0;
    double* n = (double*)malloc(sizeof(double)*N);
    for (__uint128_t i = 0; i < N/2; i++) {
        n[i] = 5;
    }
    for (__uint128_t i = N/2; i < N*5/6; i++) {
        n[i] = 3;
    }
    for (__uint128_t i = N*5/6; i < N*10/11; i++) {
        n[i] = 7;
    }
    for (__uint128_t i = N*10/11; i < N; i++) {
        n[i] = 1;
    }
    for (__uint128_t i = 0; i < N; i++) {
        if (n[i] >= 3) {
            if (n[i] >= 5) {
                count /= 5;
            }
            else count *= 3;
        }
        else if (n[i] <= 7) {
            if (n[i] <= 1) {
                count /= 1;
            }
            else count *= 7;
        }
    }
}
