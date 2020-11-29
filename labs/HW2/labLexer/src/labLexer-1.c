#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define LINE_SIZE 1024
#define VALUE_SIZE 1024
#define LEXER_UNIT_SIZE 1024
#define true 1
#define false 0

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

typedef enum TOKEN {
	TOKEN_other=0, TOKEN_relop=1
} TOKEN;
const char *Token_Names[] = {"other", "relop"};

typedef struct LexerUnit {
	TOKEN token;
	char value[VALUE_SIZE];
} LexerUnit;

int relop_lexer(char *str_line, LexerUnit *lexer_units);
int lexer_next_state(int cur_state, char next_c);
int print_lexer_units(LexerUnit *lu, int n);

int other_cnt = 0;

int main() {
	char str_line[LINE_SIZE] = {0};
	fgets(str_line, LINE_SIZE, stdin);
	if(str_line[LINE_SIZE-1] != 0) {
		fprintf(stderr, "input length out of size\n");
		exit(-1);
	}
	LexerUnit lexer_units[LEXER_UNIT_SIZE];
	int u_cnt = relop_lexer(str_line, lexer_units);
	print_lexer_units(lexer_units, u_cnt);
}

int relop_lexer(char *str_line, LexerUnit *lexer_units) {
	int str_line_size = strlen(str_line);
	char *str_line_end = str_line + str_line_size;
	int cur_state = STATE_START; // state of current processing str
	char *start = str_line; // start pointer of current processing str
	char *end = str_line; // end pointer of current processing str
	int u_cnt = 0; // units counter
	while(end <= str_line_end) {
		int next_state = lexer_next_state(cur_state, *end);
		switch (next_state)
		{
		case STATE_ERROR: return STATE_ERROR;
		case STATE_DONE: 
			switch (cur_state)
			{
			case STATE_DOING_OTHER:
			case STATE_L:
			case STATE_G:
				if (cur_state == STATE_DOING_OTHER) {
					lexer_units[u_cnt].token = TOKEN_other;
					sprintf(lexer_units[u_cnt].value, "%ld", end-start);
				}
				else {
					lexer_units[u_cnt].token = TOKEN_relop;
					strncpy(lexer_units[u_cnt].value, start, end-start);
				}
				u_cnt++;
			default:
				end = str_line_end+1;
				break;
			}
			break;
		case STATE_MODE2RELOP:
			// mode to relop, meaning finish reading of `other`
			lexer_units[u_cnt].token = TOKEN_other;
			// strncpy(lexer_units[u_cnt].value, start, end-start);
			sprintf(lexer_units[u_cnt].value, "%ld", end-start);
			u_cnt++;
			start = end;
			cur_state = STATE_START; break;
		case STATE_LE:
		case STATE_NE:
		case STATE_EQ:
		case STATE_GE:
			lexer_units[u_cnt].token = TOKEN_relop;
			strncpy(lexer_units[u_cnt].value, start, end-start+1);
			start = ++end;
			u_cnt++;
			cur_state = STATE_START; break;
		case STATE_MODE2OTHER:
			lexer_units[u_cnt].token = TOKEN_relop;
			strncpy(lexer_units[u_cnt].value, start, end-start);
			start = end;
			u_cnt++;
			cur_state = STATE_START; break;
		case STATE_DOING_OTHER:
		case STATE_L:
		case STATE_G:
			end++;
			cur_state = next_state; break;
		default:
			return -1;
			break;
		}
	}
	return u_cnt;
}

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

int print_lexer_units(LexerUnit *lu, int n) {
	for(int i = 0; i < n; i++) {
		printf("(%s,%s)", Token_Names[lu[i].token], lu[i].value);
	}
	putchar('\n');
}