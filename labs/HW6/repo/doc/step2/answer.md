# HW6-Step2

## 1

### 问题
请阅读`include/SyntaxTree.h`,总结在该文件中声明了哪些类型和类，分别表示什么含义；进一步阅读`src/SyntaxTree.cpp`，指出其中定义的各个方法的作用。

### 回答

#### 声明了的类型和类及其含义

##### 名字空间
- 名字空间 `SyntaxTree`: 在语法树的名字空间里声明定义相关内容
##### 一些别名
- `Ptr`: 共享指针
- `PtrList`: 共享指针的 `vector`
- `Position`: 别名自 `yy::location`
##### 一些枚举类
- `TYPE`: 定了一些数据类型, `INT`, `FLOAT`, `VOID`
- `BinOp`: 定义了一些双目算术运算符
- `UnaryOp`: 定义了一些单目运算符
##### Node 及其子结构体
> 注: 每个都继承了 `accept`, 就不一一赘述了.
- `Node`: 它是所有语法树结点的 `base`, 其内包含变量 `loc` 以表示位置信息 及一个 `accept()` 虚函数
    - `Assembly`: 继承于 `Node`. 表示语法树的根节点
    - `GlobalDef`: 表示全局定义结点
        - `FuncDef`: 继承于 `GlobalDef`. 还包含有返回值类型 `ret_type`, 名称 `name`, 指向函数块的指针 `body`
    - `Expr`: 表达式结点.
        - `BinaryExpr`: 双目运算表达式结点. 包含运算符 `op`, 左右表达式指针 `lhs`, `rhs`
        - `UnaryExpr`: 单目运算符表达式结点. 包含运算符 `op`, 右表达式 `rhs`
        - `Lval`: 左值结点. 包含其名称 `name`, 如果是个数组, `array_index` 不为 `nullptr`
        - `Literal`: 常量结点. `is_int` 表示是否为 `int`, `int_const` 和 `float_const` 表示对应值.
    - `Stmt`: 语句结点.
        - `VarDef`: 它还是个 `GlobalDef` 的子类. `is_constant` 表示是否为常量, `btype` 表示类型, `name` 表示名字, `is_inited` 用来验证 `{}`, `array_length` 表示一个表达式列表, `initializers` 表示一个表达式列表(之所以是个列表, 是要为了数组服务)
        - `AssignStmt`: 赋值语句结点. `target` 是左值目标, `Value` 是表达式值
        - `FuncCallStmt`: 函数调用语句结点. `name` 是名字.
        - `ReturnStmt`: 返回语句结点. `ret` 是表达式返回值.
        - `BlockStmt`: 块结点. `body` 是其内容
        - `EmptyStmt`: 空语句结点, 也就是一个 `;`

##### 访问者类
- `Visitor`: 为访问者类. 其内虚函数针对了所有 `Node` 类型定义了虚函数.


## 2
### 问题
请阅读`src/C1Driver.cpp`、`src/main.cpp`并浏览`grammar`目录下C1语言的词法描述文件`C1Parser.ll`和文法描述文件`C1Parser.yy`，简述`C1Driver`类与词法分析类和语法分析类之间的关系，词法分析类和语法分析类与`C1Parser.ll`和`C1Parser.yy`之间的对应关系。
### 回答
#### `C1Driver`类与词法分析类和语法分析类之间的关系
`C1Driver` 通过启用词法分析器(对应类为 `C1FlexLexer`), 协同语法分析器(对应类为 `yy::C1Parser`)进行分析. 其中 `yy::C1Parser` 能够获取到词法分析器是因为构建其对象时, 传入了 `*this`(类型为 `C1Driver`). 然后就可以做类似上个实验的分析过程了(唯一区别就是面向对象)
#### 词法分析类和语法分析类与`C1Parser.ll`和`C1Parser.yy`之间的对应关系
两个类是由 `C1Parser.ll`和`C1Parser.yy` 所定义生成的.


## 3
### 问题
理解bison文法文件`C1Parser.yy`，描述其中**至少3种非终结符的产生式定义**及其相关的**AST语法树生成的实现**，你需要从下列非终结符中挑选要描述的产生式定义以及AST语法树的生成：
  - CompUnit、ConstDecl、ConstDef、VarDef、FuncDef、Stmt、Exp
