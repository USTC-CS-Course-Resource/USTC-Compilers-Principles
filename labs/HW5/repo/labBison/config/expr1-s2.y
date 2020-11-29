/*
 * expr1.y : A simple yacc expression parser
 *          Based on the Bison manual example. 
 * The parser eliminates conflicts by introducing more nondeterminals.
 */

%{
#include <stdio.h>
#include <math.h>
int yylex();
void yyerror(const char *s);
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
EXPON

%type  <val> exp term item fact
%%
input   :
        | input line
        ;

line    : EOL { printf("\n");}
        | exp EOL { printf(" = %g  at line %d\n",$1, @$.last_line);}

exp     : exp PLUS  term         { $$ = $1 + $3;   }
        | exp MINUS term         { $$ = $1 - $3;   }
        | term                   { $$ = $1;        }
        ;
term    : term MULT item         { $$ = $1 * $3;   }
        | term DIV  item         { $$ = $1 / $3;   }
        | item                   { $$ = $1;        }
        ;
item    : fact EXPON item       { $$ = pow($1, $3); }
        | fact                  { $$ = $1;      }
        ;
fact    : NUMBER                { $$ = $1;        }
        | LB exp RB             { $$ = $2;        }
        | MINUS fact            { $$ = -$2;      }
        ;

%%
void yyerror(const char *message)
{
  printf("%s\n",message);
}

int main(int argc, char *argv[])
{
  yyparse();
  return(0);
}








