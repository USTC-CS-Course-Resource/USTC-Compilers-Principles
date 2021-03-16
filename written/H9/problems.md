
1.    两个C文件link1.c和link2.c的内容分别如下

             int buf[1] ={100};

    和

             #include <stdio.h>
             extern int *buf;
             int main() { printf("%d\n", *buf); }

1）执行gcc -c -nostdinc link2.c时会输出如下错误：

    link2.c:1:19: error: no include path in which to search for stdio.h
     #include <stdio.h>
                       ^
    link2.c: In function ‘main’:
    link2.c:4:2: warning: implicit declaration of function ‘printf’ [-Wimplicit-function-declaration]
      printf("%d\n", *buf);
      ^~~~~~
    link2.c:4:2: warning: incompatible implicit declaration of built-in function ‘printf’
    link2.c:4:2: note: include ‘<stdio.h>’ or provide a declaration of ‘printf’

但是执行gcc -c link2.c时会正确生成link2.o文件，请问-nostdinc的作用是什么，使用该选项产生的error信息是什么阶段报出的错误？（提示：你可以通过使用-E、-S等选项来帮助你分析）

2）分别执行
     gcc -o link-s -static link2.c link1.c
或
     gcc -o link link2.c link1.c
将得到可执行文件link-s和link，比较文件大小，并用objdump -dS <可执行文件名>和nm <可执行文件名> 查看可执行文件link-s和link的反汇编代码和符号信息，请说明它们的区别和各自的好处。

3）执行 gcc -o link -nostdlib link2.c link1.c时，会输出如下错误信息：

    /usr/bin/ld: 警告: 无法找到项目符号 _start; 缺省为 000000000040017c
    /tmp/cccC0pRN.o：在函数‘main’中：
    link2.c:(.text+0x1a)：对‘printf’未定义的引用
    collect2: error: ld returned 1 exit status

请解释为什么会使用_start（提示：可以结合上一题中得到的link的反汇编代码来理解），这些错误是在什么阶段发生的

4）执行第2）小题得到的可执行文件，会有什么样的运行结果？请在32位和64位系统分别进行实验，再进行分析说明。

2.    教材11.13 两个C文件long.c和short.c的内容分别是

         long i = 32768 * 2;

    和

         extern short i;
         main() { printf(“%d\n”, i); }

    在X86/Linux系统上，用cc long.c short.c命令编译这两个文件，能否得到可执行目标程序？若能得到目标程序，运行时是否报错？若不报错，则运行结果输出的值是否为65536？若不等于65536，原因是什么？

3.    教材11.14 下面左右两边分别是两个C程序文件file1.c和file2.c的内容，用命令cc file1.c file2.c对这两个文件进行编译和连接。请回答：
     （a）编译器是否会报错？若你认为会，则说明理由。
     （b）若编译器不报错，连接器是否会报错？若你认为会，则说明理由。
     （c）若上面2步都不报错，则运行时是否会报错？若你认为会，则说明理由。
     （d）若上面3步都不报错，则运行输出的结果是什么？说明理由。

             char k = 2;                |            #include <stdio.h>
             char j = 1;                |            extern short k;
                                        |            main(){
                                        |               printf(“%d\n”, k);
                                        |            }

