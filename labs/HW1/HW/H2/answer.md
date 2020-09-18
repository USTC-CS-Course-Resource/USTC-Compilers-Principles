# HW1/H2问题回答

## 问题2-1

### 问题

1. `-nostdinc`选项的用处是什么？
2. 请列出 EduCoder 平台上 `gcc` C程序默认的头文件查找路径
3. 如何在使用了`-nostdinc`选项的同时使得上述命令编译通过? 请进一步说明通过的原因（不能修改源文件）。

### 回答

1. 用`man gcc`来查询, 发现这个参数的含义是`Do not search the standard system directories for header files.  Only the directories you have specified with -I options (and the directory of the current file, if appropriate) are searched.`  
用中文解释一下也就是, 编译的时候不去搜索头文件的标准系统路径, 这样一来自然就找不到`stdio.h`的包含路径, 从而引发编译错误.
2. 根据官方文档资料, 得知通过命令`cpp -v /dev/null -o /dev/null`, 在bash中用`gcc`可以简单写成`gcc -xc -v -E -`(其中-xc指定c语言, -E指定预处理)可以得到搜索路径, 如下
```
#include <...> search starts here:
 /usr/lib/gcc/x86_64-linux-gnu/5/include
 /usr/local/include
 /usr/lib/gcc/x86_64-linux-gnu/5/include-fixed
 /usr/include/x86_64-linux-gnu
 /usr/include
```
3. 在第一题的回答中, 可以看到此时`gcc`只会搜索用`-I`指定的路径, 因此我们可以用它指定一下路径, 即使用命令: `gcc -E -nostdinc -I/usr/include -I/usr/lib/gcc/x86_64-linux-gnu/5/include sample-io.c -o sample-io.i`. 这里包含了两个路径`/usr/include`(有`stdio.h`等)和`/usr/lib/gcc/x86_64-linux-gnu/5/include`(有`stddef.h`等)  

参考资料:
- [2.3 Search Path](https://gcc.gnu.org/onlinedocs/cpp/Search-Path.html)

## 问题2-2

### 问题

1. `-nostdlib`选项的用处是什么？
2. 请列出 EduCoder 平台上 `gcc` C程序默认链接的库
3. 如何在使用了`-nostdlib`选项的同时使得上述命令编译通过？请进一步说明通过的原因（不能修改源文件）。

### 回答

有了第一问的基础, 第二问基本上类似了.  
1. 用`man gcc`查找对`-nostdlib`的描述, 得到`Do not use the standard system startup files or libraries when linking. `也就是"链接时不使用标准系统启动文件或库". 这样一来也就导致了报`printf`为未定义引用的错误了, 因为代码没能链接到对应库上.
2. 通过`gcc`调用链接器, 并用`--verbose`输出详细信息.即`gcc -xc -Xlinker --verbose 2>- | grep SEARCH_DIR`. 为保留有用输出信息, 可以经过下述管道处理: `gcc -xc -Xlinker --verbose 2>- | grep SEARCH_DIR | sed 's/SEARCH_DIR("=//g' | sed 's/"); */\n/g'`, 得到:
```
/usr/local/lib/x86_64-linux-gnu
/lib/x86_64-linux-gnu
/usr/lib/x86_64-linux-gnu
/usr/local/lib64
/lib64
/usr/lib64
/usr/local/lib
/lib
/usr/lib
/usr/x86_64-linux-gnu/lib64
/usr/x86_64-linux-gnu/lib
```
3. 这一步需要链接上`libc.so`和`crt`文件, 即使用如下命令`gcc -nostdlib sample-io.c /usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/x86_64-linux-gnu/crtn.o -lc -o sample-io`. 其中`crt`文件是第一关介绍过的. 而`libc`文件则是`printf`等函数的库.
