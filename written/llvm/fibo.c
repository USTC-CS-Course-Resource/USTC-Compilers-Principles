int fib(int n) {
    int r;
    if (n == 0)
    r = 0;
    else if (n == 1)
    r = 1;
    else
    r = fib(n - 1) + fib(n - 2);
    return r;
}
int main() {
    int x = 0;
    float n = 8;
    for (int i = 1; i < (int)n; ++i) {
    x += fib(i);
    }
    return x;
}