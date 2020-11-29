#include <iostream>
#include "antlr4-runtime.h"
#include "rel.h"

#define LINE_SIZE 1024

using namespace antlr4;
using namespace std;

int main(int argc, const char* argv[]) {
    char str_line[LINE_SIZE];
    cin.getline(str_line, LINE_SIZE);
    ANTLRInputStream input(str_line);
    //ANTLRInputStream input("\n\n\n");
    rel lexer(&input);
    CommonTokenStream tokens(&lexer);

    tokens.fill();
    for (auto token : tokens.getTokens()) {
        int type = token->getType();
        if (type == -1) {
            // EOF
            break;
        }
        else if (type >=1 && type <= 6) {
            std::cout << "(relop," << token->getText() << ")";
        }
        else if(type == 7) {
            std::cout << "(other," 
                << token->getText().length() <<")";
        }
    }
    std::cout << std::endl;
    return 0;
}
