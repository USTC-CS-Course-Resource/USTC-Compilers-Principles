
#include "ErrorReporter.h"


ErrorReporter::ErrorReporter(std::ostream &error_stream) : err(error_stream) {}

void ErrorReporter::error(Position pos, int code, const std::string &msg)
{
    report(pos, code, msg, "Error");
}

void ErrorReporter::warn(Position pos, int code, const std::string &msg)
{
    report(pos, code, msg, "Warning");
}

void ErrorReporter::report(Position pos, int code, const std::string &msg, const std::string &prefix)
{
    #define REPORT
    #ifdef REPORT
    if (prefix.compare("Error") == 0) {
        err << "\033[1;;31m" << prefix << "(" << code << ")\033[0m";
    }
    else if (prefix.compare("Warning") == 0) {
        err << "\033[1;;35m" << prefix << "(" << code << ")\033[0m";
    }
    else {
        err << prefix << "(" << code;
    }
    err << " at position " << pos << ": " << msg << std::endl;
    #else
    #endif
}
