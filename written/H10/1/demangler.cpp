#include <cxxabi.h>
#include <iostream>
#include <fstream>

using namespace std;

string demangle(string name) {
    int status;
    char *demangled = abi::__cxa_demangle(name.c_str(), 0, 0, &status);
    string ret = string(demangled);
    free(demangled);
    return ret;
}

int main(int argc, char** argv) {
    string name;
    ifstream ifs(argv[1], ios::in);
    while (ifs >> name) {
        cout << name << "\n\t" << demangle(name) << endl;
    }
}
