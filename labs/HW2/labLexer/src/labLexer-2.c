#include <stdlib.h>
#include <string.h>
#include "pl0.h"

#define LINE_SIZE 1024
#define VALUE_SIZE 1024
#define LEXER_UNIT_SIZE 1024
#define true 1
#define false 0

#ifndef LEXERGEN

#define STATE_ERROR -1
#define STATE_START 0
#define STATE_L 1
#define STATE_LE 2
#define STATE_NE 3
#define STATE_MODE2OTHER 4
#define STATE_EQ 5
#define STATE_G 6
#define STATE_GE 7
#define STATE_DOING_OTHER 8
#define STATE_MODE2RELOP 9
#define STATE_DONE 10

char* str_start;
char* str_line_end;
int lexer_next_state(const int cur_state, const char next_c);
int get_relop_macro(const char* relop);
void getsym();
#else
extern void getsym();
#endif

int main(int argc, char *argv[])
{
#ifdef LEXERGEN
	extern FILE * yyin;
	yyin=stdin;
#else
	char str_line[LINE_SIZE] = {0};
	fgets(str_line, LINE_SIZE, stdin);
	if(str_line[LINE_SIZE-1] != 0) {
		fprintf(stderr, "input length out of size\n");
		exit(-1);
	}
	str_start = str_line;
	str_line_end = str_line + strlen(str_line);
#endif
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


#ifndef LEXERGEN
int lexer_next_state(const int cur_state, const char next_c) {
	if (next_c == '\n' || next_c == 0) return STATE_DONE;
	switch (cur_state)
	{
	case STATE_START:
		switch (next_c)
		{
		case '<': return STATE_L;
		case '=': return STATE_EQ;
		case '>': return STATE_G;
		default: return STATE_DOING_OTHER;
		}
		break;
	case STATE_L:
		switch (next_c)
		{
		case '=': return STATE_LE;
		case '>': return STATE_NE;
		default: return STATE_MODE2OTHER;
		}
	case STATE_G:
		switch (next_c)
		{
		case '=': return STATE_GE;
		default: return STATE_MODE2OTHER;
		}
	case STATE_DOING_OTHER: 
		switch (next_c)
		{
		case '<':
		case '=':
		case '>': return STATE_MODE2RELOP;
		default: return STATE_DOING_OTHER;
		}
		break;
	default: return STATE_ERROR;
	}
}

int get_relop_macro(const char* relop) {
	if (!strcmp(relop, ">")) return gtr;
	else if (!strcmp(relop, ">=")) return geq;
	else if (!strcmp(relop, "<")) return lss;
	else if (!strcmp(relop, "<=")) return leq;
	else if (!strcmp(relop, "<>")) return neq;
	else if (!strcmp(relop, "=")) return eql;
	else return -1;
}

void getsym() {
	int cur_state = STATE_START; // state of current processing str
	char *end = str_start; // end pointer of current processing str
	char tmp[32];
	memset(id, 0, sizeof(char)*(al+1));
	memset(tmp, 0, sizeof(char)*(al+1));
	while(str_start <= str_line_end) {
		int next_state = lexer_next_state(cur_state, *end);
		switch (next_state)
		{
		case STATE_ERROR: return;
		case STATE_DONE: 
			switch (cur_state)
			{
			case STATE_DOING_OTHER:
			case STATE_L:
			case STATE_G:
				if (cur_state == STATE_DOING_OTHER) {
					sym = ident;
					strncpy(id, str_start, end-str_start);
					str_start = str_line_end+1;
					return;
				}
				else {
					strncpy(tmp, str_start, end-str_start);
					sym = get_relop_macro(tmp);
					str_start = str_line_end+1;
					return;
				}
			default:
				break;
			}
			break;
		case STATE_MODE2RELOP:
			// mode to relop, meaning finish reading of `other`
			sym = ident;
			strncpy(id, str_start, end-str_start);
			str_start = end;
			return;
		case STATE_LE:
		case STATE_NE:
		case STATE_EQ:
		case STATE_GE:
			strncpy(tmp, str_start, end-str_start+1);
			sym = get_relop_macro(tmp);
			str_start = end + 1;
			return;
		case STATE_MODE2OTHER:
			strncpy(tmp, str_start, end-str_start);
			sym = get_relop_macro(tmp);
			str_start = end;
			return;
		case STATE_DOING_OTHER:
		case STATE_L:
		case STATE_G:
			end++;
			cur_state = next_state; break;
		default:
			return;
		}
	}
	sym = 0;
	return;
}
#endif