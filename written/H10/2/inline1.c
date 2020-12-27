#include "inline.h"
#include <stdio.h>
f1()
{
    int a = 1;
    f(a);
    printf("%d\n", a);
}