### 回答
就挑前三个吧hh
#### `CompUnit`
首先放一下它的代码:
```yacc
CompUnit:CompUnit GlobalDecl{
    $1->global_defs.insert($1->global_defs.end(), $2.begin(), $2.end());
    $$=$1;
  } 
  | GlobalDecl{
    $$=new SyntaxTree::Assembly();
    $$->global_defs.insert($$->global_defs.end(), $1.begin(), $1.end());
  }
  ;
```
- 这里这玩意表示计算单元, 直观上可以说它有多个 `GlobalDecl`(全局声明) 组成.
- 每当新弄到一个 `GlobalDecl`(第一个产生式) 就把它加入到 `CompUnit` 的 `global_defs`(全局定义的 `vector`)的末尾, 并将该 `SyntaxTree::Assembly` 实例传给产生式左部
- 如果是最终情况了(在这里就是找到了第一个 `GlobalDecl`), 那么就 `new` 一个 `SyntaxTree::Assembly`, 以完成整个 `CompUnit` 的归约.
#### `ConstDecl`
依然是先放一下代码
```yacc
ConstDecl:CONST DefType ConstDefList SEMICOLON{
    $$=$3;
    for (auto &node : $$) {
      node->btype = $2;
    }
  }
  ;
```
- 这个非终结符是 `常量声明` 的意思. 它只有一种产生式: `ConstDecl -> CONST DefType ConstDefList SEMICOLON`. 这里这个单词 `SEMICOLON` 是分号的意思. 这个产生是由 `CONST` 开头, 后接类型, 再接常量定义列表, 而后分号.
- 其语法树的生成十分简单, 产生式左部的 `Node` 直接就是 `ConstDefList` 对应的整个列表(它对应的结点是 `SyntaxTree::PtrList` 类型的). 然后它只需要再把每个结点(`VarDef` 类型)的 `btype` 赋值为对应类型 `DefType` 即可.
#### `ConstDef`
代码:
```yacc
ConstDef:IDENTIFIER ASSIGN Exp{
    $$=new SyntaxTree::VarDef();
    $$->is_constant = true;
    $$->is_inited = true;
    $$->name=$1;
    $$->initializers.push_back(SyntaxTree::Ptr<SyntaxTree::Expr>($3));
    $$->loc = @$;
  }
  ;
```
- 这个非终结符表示常量定义. 首先要有标识符 `IDENTIFIER`, 其次是赋值符号 `ASSIGN`, 然后是表达式.
- 其语法树生成过程中, 首先当然是 `new` 了个 `VarDef`. 然后确定其为 `constant`, 且 `inited`, 再赋值其名称为 `IDENTIFIER` 的语义值, 然后把向 `initializers` 推入表达式结点(`Exp` `SyntaxTree::Expr`)对应的指针. 此外还要对 `loc` 进行位置信息的赋值.

## 4
### 问题
理解`include/SyntaxTreePrinter.h`和`src/SyntaxTreePrinter.cpp`文件，描述访问者模式在这个类中的体现：如何处理`VarDef`、`BinaryExpr`、`BlockStmt`、`FuncDef`这几类语法树节点的。
### 回答
首先 `include/SyntaxTreePrinter.h` 继承了 `SyntaxTree::Visitor`, 并有自己的私有成员 `indent` 表示缩进量 及 `print_indent()` 函数输出缩进

更为主要的还是 `.cpp` 文件.
它实现了 `Visitor` 中需要的虚函数, 从而赋予了访问者不同的操作功能. 

其中所有的 `accept(*this)` 传入了 `*this`, 这里统一解释一下: 用同一个访问者来进行输出, 并且因为多态, 能够针对不同类型的 `Node` 而调用不同的 `visit` 函数, 进而完成所有输出.

下面分述题目要求的几个函数:

