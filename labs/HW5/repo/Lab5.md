### 相关知识

为了完成本关任务，你需要巩固对Flex词法描述以及命令行选项的理解和运用，补齐`L-expr`的词法描述。

#### `L-expr`语言简介
`L-expr`语言是简单的算术表达式语言，它包含数值以及算术表达式，支持加(`+`)、减(`-`)、乘(`*`)、除(`/`)、乘幂(`**`，或称乘方）五种双目运算符和负号(`-`)这种单目运算符。算符的优先级由高到低依次为：负号、乘方、乘和除、加和减；加、减、乘、除这些双目运算符满足自左向右结合，乘方运算符和负号都是自右向左结合。

用扩展的BNF(Backus-Naur Form)范式可以将`L-expr`语言的语法表示如下：
```bash
input ::= ε  | input line
line ::= EOL | expr EOL
expr ::= NUMBER 
       | expr PLUS expr	 # PLUS  – ‘+’加号
       | expr MINUS expr	# MINUS – ‘-’减号
       | expr MULT expr	 # MULT  – ‘*’乘号
       | expr DIV expr      # DIV   – ‘/’除号
       | MINUS expr		 # MINUS – ‘-’负号
       | expr EXPON expr    # EXPON – ‘**’乘方
       | LB expr RB	     # LB, RB – ‘(’, ’)’ 左右括号
```

**注意**：
1. 该文法是二义的，需要利用算符的优先级和结合性来消除二义性，参见`labBison/config/expr.y`，我们将在下一关详细说明。
2. 上述文法中大写字母组成的符号串是**终结符**，词法描述文件 `labBison/config/expr.lex`给出了除`EXPON`之外的定义，你需要补充增加对乘方运算符的定义，它返回记号`EXPON`完整。

#### `L-expr`程序举例
在`labBison/test/expr.in`给出了一个`L-expr`语言示例程序。你可以再编写2个示例程序，并用Python3检查其中各表达式的运算结果。
例如，`3**2**3`的运算结果是什么呢？
你可以在命令行下执行`python3`，进入交互式执行：
```python
>>>3**2**3
6561
>>> 3+-3-3
-3
>>>
```
注意：乘方是自右向左的结合，而不是把`3**2**3`当成`(3**2)**3`，得到`729`

#### L-expr的词法描述
[Flex](https://github.com/westes/flex) (Fast lexical analyzer generator)是词法分析器生成器lex的变种，它接受扩展名为`.lex`或`.l`的词法描述文件，产生对应的词法分析器的 C 源代码。
`L-expr`的词法描述文件见版本库的`labBison/config/expr.lex`, 下面依次解释该文件由`%%`分隔的三段内容。
##### 1. 声明部分
`labBison/config/expr.lex`中第1个`%%`之前的部分是声明，其中`%{...%}`括起的代码会被Flex直接复制到生成的词法分析器的 C 源码`*.lex.c`中，但不检查其合法性:
```bash
%{
#include "expr.tab.h"
#ifdef DEBUG
#define debug(a) printf("%s", a)
#else
#define debug(a) 
#endif
void yyerror(const char *);
%}
```
说明：
1）`expr.tab.h`是由Bison根据语法描述文件自动生成的，其中包含记号类型`enum yytokentype`以及各类记号的符号常量(如`NUMBER`、`PLUS`等)等。
2）带参的宏`debug`是用于调试以控制是否输出词法分析识别出的记号串。
3）声明函数`yyerror`以便使用（避免编译时产生警告）。

##### 2. 规则部分
在词法描述文件中介于两个`%%`之间的是词法规则部分。`labBison/config/expr.lex`中的词法规则如下：
```bash
[0-9]+     { yylval.val = atol(yytext);
             debug(yytext);
             return(NUMBER);
           }
[0-9]+\.[0-9]+ {
             debug(yytext);
             sscanf(yytext,"%f",&yylval.val);
             return(NUMBER);
           }
"+"        { debug("+"); yylval.op = "+";
             return(PLUS);}
"-"        { debug("-"); yylval.op = "-"; return(MINUS);}
"*"        { debug("*"); yylval.op = "*"; return(MULT);}
"/"        { debug("/"); yylval.op = "/"; return(DIV);}
"("        { debug("("); return(LB);}
")"        { debug(")"); return(RB);}
\n         { debug(""); return(EOL);}
[\t ]*     /* throw away whitespace */
.          { yyerror("Illegal character");
             return(EOL);
           }

```
说明：
1）[`yylval`](https://www.gnu.org/software/bison/manual/html_node/Token-Values.html)是存储记号的语义值的全局变量，它是在`labBison/src/expr.tab.h`中声明的类型为`YYSTYPE`的外部变量。
2）`yylval.val`和`yylval.op`分别表示记号类型为`NUMBER`以及算符的语义值类型，它是由Bison根据文法描述文件`labBison/config/expr.y`的`%union`声明生成的（你将在第2关对此有更深入的认识）。
3）全局变量`yytext`指向当前匹配的记号的文本，其长度保存在全局变量`yyleng`中。

##### 3. 代码部分
在词法描述文件的第2个`%%`之后是C代码部分，这部分代码将被Flex直接复制到生成的词法分析器源码的尾部。例如，这部分代码可以是
```c
void getsym()
{
	sym = yylex();
}
```
其中`yylex()`是flex生成的词法分析器的总控函数，它从输入流识别记号并返回指示记号类型的值。

不过在`labBison/config/expr.lex`中，第2个`%%`之后是空缺的，因为在后面的关卡中，它将配合Bison生成一个包含词法分析和语法分析的完整的解析器，Bison生成的解析器源码会调用`yylex()`进行词法分析。

##### Makefile
本实训项目主要使用版本库的`labBison/Makefile`来生成和编译词法分析、语法分析的解析代码。这里对Makefile中使用的自动变量等进行简要说明。
```bash
exp%:
        mkdir -p $(SRC)
        mkdir -p $(BIN)
        $(YACC) -d -y -r solved -b $@ -o $(SRC)/$@.tab.c $(CONF)/$@.y
        $(LEX) -i -I -o $(SRC)/expr.lex.c $(CONF)/$(EXPRLEX).lex
        $(CC) -DDEBUG -o $(BIN)/$@ $(SRC)/expr.lex.c $(SRC)/$@.tab.c -lfl -lm
```
在Makefile中,有：
- 名为`exp%`的编译目标，`%`是模式字符，用来通配任意个字符。
- `$@`: 表示规则的目标文件名。如果目标是一个文档文件（Linux 中，一般成 .a 文件为文档文件，也成为静态的库文件），那么它代表这个文档的文件名。在多目标模式规则中，它代表的是触发规则被执行的文件名。
- `$%`: 当目标文件是一个静态库文件时，代表静态库的一个成员名。
- `$<`: 规则的第一个依赖的文件名。如果是一个目标文件使用隐含的规则来重建，则它代表由隐含规则加入的第一个依赖文件。
- `$?`: 所有比目标文件更新的依赖文件列表，空格分隔。如果目标文件时静态库文件，代表的是库文件（.o 文件）。
- `$^`: 代表的是所有依赖文件列表，使用空格分隔。如果目标是静态库文件，它所代表的只能是所有的库成员（.o 文件）名。一个文件可重复的出现在目标的依赖中，变量“$^”只记录它的第一次引用的情况。就是说变量“$^”会去掉重复的依赖文件。
- `$+`: 类似“$^”，但是它保留了依赖文件中重复出现的文件。主要用在程序链接时库的交叉引用场合。
- `$*`: 在模式规则和静态模式规则中，代表“茎”。“茎”是目标模式中“%”所代表的部分（当文件名中存在目录时，“茎”也包含目录部分）。

-----

### 相关知识


为了完成本关任务，你需要在第1关任务的基础之上，进一步掌握：1. Bison的文法描述文件格式及命令行选项，2. Bison与Flex如何协作，3. 冲突的处理方法。

#### Bison 支持的文法
[Bison](https://www.gnu.org/software/bison/)是YACC（Yet another compiler compiler）的变种，YACC以LALR(1)分析技术为基础。

##### Bison 支持的分析表构造算法
由于历史原因，Bison缺省地构造LALR(1)分析表，但LALR不能处理所有的LR文法。不过，针对非LALR文法在冲突时可能发生的不确定行为，Bison提供简单的方法来解决冲突。你只需要使用`%define lr.type <type>`指令来激活功能更强大的分析表构造算法，其中参数`<type>`缺省地为`lalr`，还可以为`ielr`(Inadequacy Elimination LR）或`canonical-lr`。有关Bison的LR分析表构造的说明详见[这里](https://www.gnu.org/software/bison/manual/html_node/LR-Table-Construction.html)。在本实验中，仍以LALR分析表构造算法为基础。

##### Bison 支持的文法
Bison允许输入的文法是二义的(ambiguous)，如版本库中提供的`labBison/config/expr.y`，或者非二义但是不确定的(nondeterministic)，即没有固定向前看(lookahead)的记号数使得能明确要应用的文法规则。
通过引入适当的声明（如`%glr-parser`、`%expect n`、`%expect-rr n`、`%edprec`、`%merge`），Bison能够使用`GLR`(Generalized IR)分析技术来分析处理更一般的上下文无关文法，对这些文法而言，任何给定字符串的可能解析次数都是有限的。Bison的GLR分析参见 [这里](https://www.gnu.org/software/bison/manual/html_node/Generalized-LR-Parsing.html)。

##### 冲突及冲突的解决
对于某些文法，按Bison的分析表构造算法构造出的分析表存在有不确定的单元项（某个单元格有不止一种动作选项），这时称为存在移进-归约冲突([Shift/Reduce Conflicts](https://www.gnu.org/software/bison/manual/html_node/Shift_002fReduce.html))或者归约-归约冲突([Reduce/Reduce Conflicts](https://www.gnu.org/software/bison/manual/html_node/Reduce_002fReduce.html))。当文法存在冲突时，你需要了解Bison对冲突采取的处理策略，或者尝试修改文法以减少冲突，或者让Bison自动处理冲突，但是你需要知道Bison的自动处理策略。

###### 移进-归约冲突的解决
为避免Bison发出移进-归约冲突的警告，可以使用`%expect n`声明，只要移进-归约冲突的数量不超过`n`，Bison就不报这些警告（参见[这里](https://www.gnu.org/software/bison/manual/html_node/Expect-Decl.html)）。Bison会按**优先移进**来解决这种冲突。
不过，一般不建议使用`%expect`声明（`%expect 0`除外），而是建议使用优先级（`%precedence`）和结合性（`%left`、`%right`、`%noassoc`）的指令去显式声明记号的优先级和结合性，或者进一步对某条文法规则用`%prec <symbol>`声明按给定符号`<symbol>`的优先级和结合性来处理该条规则。有关Bison提供显式修复的优先级和结合性声明方法，参见[对非算子使用优先级](https://www.gnu.org/software/bison/manual/html_node/Non-Operators.html)、[算子优先级](https://www.gnu.org/software/bison/manual/html_node/Precedence.html)。

###### 归约-归约冲突的解决
归约-归约冲突发生在对输入的相同序列可以应用2条或多条文法规则的时候。可以在使用GLR分析技术时，用`%expect-rr n`声明指定期望的归约-归约冲突的次数。Bison会按**选择文法中首先出现的规则**来解决在期望范围内的冲突。同样地，也不建议使用`%expect-rr n`，而是希望用优先级和结合性指令来显式消除。

#### L-expr的语法描述
[Bison](https://www.gnu.org/software/bison/)接受扩展名为`.y`的文法描述文件，产生对应的解析器的 C 源代码。
`L-expr`语言的语法的一种简单直接的文法描述文件见版本库的`labBison/config/expr.y`，这是一个二义文法，同时声明了算符的优先级和结合性。下面依次解释该文法描述文件由`%%`分隔的三段内容。

##### 1. 声明部分
`labBison/config/expr.y`中第1个`%%`之前的部分是声明。
###### C代码声明
`%{...%}`括起的代码会被Bison直接复制到生成的语法分析器的 C 源码`*.tab.c`中，但不检查其合法性。这部分主要将要用到的头文件包含进来，另外声明了`yylex`和`yyerror`两个函数（去掉这两个声明时，编译用`bison`和`flex`生成的分析器源码时将会产生warning）。
```bash
%{
#include <stdio.h>
#include <math.h>
int yylex();
void yyerror(const char *s);
%}
```
###### 语义值类型的定义
`%union`用来定义文法符号的语义值类型，这里声明了`val`和`op`两个域：
```bash
%union {
   float val;
   char *op;
}
```
它们分别表示数值和运算符的语义值，在Bison生成的解析器源码中对应为`union YYSTYPE`共用体类型。有关Bison的记号声明详见[这里](https://www.gnu.org/software/bison/manual/html_node/Union-Decl.html)。

###### 记号的声明
`%token`用来声明记号（终结符）的种类及语义值类型（可以空缺）。有关Bison的记号声明详见[这里](https://www.gnu.org/software/bison/manual/html_node/Token-Decl.html)。
```bash
%token <val> NUMBER
%token <op> PLUS MINUS MULT DIV EXPON
%token EOL
%token LB RB
```
上面第1行声明`NUMBER`的语义值为`val`，而运算符的语义值为`op`。

###### 优先级与结合性的声明
`%left`、`%right`、`%nonassoc`用来声明记号的结合性，依次为自左向右的结合、自右向左的结合和无结合性。记号的优先级是由记号结合性声明所在行的先后次序来决定的，先出现的优先级较低；在同一行声明的记号具有相同的优先级。
在下面四行优先级和结合性声明中，负号`UMINUS`的优先级最高。有关Bison的优先级声明详见[这里](https://www.gnu.org/software/bison/manual/html_node/Precedence-Decl.html)。
```bash
%left  MINUS PLUS
%left  MULT DIV
%right EXPON
%right UMINUS
```
###### 文法符号的语义值类型声明
在早期的Bison版本中，`%type`用来声明终结符和非终结符的语义值类型；但是在后来的Bison版本(如本在线实训环境使用的Bison v3.5)中，只能用`%type`和`%nterm`声明非终结符的语义值类型。

下例中给出了在早期Bison版本支持的声明，即这里声明了非终结符`exp`和终结符 `NUMBER`的语义值类型均为`%union`中的`val`项，即为`float`类型。

```bash
%type  <val> exp NUMBER
```
但是在较新的Bison版本中（如Bison v3.5），终结符和非终结符的语义值类型需要用不同的声明指令声明，即：
```bash
%token  <val> NUMBER
...
%type  <val> exp
```
对非终结符的语义值类型的声明还可以使用`%nterm`替代`%type`。
有关Bison的文法符号的语义值类型声明详见[这里](https://www.gnu.org/software/bison/manual/html_node/Type-Decl.html)。

##### 2. 规则部分
在语法描述文件中介于两个`%%`之间的是文法规则部分。`labBison/config/expr.y`中的文法规则如下：
```bash
input   :
        | input line
        ;
line    : EOL
        | exp EOL { printf(" = %g\n",$1);}

exp     : NUMBER                 { $$ = $1;        }
        | exp PLUS  exp          { $$ = $1 + $3;   }
        | exp MINUS exp          { $$ = $1 - $3;   }
        | exp MULT  exp          { $$ = $1 * $3;   }
        | exp DIV   exp          { $$ = $1 / $3;   }
        | MINUS  exp %prec UMINUS { $$ = -$2;       }
        | exp EXPON exp          { $$ = pow($1,$3);}
        | LB exp RB              { $$ = $2;        }
        ;
```
###### 文法规则
每条规则以分号结尾，冒号左边的符号是要定义的非终结符，冒号右边的是文法符号和动作组成的序列。有关Bison的文法规则说明详见[这里](https://www.gnu.org/software/bison/manual/html_node/Rules-Syntax.html)。

###### 动作
动作由花括号括起的C代码组成，可以放在文法规则右端（right-hand side）的任意位置。绝大多数的规则只包含置于规则尾部的动作，如上面`labBison/config/expr.y`中的规则。有关Bison的动作说明详见[这里](https://www.gnu.org/software/bison/manual/html_node/Actions.html)。

动作中的C代码可以通过`$n`引用与该规则匹配的第`n`个组成元素的语义值。`$$`表示该规则正在定义的文法符号的语义值。文法符号的语义值还可以用名字来访问，如`$name`或`$[name]`。例如：
```bash
exp[result]  : ...
        | exp[left] PLUS  exp[right]   { $result = $left + $right;  }
```
###### 上下文相关的优先级
在文法规则部分，可以使用`%prec`声明所作用的规则的优先级为所指定的符号的优先级。通过这种声明，可以解决负号与减号文本相同但含义不同的冲突问题。有关Bison的上下文相关的优先级说明详见[这里](https://www.gnu.org/software/bison/manual/html_node/Contextual-Precedence.html)。
**注意**：负号和减号的冲突是在语法分析阶段解决的，而词法分析阶段对`-`识别后返回的都是记号`MINUS`。

在`config/expr.y`中存在如下代码片段，
```bash
%left  MINUS PLUS
...
%right UMINUS
...
%%
...
exp     : ...
        | MINUS  exp %prec UMINUS { $$ = -$2;       }
```
其中：声明部分引入一个新的符号`UMINUS`用来声明负号的优先级和结合性；然后在文法规则部分，对`MINUS exp`增加声明`%prec UMINUS`，指出该表达式按`UMINUS`的优先级和结合性处理，这样通过bison生成的分析器就能正确识别和处理负号和减号的不同语义。

##### 3. 代码部分
在文法描述文件中第2个`%%`之后是C代码部分，例如：
```c
void yyerror(const char *message)
{
  printf("%s\n",message);
}

int main(int argc, char *argv[])
{
  yyparse();
  return(0);
}
```
**Bison约定**：由其生成的分析器会调用名字为[`yyerror()`](https://www.gnu.org/software/bison/manual/html_node/Error-Reporting-Function.html)的函数来报告错误，而这个函数需要由用户提供定义。
函数[`yyparse()`](https://www.gnu.org/software/bison/manual/html_node/Parser-Function.html)是Bison生成的分析器的总控函数。

#### 用Bison和Flex协作构造解析器的流程
你可以用Bison和Flex为某种编程语言构造解析器，其主要流程如下：
1. 编写语言的词法描述文件和语法描述文件，如`labBison/config/expr.lex`和`labBison/config/expr.y`

2. 进入文件夹`labBison/`(若是在线实验，则进入`/data/workspace/myshishun/labBison`)

3. 用bison分析处理语法描述文件，如`config/expr.y`，产生解析器源码，如`src/expr.tab.c`和`src/expr.tab.h`（`*.h`在有`-d`选项或者文法描述文件中有`%defines`时产生），使用的命令如下：
`
bison -d -y -r solved -b expr -o src/expr.tab.c config/expr.y
`
Bison的选项详见[这里](https://www.gnu.org/software/bison/manual/html_node/Bison-Options.html)。上述命令使用的选项说明如下：
 - `-y`或者`--yacc`：表示像传统的`yacc`命令那样执行，缺省地，分析器源文件命名为`y.tab.c`和`y.tab.h` 
 - `-d`或者`--defines`：它假设在文法描述文件中指定了`%defines`，这将产生一个额外的输出文件，如这里的`expr.tab.h`，其中包含文法中声明的各个记号的记号类型定义以及符号常量等其他一些声明（详见[Bison声明总结](https://www.gnu.org/software/bison/manual/html_node/Decl-Summary.html)部分）
 - `-r solved`：它指示bison产生`*.output`文件输出关于文法和分析器的详细信息，包含所解决的冲突信息，该选项主要用来调试文法用，可以在调试成功后去掉
 - `-b expr`或`--file-prefix=expr`：它假设指定了`%file-prefix`，即指定Bison输出文件名的前缀，这里将缺省的`yy`修改为`expr`
 - `-o file`：指定输出的分析器源文件名

 其他有用的选项有：
 - `-v`或`--verbose`：将输出`*.output`文件，其中包含有关文法和分析器的详细信息
 - `-r things`或`--report=things`，指定包含在`*.output`文件中的额外要输出的内容，其中`things`可由若干通过逗号分隔的选项组成（参见[这里](https://www.gnu.org/software/bison/manual/html_node/Output-Files.html)）。例如`-r solved`将输出根据优先级和结合性指令解决的冲突情况。


4. 用flex分析处理`config/expr.lex`，产生词法分析器源码`src/expr.lex.c`，使用的命令如下：
`
flex -i -I -o src/expr.lex.c config/expr.lex
`
Flex的使用手册见[这里](http://westes.github.io/flex/manual/)，其选项详见[这里](http://westes.github.io/flex/manual/Scanner-Options.html)，上述命令使用的选项说明如下：
 - `-i`或者`--case-insensitive`或者`%option case-insensitiv`：指示flex生成不区分大小写的词法分析程序（扫描器scanner）
 - `-I`或者`--interactive`或者 `%option interactive`：指示flex生成交互式扫描器，它会向前看足够的符号来确定匹配的记号
 

5. 用C编译器编译解析器的源程序，如：
`gcc -g -Iinclude -o bin/expr src/expr.lex.c src/expr.tab.c -lfl -lm
`
 这里`-l`选项指示要链接的库，包括libfl和libm，分别是flex和math库。
 **注意**：有的flex库是命名为libl，这时就需要将`-lfl`修改为`-ll`。

6. 执行解析器分析`L-expr`程序，可以使用`./run.sh expr expr.in`指定要运行的解析器和`L-expr`程序，它等同于`bin/expr <test/expr.in`

##### 注意

先执行bison的原因是为了产生语法分析和词法分析共用的记号类型及记号的符号常量等，它们定义在`*.tab.h`中。这时`bison`的命令行选项必须要增加`-d`或者在文法描述文件中必须使用`%defines`。

#### 位置的跟踪
在实际进行编译器开发时，往往希望编译器能跟踪被分析程序在源代码的位置信息，这一方面有助于调试正在研制的编译器，另一方面也便于编译器能在识别出程序故障时报告警告或错误的位置信息。
下面以版本库`labBison`目录下的`config/expr.lex`和`config/expr.y`为例，说明Bison如何与Flex协作来跟踪程序的位置信息。

##### 1. 文法描述文件expr.y中设置位置跟踪
在文法描述文件中增加如下指令设置位置跟踪：
`%locations
`
Bison会在生成的定义文件(如`expr.tab.h`)中包含YYLTYPE类型的定义，它可以是用户自定义的，如果用户没有定义，则bison会缺省地给出如下定义：
```c
/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif
```
然后会进一步定义`YYLTYPE yylloc`全局变量，保存当前的位置信息。需要注意的是，Bison并不会自动进行位置的跟踪，如果要跟踪程序的分析位置，还需要如下flex词法分析的配合。

##### 2. 词法描述文件expr.lex中的处理
首先要增加如下选项声明，来让词法分析器跟踪行号的变化，当前程序解析所处的行号保存在全局变量`yylineno`中。
`%option yylineno
`
然后在声明部分增加对宏`YY_USER_ACTION`的定义，bison会在生成的解析器代码中在执行归约后调用它；此外，还声明了yycolumn变量用来跟踪列的位置。
```c
/* handle locations */
int yycolumn = 1;

#define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno; \
    yylloc.first_column = yycolumn; yylloc.last_column = yycolumn+yyleng-1; \
    yycolumn += yyleng;
```
注意：你需要在词法描述中设置`yycolumn`在每行开始时的初值，如在`expr.lex`中识别出换行后处理：
`\n         { yycolumn = 1; debug(""); return(EOL);}
`
##### 3. 文法描述文件expr.y中使用位置信息
在文法描述文件的规则部分，你可以使用`@$`、`@n`来访问规则左部符号、右部第`n`个符号对应的位置信息，该位置值的类型是上面的`YYLTYPE`，缺省地为包含起止行列位置的结构体。
```c
line    : EOL  { printf("\n");}
        | exp EOL { printf(" = %g at line %d\n",$1, @$.last_line);}

```
### 回答

`yyss`: 这个变量和 `yyssa` 数组(状态栈)配合使用, `yyss` 为其基址, 除非出现溢出(overflow), 否则它不会改变(溢出时需要重新分配数组, 因此会改变); `yyssp` 则是相应栈顶指针.
- `yyvs`: 与 `yyss` 不同的是, 它用于保存 `语义值`. 同样也有 `yyvsp` 和 `yyvsa`
- `yyn`: 这仅仅是个变量, 可能表示状态序号或者产生式序号
- `yytoken`
- `yyval`: 在其定义处(`YYSTYPE yyval`)有注释
    > The variables used to return semantic value
    其意为该变量用以返回语义值
- `yydefact`: 用来表示该状态下默认的规约产生式, 即决定了课本上表中的 `r#`(#是该产生式序号, 即 `yydefact[state-num]`)
- `yydefgoto`: `yydefgoto[index]` 表明了第 index 个非终结符的默认GOTO状态.
- `yytable`: 用来表示移进后下一个状态是什么 或 应使用什么样的产生式规约, 如果为正, 则进行移进; 若为负, 则按其相反数对应的产生式进行规约; -1表示错误
- `yycheck`: 用以指导使用 `yypgoto` 还是 `yydefgoto`. 
- `yypact`: 如果 `yypact[cur-state]` 为 `YYPACT_NINF`, 那么就应该使用 `yydefact`; 否则将这个值加到向前看符号序号, 并用加法结果来查询 `yytable`(也就是用索引号 `yypact[cur-state]+#lookahead-token` 查询 `yytable`)， 以此决定要规约还是移进(根据正负).
- `yypgoto`: 对于刚刚规约了的产生式左部, 其在 `yypgoto` 有一个值, 将这个值加到因为规约而暴露出来的状态序号值上得到index, 即可得到规约结果的状态值为 `yytable[index]`.

另外
- `yystos`: YYSTOS[STATE-NUM] -- The (internal number of the) accessing symbol of state STATE-NUM. 
- `yyr1[yyn]`: Symbol number of symbol that rule YYN derives
- `yyr2[yyn]`: Number of symbols on the right hand side of rule YYN

### yyparse 的主要流程

1. 第一部分定义了栈及栈指针, 各种其他变量.
2. 然后进入 `yysetstate` 来设置栈顶状态, 这主要是通过
    ```c
    *yyssp = YY_CAST (yy_state_t, yystate);
    ```
    完成
    此外, 这其中还包括了 `overflow` 的相关判断及扩栈代码.
3. 接下来进入后续处理 `yybackup`. 这一步是关键处理步骤, 比较复杂, 主要用来处理移进规约和跳转
    1. 根据 `yypact[yystate]`, 能够求出是否能够不进行 `lookahead` 就确定下一个状态, 
        - 如果可以就直接进入 `yydefault`, 就直接进入并处理. 这可由该句判断
            ```c
            yypact_value_is_default (yyn)
            ```
        - 否则要进行 `lookahead`, 通过多读入一个 `yychar`, 并转化为 `yytoken`. 然后用 `yycheck` 来确定有了这个 `yytoken` 之后, 能否就确定是否可使用 `yytable`.
            - 如果多读入的 `yytoken` 仍然没法解决问题, 就调用 `yydefault`
            - 如果能够使得程序规约(`yyreduce`)或检测出错误(`yyerrlab`), 则调到相应的代码.
        - 否则`yyn` 就必然是(0,YYLAST]之间的值, 于是移进预读的 `token`, 并进入`yynewstate`
4. 从步骤3可能进入以下几个处理代码段:
    - `yydefault`: 如果当前状态 `yystate` 的默认动作(`yydefact`) 为0则表示有错, 否则进入 `yyreduce`, 这时 `yyn` 表示用以规约的产生式序号
    - `yyreduce`: 这一步
        - 首先按照我们在 `.y` 文件中定义的规约规则执行 (对 `yyn` 作 `switch` 操作)
        - 然后决定 `goto` 哪个状态. 如果是不能确定的情况, 就要根据 `yydefgoto[yylhs]` 决定, 否则直接根据 `yytable[yyi]` 决定.
        - 最后 `goto yynewstate`
5. 其他还有一些错误处理和 `accept` 等简单状态, 暂时没时间看了.

----
----
