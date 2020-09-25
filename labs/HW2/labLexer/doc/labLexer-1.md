# Lab Lexer-1

## Usage of CMake

The simplest usage `cmake` is add the following into `CMakeLists.txt`
```CMake
project(labLexer-1)
add_executable(${PROJECT_NAME} src/labLexer-1.c)
```
Here `project(labLexer-1)` indicating the name of the project, while the `add_executable(${PROJECT_NAME} src/labLexer-1.c)` means generate the executable by `src/labLexer-1.c`
