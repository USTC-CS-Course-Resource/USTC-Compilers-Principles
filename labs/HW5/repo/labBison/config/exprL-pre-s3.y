/*
 * exprL-pre-s3.y : A simple yacc expression parser
 *          Based on the Bison manual example. 
 * You need add rules with actions to complete the conversion 
 * from infix expression to corresponding Polish expression.
 */

%{
#include <stdio.h>
#include <math.h>
#include <string.h>
#define STACK_SIZE 1024
#define EXP_SIZE 1024

int yylex();
void yyerror(const char *s);
int lineno = 0;
char** expstack;
char** expstack_top;
char exp_str[EXP_SIZE];
%}

%union {
  float val;
  char *op;
}
%locations

%token <val> NUMBER
%token <op> PLUS MINUS MULT DIV EXPON
%token EOL
%token LB RB

%left  MINUS PLUS
%left  MULT DIV
%right EXPON
%right UMINUS

%type  <val> exp

%%
input   :                                       { lineno ++;}
        | input
	                                            { 
                                                    printf("Line %d:\n\t", lineno++);
                                                }
          line
        ;

line    : EOL			                        { printf("\n");}
        | exp EOL 		                        { printf("%s = ", *expstack_top); printf("%g at line %d\n",$1, @1.last_line); expstack_top = expstack-1;}
        ;
exp     : NUMBER                                { $$ = $1;
                                                    expstack_top++; sprintf(*expstack_top, "%g ", $1);
                                                }
        | exp PLUS                              { expstack_top++; sprintf(*(expstack_top), " + "); }
          exp                                   { $$ = $1 + $4;
                                                    sprintf(exp_str, "%s%s%s", *(expstack_top-1), *(expstack_top-2), *(expstack_top)); expstack_top -=2; 
                                                    strcpy(*(expstack_top), exp_str);
                                                }
        | exp MINUS                             { expstack_top++; sprintf(*(expstack_top), " - "); }
          exp                                   { $$ = $1 - $4;
                                                    sprintf(exp_str, "%s%s%s", *(expstack_top-1), *(expstack_top-2), *(expstack_top)); expstack_top -=2; 
                                                    strcpy(*(expstack_top), exp_str);
                                                }
        | exp MULT                              { expstack_top++; sprintf(*(expstack_top), " * "); }
          exp                                   { $$ = $1 * $4;
                                                    sprintf(exp_str, "%s%s%s", *(expstack_top-1), *(expstack_top-2), *(expstack_top)); expstack_top -=2;
                                                    strcpy(*(expstack_top), exp_str); 
                                                }
        | exp DIV                               { expstack_top++; sprintf(*(expstack_top), " / "); }
          exp                                   { $$ = $1 / $4;
                                                    sprintf(exp_str, "%s%s%s", *(expstack_top-1), *(expstack_top-2), *(expstack_top)); expstack_top -=2; 
                                                    strcpy(*(expstack_top), exp_str);
                                                }
        | MINUS                                 { expstack_top++; sprintf(*(expstack_top), " - "); }
          exp %prec UMINUS                      { $$ = -$3;
                                                    sprintf(exp_str, "%s%s", *(expstack_top-1), *(expstack_top)); expstack_top -=1; 
                                                    strcpy(*(expstack_top), exp_str);
                                                }
        | exp EXPON                             { expstack_top++; sprintf(*(expstack_top), " ** "); }
          exp                                   { $$ = pow($1,$4);
                                                    sprintf(exp_str, "%s%s%s", *(expstack_top-1), *(expstack_top-2), *(expstack_top)); expstack_top -=2; 
                                                    strcpy(*(expstack_top), exp_str);
                                                }
        | LB exp RB                             { $$ = $2;}
        ;

%%

void yyerror(const char *message)
{
  printf("%s\n",message);
}

int main(int argc, char *argv[])
{ 
    expstack = (char**)malloc(STACK_SIZE * sizeof(char**));
    for (int i = 0; i < STACK_SIZE; i++) {
        expstack[i] = (char*)malloc(128*sizeof(char));
    }

    expstack_top = expstack - 1;
    yyparse();

    for (int i = 0; i < STACK_SIZE; i++) {
        free(expstack[i]);
    }
    free(expstack);
    return(0);
}

