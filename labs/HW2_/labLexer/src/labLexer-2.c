#include <stdlib.h>
#include <string.h>
#include "pl0.h"

extern void getsym();

int main(int argc, char *argv[])
{
	extern FILE * yyin;
	yyin=stdin;
	getsym();	
	while (sym) {
		switch(sym) {
		case geq:
			printf("(relop,>=)");
			break;
		case gtr:
			printf("(relop,>)"); break;
		case leq:
			printf("(relop,<=)");
			break;
		case lss:
			printf("(relop,<)"); break;
		case neq:
			printf("(relop,<>)"); break;
		case eql:
			printf("(relop,=)"); break;
		case ident:
			printf("(other,%ld)", strlen(id)); break;
		case newline: goto done;
		}
		getsym();
	}
done:
	putchar('\n');
}
