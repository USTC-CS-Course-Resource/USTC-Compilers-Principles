
#ifndef _C1_ERROR_REPORTER_H_
#define _C1_ERROR_REPORTER_H_

#include <iostream>
#include <deque>
#include <unordered_map>
#include <vector>
#include "SyntaxTree.h"

#define ERROR_VARIABLE_REDEFINITION         1
#define ERROR_FUNCTION_REDEFINITION         2
#define ERROR_UNDEFINED_LVAL                3
#define ERROR_UNDEFINED_FUNC                4
#define ERROR_INVALID_RETURN                5
#define ERROR_INVALID_ARRAY_SIZE            6
#define ERROR_ARRAY_INDEX_DIM_CANNOT_MATCH  7
#define ERROR_ARRAY_INDEX_OUTOF_BOUND       8
#define ERROR_CAST                          9
#define ERROR_DYNAMIC_ARRAY_SIZE            10
#define ERROR_CONST_LVAL                    11
#define ERROR_ARRAY_INDEX_NOT_INT           12
#define ERROR_NOT_ARRAY                     13
#define ERROR_OPERATE_VOID                  14
#define ERROR_MAIN_NOT_RETURN_INT           15
#define ERROR_INIT_CONST_WITH_NONCONST      16
#define ERROR_MODULO_FLOAT                  17
#define ERROR_TOO_MANY_INITIALIZER          22
#define ERROR_UNARY_TO_VOID                 23
#define ERROR_ARRAY_ASSIGN                  24


#define WARN_NOMAIN                         18
#define WARN_IMPLICIT_CAST                  19
#define WARN_VARIABLE_NOT_USED              20
#define WARN_NO_RETURN                      21

class ErrorReporter
{
public:
    using Position = SyntaxTree::Position;
    ErrorReporter(std::ostream &error_stream);

    void error(Position pos, int code, const std::string &msg);
    void warn(Position pos, int code, const std::string &msg);

protected:
    virtual void report(Position pos, int code, const std::string &msg, const std::string &prefix);

private:
    std::ostream &err;
};

#endif  // _C1_ERROR_REPORTER_H_
