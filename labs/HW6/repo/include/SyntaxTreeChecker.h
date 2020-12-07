#ifndef _C1_SYNTAX_TREE_CHECKER_H_
#define _C1_SYNTAX_TREE_CHECKER_H_

#include "SyntaxTree.h"
#include "ErrorReporter.h"
#include "location.hh"
#include <cassert>

class SyntaxTreeChecker : public SyntaxTree::Visitor
{
public:
    SyntaxTreeChecker(ErrorReporter &e) : err(e) {
        ret_type = Type::ERROR;
    }
    virtual void visit(SyntaxTree::Assembly &node) override;
    virtual void visit(SyntaxTree::FuncDef &node) override;
    virtual void visit(SyntaxTree::BinaryExpr &node) override;
    virtual void visit(SyntaxTree::UnaryExpr &node) override;
    virtual void visit(SyntaxTree::LVal &node) override;
    virtual void visit(SyntaxTree::Literal &node) override;
    virtual void visit(SyntaxTree::FuncCallExpr &node) override;
    virtual void visit(SyntaxTree::ReturnStmt &node) override;
    virtual void visit(SyntaxTree::VarDef &node) override;
    virtual void visit(SyntaxTree::AssignStmt &node) override;
    virtual void visit(SyntaxTree::FuncCallStmt &node) override;
    virtual void visit(SyntaxTree::BlockStmt &node) override;
    virtual void visit(SyntaxTree::EmptyStmt &node) override;
private:
    using Type = SyntaxTree::Type;
    template <typename T>
    using Ptr = std::shared_ptr<T>;

    struct Value
    {
        Type type;
        int ival;
        double fval;

        Value() = default;
        Value(Type type, int ival, double fval): type(type), ival(ival), fval(fval) {}
    };
    
    struct Variable
    {
        bool is_const;
        Type type;
        bool is_used;
        std::string name;
        std::vector<int> array_length;  // for int or float, array_length.size() == 0
        std::vector<Value>array_value;

        Variable() = default;
        Variable(bool is_const, Type type, std::string name) 
            : is_const(is_const), type(type), is_used(false), name(name) {}
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

    PtrVariable declare_variable(SyntaxTree::VarDef &node)
    {
        assert(!variables.empty());
        PtrVariable ptr = variables.front()[node.name];
        if (ptr != nullptr) return nullptr;
        ptr = PtrVariable(new Variable(node.is_const, node.type, node.name));
        variables.front()[node.name] = ptr;
        return ptr;
    }

    bool declare_function(SyntaxTree::FuncDef &node)
    {
        // assert(!functions.empty());
        if (functions.count(node.name)) return false;
        functions[node.name] = node.ret_type;
        return true;
    }

    std::deque<std::unordered_map<std::string, PtrVariable>> variables;
    std::unordered_map<std::string, SyntaxTree::Type> functions;

    Type ret_type;
    bool is_returned;

    ErrorReporter &err;

    std::string Type_to_string(Type t) {
        if (t == Type::INT) return "int";
        else if (t == Type::FLOAT) return "float";
        else if (t == Type::VOID) return "void";
        else return "error";
    }
    
    void warn_variable_not_used(yy::location loc) {
        for (auto variable: variables.front()) {
            if (!variable.second->is_used) {
                err.warn(loc, WARN_VARIABLE_NOT_USED,
                    "variable \033[4m" + variable.second->name + "\033[0m wasn't used");
            }
        }
    }
};

#endif  // _C1_SYNTAX_TREE_CHECKER_H_
