#include "SyntaxTreeChecker.h"
#include <sstream>

using namespace SyntaxTree;

void SyntaxTreeChecker::visit(Assembly &node)
{
    enter_scope();
    for (auto def : node.global_defs) {
        def->accept(*this);
    }
    warn_variable_not_used(node.loc);
    exit_scope();
    if (!functions.count("main")) {
        // main function isn't defined
        err.warn(node.loc, WARN_NOMAIN,
            "\033[4mmain\033[0m function isn't defined.");
    }
}

void SyntaxTreeChecker::visit(FuncDef &node) {
    if (!declare_function(node)) {
        err.error(node.loc, ERROR_REDEFINITION,
            "redefinition of \033[4m" + node.name + "\033[0m");
        exit(1);
    }
    ret_type = node.ret_type;
    node.body->accept(*this);
}

void SyntaxTreeChecker::visit(BinaryExpr &node) {
    // TODO: 左右类型和运算符匹配的检查
    //// TODO: 整型和浮点型之间进行算术运算，要将整型数转换成浮点型数之后再进行运算
    //// TODO: 整型和浮点型之间赋值，要按赋值号左边的运算对象的类型对赋值号右边的结果进行类型转换，再进行赋值。

    // TODO: 这里应该按结合性顺序检查吗？？？
    BinOp op = node.op;
    Ptr<Expr> lhs = node.lhs;
    Ptr<Expr> rhs = node.rhs;
    lhs->accept(*this);
    rhs->accept(*this);
    if (lhs->is_const && node.rhs->is_const) {
        node.is_const = true;
        if (lhs->type == Type::ERROR || rhs->type == Type::ERROR) {
            node.type = Type::ERROR;
        }
        else if (lhs->type == Type::VOID || rhs->type == Type::VOID) {
            node.type = Type::VOID;
        }
        else if (lhs->type == Type::FLOAT && rhs->type == Type::INT) {
            node.type = Type::FLOAT;
            if (op == BinOp::MODULO) node.type = Type::ERROR;
            else node.fval = operate<double>(op, lhs->ival, rhs->ival);
        }
        else if (lhs->type == Type::INT && rhs->type == Type::FLOAT) {
            node.type = Type::FLOAT;
            if (op == BinOp::MODULO) node.type = Type::ERROR;
            else node.fval = operate<double>(op, lhs->ival, rhs->ival);
        }
        else if (lhs->type == Type::FLOAT && rhs->type == Type::FLOAT) {
            node.type = Type::FLOAT;
            if (op == BinOp::MODULO) node.type = Type::ERROR;
            else node.fval = operate<double>(op, lhs->ival, rhs->ival);
        }
        else {
            assert(lhs->type == Type::INT && rhs->type == Type::INT);
            node.type = Type::INT;
            if (op == BinOp::MODULO) node.ival = lhs->ival % rhs->ival;
            else node.ival = operate<int>(op, lhs->ival, rhs->ival);
        }
    }
    else node.is_const = false;
    // printf("expr ival: %d\n", node.ival);
    // printf("expr fval: %lf\n", node.fval);
}

void SyntaxTreeChecker::visit(UnaryExpr &node) {
    // TODO: 类型和运算符匹配的检查
    Ptr<Expr> rhs = node.rhs;
    rhs->accept(*this);
    if (rhs->is_const) {
        node.is_const = true;
        node.type = rhs->type;
        if (node.op == UnaryOp::MINUS) {
            node.fval = -rhs->fval;
            node.ival = -rhs->ival;
        }
        else {
            assert(node.op == UnaryOp::PLUS);
            node.fval = rhs->fval;
            node.ival = rhs->ival;
        }
    }
    else {
        node.is_const = false;
    }
}

void SyntaxTreeChecker::visit(LVal &node) {
    PtrVariable ptr = lookup_variable(node.name);
    if (ptr == nullptr) {
        // undefined lval
        err.error(node.loc, ERROR_UNDEFINED_LVAL,
            "undefined left val: \033[4m" + node.name + "\033[0m");
        exit(1);
    }
    ptr->is_used = true;
    node.is_const = ptr->is_const;
    
    size_t index_dim_size = node.array_index.size();
    size_t dim_size = ptr->array_length.size();
    if (index_dim_size > dim_size) {
        if (dim_size == 0) {
            err.error(node.loc, ERROR_NOT_ARRAY, "not an array: \033[4m" + node.name + "\033[0m");
            exit(1);
        }
        err.error(node.loc, ERROR_ARRAY_INDEX_DIM_OUTOF_SIZE, "index dimension outof size");
        exit(1);
    }
    size_t array_size = 1;
    if (dim_size > 0) {
        for (auto i: ptr->array_length) {
            array_size *= i;
        }
        array_size /= ptr->array_length[0];
    }
    size_t index = 0;
    for (size_t i = 0; i < index_dim_size; i++) {
        Ptr<Expr> expr = node.array_index[i];
        expr->accept(*this);
        if (expr->type != Type::INT) {
            err.error(node.loc, ERROR_ARRAY_INDEX_NOT_INT, "index isn't integer.");
            exit(1);
        }
        if (expr->ival < 0 || expr->ival >= ptr->array_length[i]) {
            err.error(node.loc, ERROR_ARRAY_INDEX_OUTOF_BOUND, "index out of bound");
            exit(1);
        }
        index += array_size * expr->ival;
        if (i < dim_size - 1) array_size /= ptr->array_length[i];
        else array_size = 1;
    }
    // printf("squeezed index: %lu\n", index);
    node.type = ptr->type;
    node.fval = ptr->array_value[index].fval;
    node.ival = ptr->array_value[index].ival;
}

