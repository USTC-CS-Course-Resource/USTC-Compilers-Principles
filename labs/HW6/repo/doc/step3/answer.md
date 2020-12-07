# HW6-Step3

## 具体设计

整体设计是在做 `check` 的时候才去运算一些需要的值来进行语义检查, 而 `.yy` 文件中不作过多修改, 这样可以使得不同模块尽可能分离, 有利于工程上的方便. 

### 检查了的错误或警告
首先介绍一下我做了的错误或警告检查, 如下表所示:

|错误(警告)代码|中文说明|英文说明|示例文件|
|:-|:-|:-|:-|:-|
|01|变量重定义|variable redefined|01_variable_redefinition.c1|
|02|函数重定义|function redefined|02_func_redefinition.c1|
|03|使用了未定义左值|undefined left-val is used|03_undefined_lval.c1|
|04|使用了未定义函数|undefined function is used|04_undefined_function.c1|
|05|返回值不合法|invalid return(return an integer in void function...)|05_invalid_return.c1|
|06|以非正整数初始化数组大小|initiate array size isn't positive integer|06_array_size.c1|
|07|数组索引维度超出|array index dimension out of size|07_array_index_dim_outof_size.c1|
|08|索引越界|index out of bound(each dimension)|08_index_outof_bound.c1|
|09|类型转换错误|cast error (e.g. void can't be cast to integer)|09_error_cast.c1|
|10|定义数组使用了动态大小|initiate array size with dynamic variable|10_dynamic_array_size.c1|
|11|不能对常量赋值|try to modify a const variable|11_const_lval.c1|
|12|数组索引不是整数|index of array isn't integer|12_index_not_int.c1|
|13|并非数组(如a[0]而a不是数组)|not an array(like using a[0]|while a is just an integer)|13_not_array.c1|
|14|操作数为void类型|operating void variable(e.g. integet+void)|14_operate_void.c1|
|15|主函数必须返回int| main function should return int|15_main_not_return_int.c1|
|16|用非常量初始化常量|initiate const variable with non-const variable|16_init_const_with_nonconst.c1|
|17|对float类型用取余运算|modulo(%) can't be used for float|17_modulo_float.c1|
|18|没有main函数报错|no main function warning|18_no_main.c1|
|19|隐式类型转换警告|implicit cast warning(e.g int a = 1.0)|19_implicit_cast.c1|
|20|变量未使用警告|variable wasn't used|20_variable_not_used.c1|
|21|返回值不是void的函数没有返回|a non-void function has no return statement|21_no_return.c1|
|22|太多初始化值|too many initializer|22_too_many_initializer.c1|
|23|单目运算符只能用于整型和浮点型|unary can only be used for integer/float|23_unary_to_void.c1|

### 核心代码介绍

具体设计可以和核心代码一起介绍.

#### 重定义检查

重定义检查分为 `变量重定义`(01) 和 `函数重定义`(02).

- 变量重定义: 直接使用助教给出的数据结构(根据其他地方需求做出了一定修改)与代码来完成, 通过一个队列管理不同 `scope` 的变量, 每个 `scope` 用一个 `map` 作映射. 而后只需要检查是否重定义即可
- 函数重定义相对简单, 因为它被要求只能在全局域里定义, 因此只要用一个 `map` 检查就好了.

#### 未定义检查

未定义检查包含 `使用了未定义左值`(03) 和 `使用了未定义函数`(04).
- 使用了未定义左值: 这需要在访问 `LVal` 时来检查, 如果未定义, 即报错.
- 使用了未定义函数: 同上.

#### 函数返回问题

包括 `返回值不合法`(03), `主函数必须返回int`(15), `返回值不是void的函数没有返回`(21)
- 返回值不合法: 这里检查的主要是返回值不匹配的问题, 但对于 `int` 和 `float` 不作过多区分, 因为可以作隐式类型转换. 这需要在访问 `ReturnStmt` 时处理.
- `main` 函数的返回值必须是 `int`: 这需要在 `FuncDef` 处检查 `node.ret_type`
- 返回值不是 `void` 的函数没有返回: 这只需要通过 `ReturnStmt::ret` 是否为 `nullptr` 即可知道有无问题.

#### 数组问题

##### 数组大小设定问题

包括 `以非正整数初始化数组大小`(06), `用动态变量定义数组大小`(10)
- 以非正整数初始化数组大小: 在 `VarDef` 中处理, 考虑 `node.array_length` 的每个值即可.
- 用动态变量定义数组大小: 在 `VarDef` 中处理, 考虑 `node.array_length` 的每个值是否为 `const`, 如不是则报错.

##### 数组索引问题

包括 `数组索引维度超出`(07), `索引越界`(08), `数组索引不是整数`(12), `尝试索引非数组`(13)
- 数组索引维度超出 和 尝试索引非数组: 这两个都是索引的维度有问题. 在 `LVal` 中处理. 
    ```cpp
    if (index_dim_size != dim_size) {
        if (dim_size == 0) {
            err.error(node.loc, ERROR_NOT_ARRAY, "not an array: \033[4m" + node.name + "\033[0m");
            exit(1);
        }
        err.error(node.loc, ERROR_ARRAY_INDEX_DIM_CANNOT_MATCH, "array index dimentsion can't match");
        exit(1);
    }
    ```
- 索引越界 和 索引非整数: 在 `LVal` 中处理. 针对每个索引值检查其是否在给定范围内, 并检查其是否为整数.
    ```cpp
    if (expr->type != Type::INT) {
        err.error(node.loc, ERROR_ARRAY_INDEX_NOT_INT, "index isn't integer.");
        exit(1);
    }
    if (expr->ival < 0 || expr->ival >= ptr->array_length[i]) {
        err.error(node.loc, ERROR_ARRAY_INDEX_OUTOF_BOUND, "index out of bound");
        exit(1);
    }
    ```

#### 类型错误

包括 `类型转换错误`(09), `操作数为void类型`(14), `对float用%运算符`(17), `隐式类型转换警告`(20), `单目运算符只能用于int/float`(23)

- 其中错误代码为14, 17, 23的只需要在 `UnaryExpr` 和 `BinaryExpr` 中对类型加以判断即可
- 隐式类型转换警告则需要在返回处, 运算处等地方进行判断
- 类型转换错误也类似, 只不过对于 `void` 来说, 它不能向(或从) `int/float` 转换.

以上检查只需要对 `.type` 域做即可.

#### 常量赋值错误

包括 `不能对常量赋值`(11) 和 `用非常量初始化常量`(16)
- 这二者分别在 `AssignStmt` 处 和 `VarDef` 处对 `is_const` 域做一个简单判断即可.

#### 没有 main 函数错误

- `没有 main 函数错误`(18) 只需要在 `Assembly` 的最后对 `functions` 变量做判断即可
    ```cpp
    if (!functions.count("main")) {
        // main function isn't defined
        err.error(node.loc, WARN_NOMAIN, "\033[4mmain\033[0m function isn't defined.");
        exit(1);
    }
    ```

#### 太多初始化值错误

- `太多初始化值`(22) 是例如 `int a[1] = {1, 2}` 的错误, 只需要在 `VarDef` 处对数量作判断即可.
    ```cpp
    if (array_size < init_size) {
        err.error(node.loc, ERROR_TOO_MANY_INITIALIZER,
            "too many initializers for \033[4m" + node.name + "\033[0m");
        exit(1);
    }
    ```

#### 变量未使用警告

- 只需要在每次 `exit_scope()` 之前检查一下当前 `scope` 是否有未使用过的变量即可, 其中是否使用过可在 `Variable` 加一个域来表示.
    ```cpp
    for (auto variable: variables.front()) {
        if (!variable.second->is_used) {
            err.warn(loc, WARN_VARIABLE_NOT_USED,
                "variable \033[4m" + variable.second->name + "\033[0m wasn't used");
        }
    }
    ```

## 遇到的困难

- 考虑不全或 `bugs` 没被意识到:
    - 那只能 debug 呗.
- 建议下一届学生可以在本题中才指导使用 `RTTI`, 并给出点示例, 因为之前学过的已经有点遗忘了.

