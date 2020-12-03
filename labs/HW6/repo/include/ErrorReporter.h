
#ifndef _C1_ERROR_REPORTER_H_
#define _C1_ERROR_REPORTER_H_

#include <iostream>
#include <deque>
#include <unordered_map>
#include <vector>
#include "SyntaxTree.h"

#define ERROR_REDEFINITION 1
#define ERROR_UNDEFINED_LVAL 2
#define ERROR_UNDEFINED_FUNC 3
#define ERROR_INVALID_RETURN 4
#define ERROR_ARRAY_SIZE 6
#define ERROR_ARRAY_INDEX 7
#define ERROR_ARRAY_INDEX_DIM_OUTOF_SIZE 8
#define ERROR_ARRAY_INDEX_OUTOF_BOUND 9
#define ERROR_CAST 11
#define ERROR_INVALID_ARRAY_SIZE 12
#define ERROR_DYNAMIC_ARRAY_SIZE 13
#define ERROR_CONST_LVAL 14

#define WARN_NOMAIN 5
#define WARNING_IMPLICIT_CAST 10

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
