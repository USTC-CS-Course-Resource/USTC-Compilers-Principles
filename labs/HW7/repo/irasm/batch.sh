gcc -S src/$1.c -o $2/$1$3.s $3
clang -S src/$1.c -o $2/$1-clang$3.s $3
clang -emit-llvm -S src/$1.c -o $2/$1$3.ll $3
