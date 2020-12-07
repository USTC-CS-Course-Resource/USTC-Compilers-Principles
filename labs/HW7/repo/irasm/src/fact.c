#include "stdio.h"
int  f2(int n){
  static int m; m = n;
  if (m==0) return 1;
  else return m*f2(m-1);
}

int  f1(int n){
  if (n==0) return 1;
  else return n*f1(n-1);
}

int n=3;
int  f3(){
  if (n==0) return 1;
  else return n*f3(n-1);
}

int main()
{
  printf("%d, %d", f1(3), f2(3));
//  printf("%d", f3());
}
