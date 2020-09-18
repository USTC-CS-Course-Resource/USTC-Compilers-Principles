# HW1/H3问题回答

## 我的Makefile使用说明

首先描述一下我的Makefile的使用说明. 题目虽然要求使用`gcc`和`clang`, 并且要有32位和64位的不同版本结果, 但我统一为一个文件, 而借助make命令后接参数来决定使用的编译器和目标机器位数.  

以下是各种情况的编译命令(`-B`是覆盖):

- `gcc`, 32位: `make -B CC=gcc FLAGS=-m32`
- `gcc`, 64位: `make -B CC=gcc FLAGS=-m64`
- `clang`, 32位: `make -B CC=clang FLAGS=-m32`
- `clang`, 64位: `make -B CC=clang FLAGS=-m64`

这里有个小问题: 例如你在64位的Ubuntu上运行生成32位代码, 可能会找不到头文件. 可以通过命令`sudo apt install lib32z1 lib32z1-dev`来安装.

## 问题回答