void SyntaxTreeChecker::visit(Literal &node) {}

void SyntaxTreeChecker::visit(FuncCallExpr &node) {
    if (!functions.count(node.name)) {
        // undefined function
        err.error(node.loc, ERROR_UNDEFINED_FUNC, "undefined function: \033[4m" + node.name + "\033[0m");
        exit(1);
    }
}

void SyntaxTreeChecker::visit(ReturnStmt &node) {
    // TODO: 暂且认为比如是int, 也可以不返回(c也是这样的)
    node.ret->accept(*this);
    if (node.ret == nullptr) {
        // only return;
        if (ret_type != Type::VOID) {
            err.error(node.loc, WARNING_IMPLICIT_CAST,
                "expect return \033[4m" + Type_to_string(ret_type) + "\033[0m, "
                + "but \033[4m" + Type_to_string(Type::VOID) + "\033[0m returned");
            exit(1);
        }
    }
    else if (ret_type != node.ret->type) {
        // invalid return
        if (ret_type == Type::INT && node.ret->type == Type::FLOAT) {
            node.ret->type = Type::INT;
            node.ret->ival = node.ret->fval;
            err.warn(node.loc, WARNING_IMPLICIT_CAST, "return \033[4mfloat\033[0m as \033[4mint\033[0m");
        }
        else if (ret_type == Type::FLOAT && node.ret->type == Type::INT) {
            node.ret->type = Type::FLOAT;
            node.ret->fval = node.ret->ival;
            err.warn(node.loc, ERROR_INVALID_RETURN, "return \033[4mint\033[0m as \033[4mfloat\033[0m");
        }
        else {
            err.error(node.loc, ERROR_INVALID_RETURN,
                "expect return \033[4m" + Type_to_string(ret_type) + "\033[0m, "
                + "but \033[4m" + Type_to_string(node.ret->type) + "\033[0m returned");
            exit(1);
        }
    }
}

void SyntaxTreeChecker::visit(VarDef &node) {
    PtrVariable ptr = declare_variable(node);
    if (ptr == nullptr) {
        err.error(node.loc, ERROR_REDEFINITION,
            "redefinition of \033[4m" + node.name + "\033[0m");
        exit(1);
    }
    // printf("node %s const: %d\n", node.name.c_str(), node.is_const);
    ptr->is_const = node.is_const;
    size_t dim_size = node.array_length.size();
    // array_length
    for (size_t i = 0; i < dim_size; i++) {
        Ptr<Expr> expr = node.array_length[i];
        expr->accept(*this);
        if (!expr->is_const) {
            // if dynamic size of dimension
            std::stringstream ss;
            ss << i;
            std::string pos;
            ss >> pos;
            err.error(node.loc, ERROR_DYNAMIC_ARRAY_SIZE, 
                "dynamic array size at dimension \033[4m" + pos + "\033[0m");
            exit(1);
        }
        if (expr->type != Type::INT || expr->ival <= 0) {
            err.error(node.loc, ERROR_INVALID_ARRAY_SIZE,
                "invalid array size(the size isn't positive int)");
            exit(1);
        }
        ptr->array_length.push_back(expr->ival);
    }
    
    size_t array_size = 1;
    for (auto i: ptr->array_length) {
        array_size *= i;
    }
    // initialize all to 0
    for (size_t i = 0; i < array_size; i++) {
        ptr->array_value.push_back(Value(node.type, 0, 0));
    }
    if (node.is_inited) {
        // array_value
        size_t init_size = node.initializers.size();
        for (size_t i = 0; i < init_size; i++) {
            Ptr<Expr> expr = node.initializers[i];
            expr->accept(*this);
            if (expr->type != ptr->type) {
                // type error
                if (ptr->type == Type::INT && expr->type == Type::FLOAT) {
                    expr->type = Type::INT;
                    expr->ival = expr->fval;
                    err.warn(node.loc, WARNING_IMPLICIT_CAST, 
                        "cast \033[4mfloat\033[0m to \033[4mint\033[0m");
                }
                else if (ptr->type == Type::FLOAT && expr->type == Type::INT) {
                    expr->type = Type::FLOAT;
                    expr->ival = expr->ival;
                    err.warn(node.loc, WARNING_IMPLICIT_CAST, 
                        "cast \033[4mint\033[0m to \033[4mfloat\033[0m");
                }
                else if (ptr->type != expr->type) {
                    err.error(node.loc, ERROR_CAST,
                        "expect \033[4m" + Type_to_string(ptr->type) + "\033[0m, "
                        + "but \033[4m" + Type_to_string(expr->type) + "\033[0m found");
                    exit(1);
                }
            }
            // printf("expr->fval dim(%lu) %f\n", i,expr->fval);
            // printf("expr->ival dim(%lu) %d\n", i,expr->ival);
            ptr->array_value[i] = Value(expr->type, expr->ival, expr->fval);
        }
    }
}
void SyntaxTreeChecker::visit(AssignStmt &node) {
    node.target->accept(*this);
    node.value->accept(*this);
    if (node.target->is_const) {
        err.error(node.loc, ERROR_CONST_LVAL,
            "const can't be left-var");
        exit(1);
    }
}
void SyntaxTreeChecker::visit(FuncCallStmt &node) {
    node.expr->accept(*this);
}
void SyntaxTreeChecker::visit(BlockStmt &node) {
    enter_scope();
    for (auto stmt: node.body) {
        stmt->accept(*this);
    }
    warn_variable_not_used(node.loc);
    exit_scope();
}
void SyntaxTreeChecker::visit(EmptyStmt &node) {}
