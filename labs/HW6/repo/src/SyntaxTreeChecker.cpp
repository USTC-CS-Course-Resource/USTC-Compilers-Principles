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
        err.error(node.loc, WARN_NOMAIN, "\033[4mmain\033[0m function isn't defined.");
        exit(1);
    }
}

void SyntaxTreeChecker::visit(FuncDef &node) {
    if (node.name == "main" && (node.ret_type == Type::VOID
        || node.ret_type == Type::FLOAT)) {
            err.error(node.loc, ERROR_MAIN_NOT_RETURN_INT, "main not return int");
            exit(1);
        }
    if (!declare_function(node)) {
        err.error(node.loc, ERROR_FUNCTION_REDEFINITION,
            "redefinition of \033[4m" + node.name + "\033[0m");
        exit(1);
    }
    ret_type = node.ret_type;
    is_returned = false;
    node.body->accept(*this);
    if (!is_returned && ret_type != Type::VOID) {
        err.warn(node.loc, WARN_NO_RETURN,
            "no return for \033[4m" + node.name + "\033[0m");
    }
}
 
void SyntaxTreeChecker::visit(BinaryExpr &node) {
    BinOp op = node.op;
    Ptr<Expr> lhs = node.lhs;
    Ptr<Expr> rhs = node.rhs;
    lhs->accept(*this);
    rhs->accept(*this);
    if (lhs->type == Type::VOID) {
        err.error(node.loc, ERROR_OPERATE_VOID, "operating a void lhs");
        exit(1);
    }
    if (rhs->type == Type::VOID) {
        err.error(node.loc, ERROR_OPERATE_VOID, "operating a void rhs");
        exit(1);
    }
    if (lhs->is_const && node.rhs->is_const) {
        node.is_const = true;
        if (lhs->type == Type::ERROR || rhs->type == Type::ERROR) {
            node.type = Type::ERROR;
        }
        else if (lhs->type == Type::VOID || rhs->type == Type::VOID) {
            node.type = Type::VOID;
            err.error(node.loc, ERROR_OPERATE_VOID, "operating void");
            exit(1);
        }
        else if (lhs->type == Type::FLOAT && rhs->type == Type::INT) {
            node.type = Type::FLOAT;
            if (op == BinOp::MODULO) node.type = Type::ERROR;
            else node.fval = operate<double>(op, lhs->fval, rhs->ival);
        }
        else if (lhs->type == Type::INT && rhs->type == Type::FLOAT) {
            node.type = Type::FLOAT;
            if (op == BinOp::MODULO) node.type = Type::ERROR;
            else node.fval = operate<double>(op, lhs->ival, rhs->fval);
        }
        else if (lhs->type == Type::FLOAT && rhs->type == Type::FLOAT) {
            node.type = Type::FLOAT;
            if (op == BinOp::MODULO) node.type = Type::ERROR;
            else node.fval = operate<double>(op, lhs->fval, rhs->fval);
        }
        else {
            assert(lhs->type == Type::INT && rhs->type == Type::INT);
            node.type = Type::INT;
            if (op == BinOp::MODULO) node.ival = lhs->ival % rhs->ival;
            else node.ival = operate<int>(op, lhs->ival, rhs->ival);
        }
    }
    else node.is_const = false;
    if (node.type == Type::ERROR) {
        err.error(node.loc, ERROR_MODULO_FLOAT,
            "modulo can't be used for float");
        exit(1);
    }
}