#### 对于 `VarDef`
- `void SyntaxTreePrinter::visit(VarDef &node)`
- 首先输出缩进量
- 然后针对是否为 `const` 来输出
- 然后是类型和名称
- 紧接着输出数组长度信息(如果有)
- 然后是初始化信息(如果有)
- 最后一个分号
- 其中通过调用 `length->accept(*this)`, 能够去用 `*this` 访问 `length` 以输出长度; 调用 `init->accept(*this)` 同理, 输出初始化信息
#### 对于 `BinaryExpr`
- 定义于 `void SyntaxTreePrinter::visit(BinaryExpr &node)`
- 首先输出 `(`
- 然后通过访问左表达式 `node.lhs->accept(*this)` 以输出左表达式
- 再输出运算符
- 右表达式同理
- 最后 `)`
#### 对于 `BLockStmt`
- 定义于 `void SyntaxTreePrinter::visit(BlockStmt &node)`
- 同样先输出缩进, 然后 `{`
- 此时缩进量 += 4
- 通过 `stmt->accept(*this)` 逐一访问该 `BlockStmt` 的 `stmt`
- 缩进量 -=4, 输出 `}`, 换行
#### 对于 `FuncDef`
- 定义于 `void SyntaxTreePrinter::visit(FuncDef &node)`
- 首先输出返回值类型, 然后一个空格, 再是函数名, 然后括号, 换行.
- 随后就通过访问函数体来输出函数体 `node.body->accept(*this)`
- 缩进量归零

## 5
### 问题
提供的实训代码实现的是以下的文法（其他非终结符的产生式定义与C1语言一样）:
```
Stmt        → LVal '=' Exp ';'
            | Ident '(' ')' ';'
            | 'return' [ Exp ] ';'
            | Block
            | ';'	B
Exp         → Exp BinOp Exp
            | UnaryOp Exp
            | '(' Exp ')'
            | LVal
            | Number
```
其中函数调用是作为单独的一种语句`Stmt -> Ident '(' ')' ';'`。
现需要修改为C1语言的文法，即函数调用是一种表达式`Exp -> Ident '(' ')'`，而在语句中有特殊的表达式语句`Stmt -> Exp ';'`
```
Stmt        → LVal '=' Exp ';'
            | Exp ';'
            | 'return' [ Exp ] ';'
            | Block
            | ';'
Exp         → Exp BinOp Exp
            | UnaryOp Exp
            | '(' Exp ')'
            | Ident '(' ')'
            | LVal
            | Number
```
请修改相应的代码并在`SyntaxTreePrinter`中进行支持。
注：需要保持打印的格式（命令行加上`-e`选项），函数调用前后不需要加上括号，单个函数调用表达式也不需要；其他非终结符的产生式定义一致。
### 回答
#### 代码修改
1. 首先应当对应地添加 `SyntaxTree.h` 以表示相应数据结构(`SyntaxTree.cpp` 也有对应修改)
    - 添加数据结构 `FuncCallExpr : Expr`
        ```cpp
        struct FuncCallExpr : Expr
        {
            Ptr<FuncCallExpr> func_call;
            virtual void accept(Visitor &visitor) override final;
        };
        ```
    - 在头文件里作对应修改.


2. 然后把 `Stmt` 的定义那里的 `函数调用产生式` 改为
    ```yacc
    | Exp SEMICOLON {
      auto temp = new SyntaxTree::FuncCallStmt();
      temp->func_call = $1;
      $$ = temp;
      $$->loc = @$;
    }
    ```
    在 `Exp` 的产生式里添加
    ```yacc
    | IDENTIFIER LPARENTHESE RPARENTHESE{
        auto temp = new SyntaxTree::FuncCallExpr();
        temp->name = $1;
        $$ = temp;
        $$->loc = @$;
    }
    ```
3. 最后修改 `SyntaxTreePrinter.h` 和 `SyntaxTreePrinter.cpp` 里的.
    - `SyntaxTreePrinter.h`中添加
      ```cpp
      virtual void visit(SyntaxTree::FuncCallExpr &node) override;
      ```
    - 修改 `SyntaxTreePrinter.cpp`:
      ```cpp
      void SyntaxTreePrinter::visit(FuncCallExpr &node)
      {
          std::cout << node.name << "()";
      }
      ```
      ```cpp
      void SyntaxTreePrinter::visit(FuncCallStmt &node)
      {
          print_indent();
          node.accept(*this);
          std::cout << ";" << std::endl;
      }
      ```
#### 验证
通过下面这个简单的函数调用程序进行验证, 发现输出正确.
```c
int fun() {
    int a = 5;
    return a;
}

int main() {
    fun();
    int a = 5+fun();
    return fun();
}
```
注: 其输出结果如下,
```c
int fun()
{
    int a = 5;
    return a;
}
int main()
{
    fun();
    int a = (5+fun());
    return fun();
}
```