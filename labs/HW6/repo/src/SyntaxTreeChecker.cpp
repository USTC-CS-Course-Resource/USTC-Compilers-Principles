#include "SyntaxTreeChecker.h"

using namespace SyntaxTree;

void SyntaxTreeChecker::visit(Assembly &node)
{
    enter_scope();
    for (auto def : node.global_defs) {
        def->accept(*this);
    }
    exit_scope();
}

void SyntaxTreeChecker::visit(FuncDef &node) {}
void SyntaxTreeChecker::visit(BinaryExpr &node) {}
void SyntaxTreeChecker::visit(UnaryExpr &node) {}
void SyntaxTreeChecker::visit(LVal &node) {}
void SyntaxTreeChecker::visit(Literal &node) {}
void SyntaxTreeChecker::visit(ReturnStmt &node) {}
void SyntaxTreeChecker::visit(VarDef &node)
{
    if (declare_variable(node.name, node.is_constant, node.btype, std::vector<int>()))
        ;
    else {
        err.error(node.loc, "redefinition of " + node.name);
        exit(1);
    }
}
void SyntaxTreeChecker::visit(AssignStmt &node) {}
void SyntaxTreeChecker::visit(FuncCallStmt &node) {}
void SyntaxTreeChecker::visit(BlockStmt &node) {}
void SyntaxTreeChecker::visit(EmptyStmt &node) {}