void SyntaxTreeChecker::visit(UnaryExpr &node) {
    // TODO: 类型和运算符匹配的检查
    Ptr<Expr> rhs = node.rhs;
    rhs->accept(*this);
    node.is_const = rhs->is_const;
    if (rhs->type != Type::INT && rhs->type != Type::FLOAT) {
        err.error(node.loc, ERROR_UNARY_TO_VOID,
            "unary ops(+,-) can only be used for integer or float");
        exit(1);
    }
    if (node.is_const) {
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
    if (index_dim_size != dim_size) {
        if (dim_size == 0) {
            err.error(node.loc, ERROR_NOT_ARRAY, "not an array: \033[4m" + node.name + "\033[0m");
            exit(1);
        }
        err.error(node.loc, ERROR_ARRAY_INDEX_DIM_CANNOT_MATCH, "array index dimentsion can't match");
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
    node.type = functions[node.name];
    if (node.name == "main") {
        err.error(node.loc, ERROR_UNDEFINED_FUNC, "\033[4mmain\033[0m function can't be called");
        exit(1);
    }
}

void SyntaxTreeChecker::visit(ReturnStmt &node) {
    // TODO: 暂且认为比如是int, 也可以不返回(c也是这样的)
    is_returned = true;
    if (node.ret == nullptr) {
        // only return;
        if (ret_type != Type::VOID) {
            err.error(node.loc, WARN_IMPLICIT_CAST,
                "expect return \033[4m" + Type_to_string(ret_type) + "\033[0m, "
                + "but \033[4m" + Type_to_string(Type::VOID) + "\033[0m returned");
            exit(1);
        }
    }
    else {
        node.ret->accept(*this);
            if (ret_type != node.ret->type) {
            // invalid return
            if (ret_type == Type::INT && node.ret->type == Type::FLOAT) {
                node.ret->type = Type::INT;
                node.ret->ival = node.ret->fval;
                err.warn(node.loc, WARN_IMPLICIT_CAST, "return \033[4mfloat\033[0m as \033[4mint\033[0m");
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
}

void SyntaxTreeChecker::visit(VarDef &node) {
    PtrVariable ptr = declare_variable(node);
    if (ptr == nullptr) {
        err.error(node.loc, ERROR_VARIABLE_REDEFINITION, "redefinition of \033[4m" + node.name + "\033[0m");
        exit(1);
    }
    
    ptr->is_const = node.is_const;
    size_t dim_size = node.array_length.size();
    // set array_length. for int/float, it is an empty vector
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
    // get array_size
    size_t array_size = 1;
    for (auto i: ptr->array_length) {
        array_size *= i;
    }
    // initialize all to 0
    for (size_t i = 0; i < array_size; i++) {
        ptr->array_value.push_back(Value(node.type, 0, 0));
    }
    // if need init, update array_value
    if (node.is_inited) {
        // array_value
        size_t init_size = node.initializers.size();
        if (array_size < init_size) {
            err.error(node.loc, ERROR_TOO_MANY_INITIALIZER,
                "too many initializers for \033[4m" + node.name + "\033[0m");
            exit(1);
        }
        for (size_t i = 0; i < init_size; i++) {
            Ptr<Expr> expr = node.initializers[i];
            expr->accept(*this);
            if (node.is_const && !expr->is_const) {
                // init const with non-const
                err.error(node.loc, ERROR_INIT_CONST_WITH_NONCONST,
                    "initiate \033[4m" + node.name + "\033[0m with non-const");
                exit(1);
            }
            if (expr->type != ptr->type) {
                // type error
                if (ptr->type == Type::INT && expr->type == Type::FLOAT) {
                    expr->type = Type::INT;
                    expr->ival = expr->fval;
                    err.warn(node.loc, ERROR_CAST, 
                        "cast \033[4mfloat\033[0m to \033[4mint\033[0m when initializing");
                }
                else if (ptr->type == Type::FLOAT && expr->type == Type::INT) {
                    expr->type = Type::FLOAT;
                    expr->ival = expr->ival;
                    err.warn(node.loc, WARN_IMPLICIT_CAST, 
                        "cast \033[4mint\033[0m to \033[4mfloat\033[0m");
                }
                else if (ptr->type != expr->type) {
                    err.error(node.loc, ERROR_CAST,
                        "can't cast \033[4m" + Type_to_string(expr->type) + "\033[0m to \033[4m"
                        + Type_to_string(ptr->type) + "\033[0m");
                    exit(1);
                }
            }
            ptr->array_value[i] = Value(expr->type, expr->ival, expr->fval);
        }
    }
    // printf("%s fval: %lf\n", ptr->name.c_str(), ptr->array_value[0].fval);
    // printf("%s ival: %d\n", ptr->name.c_str(), ptr->array_value[0].ival);
}
void SyntaxTreeChecker::visit(AssignStmt &node) {
    node.target->accept(*this);
    node.value->accept(*this);
    if (node.target->is_const) {
        err.error(node.loc, ERROR_CONST_LVAL, "const can't be left-var");
        exit(1);
    }
    if (node.value->type != Type::INT && node.value->type != Type::FLOAT)  {
        err.error(node.loc, ERROR_CONST_LVAL, "the value isn't valid oprand");
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
