/*
 * rel.lex : Scanner for a simple
 *			 relation expression parser.
 */

%{
#include "pl0.h"
#include <stdio.h>
#include <string.h>
%}

%%

">="		{return(geq);}
">"			{return(gtr);}
"<="		{return(leq);}
"<"			{return(lss);}
"<>"		{return(neq);}
"="			{return(eql);}
[\n]		{return(newline);}
[^>=<\n]+			{
	strcpy(id, yytext);
	return(ident);
}
%%
void getsym()
{
	sym = yylex();
}
