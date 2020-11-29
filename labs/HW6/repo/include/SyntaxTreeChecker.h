#ifndef _C1_SYNTAX_TREE_CHECKER_H_
#define _C1_SYNTAX_TREE_CHECKER_H_

#include "SyntaxTree.h"
#include "ErrorReporter.h"
#include <cassert>

class SyntaxTreeChecker : public SyntaxTree::Visitor
{
public:
    SyntaxTreeChecker(ErrorReporter &e) : err(e) {}
    virtual void visit(SyntaxTree::Assembly &node) override;
    virtual void visit(SyntaxTree::FuncDef &node) override;
    virtual void visit(SyntaxTree::BinaryExpr &node) override;
    virtual void visit(SyntaxTree::UnaryExpr &node) override;
    virtual void visit(SyntaxTree::LVal &node) override;
    virtual void visit(SyntaxTree::Literal &node) override;
    virtual void visit(SyntaxTree::ReturnStmt &node) override;
    virtual void visit(SyntaxTree::VarDef &node) override;
    virtual void visit(SyntaxTree::AssignStmt &node) override;
    virtual void visit(SyntaxTree::FuncCallStmt &node) override;
    virtual void visit(SyntaxTree::BlockStmt &node) override;
    virtual void visit(SyntaxTree::EmptyStmt &node) override;
private:
    using Type = SyntaxTree::Type;
    struct Variable
    {
        bool is_const;
        Type btype;
        std::vector<int> array_length;

        Variable() = default;
        Variable(bool is_const, Type btype, std::vector<int> array_length) 
            : is_const(is_const), btype(btype), array_length(array_length) {}
    };
    using PtrVariable = std::shared_ptr<Variable>;
    
    void enter_scope() { variables.emplace_front(); }

    void exit_scope() { variables.pop_front(); }

    PtrVariable lookup_variable(std::string name)
    {
        for (auto m : variables)
            if (m.count(name))
                return m[name];
        return nullptr;
    }

    bool declare_variable(std::string name, bool is_const, Type btype, std::vector<int> array_length)
    {
        assert(!variables.empty());
        if (variables.front().count(name))
            return false;
        variables.front()[name] = PtrVariable(new Variable(is_const, btype, array_length));
        return true;
    }

    std::deque<std::unordered_map<std::string, PtrVariable>> variables;

    std::unordered_map<std::string, SyntaxTree::Type> functions;

    ErrorReporter &err;
};

#endif  // _C1_SYNTAX_TREE_CHECKER_H_
