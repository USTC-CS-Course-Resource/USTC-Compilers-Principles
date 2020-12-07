%skeleton "lalr1.cc" /* -*- c++ -*- */
%require "3.0"
%defines
%define parser_class_name {C1Parser}

%define api.token.constructor
%define api.value.type variant
%define parse.assert

%code requires
{
#include <string>
#include "SyntaxTree.h"
#include "ErrorReporter.h"
class C1Driver;
}

// The parsing context.
%param { C1Driver& driver }

// Location tracking
%locations
%initial-action
{
// Initialize the initial location.
@$.begin.filename = @$.end.filename = &driver.file;
};

// Enable tracing and verbose errors (which may be wrong!)
%define parse.trace
%define parse.error verbose

// Parser needs to know about the driver:
%code
{
#include "C1Driver.h"
#define yylex driver.lexer.yylex
}

// Tokens:
%define api.token.prefix {TOK_}

%token END
%token ERROR 258 PLUS 259 MINUS 260 MULTIPLY 261 DIVIDE 262 MODULO 263 LTE 264
%token GT 265 GTE 266 EQ 267 NEQ 268 ASSIGN 269 SEMICOLON 270 
%token COMMA 271 LPARENTHESE 272 RPARENTHESE 273 LBRACKET 274 
%token RBRACKET 275 LBRACE 276 RBRACE 277 ELSE 278 IF 279
%token INT 280 RETURN 281 VOID 282 WHILE 283 
%token <std::string>IDENTIFIER 284
%token <float>FLOATCONST 285
%token <int>INTCONST 286
%token LETTER 287 EOL 288 COMMENT 289 
%token BLANK 290 CONST 291 BREAK 292 CONTINUE 293 NOT 294
%token AND 295 OR 296 MOD 297
%token FLOAT 298

// Use variant-based semantic values: %type and %token expect genuine types

%type <SyntaxTree::Assembly*>CompUnit
%type <SyntaxTree::PtrList<SyntaxTree::GlobalDef>>GlobalDecl
%type <SyntaxTree::PtrList<SyntaxTree::VarDef>>ConstDecl
%type <SyntaxTree::PtrList<SyntaxTree::VarDef>>ConstDefList
%type <SyntaxTree::Type>DefType
%type <SyntaxTree::VarDef*>ConstDef
%type <SyntaxTree::PtrList<SyntaxTree::VarDef>>VarDecl
%type <SyntaxTree::PtrList<SyntaxTree::VarDef>>VarDefList
%type <SyntaxTree::VarDef*>VarDef
%type <SyntaxTree::PtrList<SyntaxTree::Expr>>ArrayExpList
%type <SyntaxTree::PtrList<SyntaxTree::Expr>>InitVal
%type <SyntaxTree::PtrList<SyntaxTree::Expr>>ExpList
%type <SyntaxTree::FuncDef*>FuncDef
%type <SyntaxTree::BlockStmt*>Block
%type <SyntaxTree::PtrList<SyntaxTree::Stmt>>BlockItemList
%type <SyntaxTree::PtrList<SyntaxTree::Stmt>>BlockItem
%type <SyntaxTree::Stmt*>Stmt
%type <SyntaxTree::Expr*>OptionRet
%type <SyntaxTree::LVal*>LVal
%type <SyntaxTree::Expr*>Exp
%type <SyntaxTree::Literal*>Number

// No %destructors are needed, since memory will be reclaimed by the
// regular destructors.
/* %printer { yyoutput << $$; } <*>; TODO:trace_parsing*/   

// Grammar:
%start Begin 

%%
Begin: CompUnit END {
    $1->loc = @$;
    driver.root = $1;
    return 0;
  }
  ;

CompUnit:CompUnit GlobalDecl{
		$1->global_defs.insert($1->global_defs.end(), $2.begin(), $2.end());
		$$=$1;
	} 
	| GlobalDecl{
		$$=new SyntaxTree::Assembly();
		$$->global_defs.insert($$->global_defs.end(), $1.begin(), $1.end());
  }
	;

GlobalDecl:ConstDecl{
    $$=SyntaxTree::PtrList<SyntaxTree::GlobalDef>();
    $$.insert($$.end(), $1.begin(), $1.end());
  }
	| VarDecl{
    $$=SyntaxTree::PtrList<SyntaxTree::GlobalDef>();
    $$.insert($$.end(), $1.begin(), $1.end());
  }
  | FuncDef{
    $$=SyntaxTree::PtrList<SyntaxTree::GlobalDef>();
    $$.push_back(SyntaxTree::Ptr<SyntaxTree::GlobalDef>($1));
  }
	;

ConstDecl:CONST DefType ConstDefList SEMICOLON{
    $$=$3;
    for (auto &node : $$) {
      node->type = $2;
    }
  }
	;
ConstDefList:ConstDefList COMMA ConstDef{
    $1.push_back(SyntaxTree::Ptr<SyntaxTree::VarDef>($3));
    $$=$1;
  }
	| ConstDef{
    $$=SyntaxTree::PtrList<SyntaxTree::VarDef>();
    $$.push_back(SyntaxTree::Ptr<SyntaxTree::VarDef>($1));
  }
	;

DefType:INT{
    $$=SyntaxTree::Type::INT;
  }
  | FLOAT{
    $$=SyntaxTree::Type::FLOAT;
  }
  | VOID{
    $$ = SyntaxTree::Type::VOID;
  }
  ;

ConstDef:IDENTIFIER ASSIGN Exp{
    $$=new SyntaxTree::VarDef();
    $$->is_const = true;
    $$->is_inited = true;
    $$->name=$1;
    $$->initializers.push_back(SyntaxTree::Ptr<SyntaxTree::Expr>($3));
    $$->loc = @$;
  }
	;

VarDecl:DefType VarDefList SEMICOLON{
    $$=$2;
    for (auto &node : $$) {
      node->type = $1;
    }
  }
	;

VarDefList:VarDefList COMMA VarDef{
    $1.push_back(SyntaxTree::Ptr<SyntaxTree::VarDef>($3));
    $$=$1;
  }
	| VarDef{
    $$=SyntaxTree::PtrList<SyntaxTree::VarDef>();
    $$.push_back(SyntaxTree::Ptr<SyntaxTree::VarDef>($1));
  }
	;

VarDef:IDENTIFIER ArrayExpList{
    $$=new SyntaxTree::VarDef();
    $$->name=$1;
    $$->array_length = $2;
    $$->is_inited = false;
    $$->loc = @$;
  }
	| IDENTIFIER ArrayExpList ASSIGN InitVal{
    $$ = new SyntaxTree::VarDef();
    $$->name = $1;
    $$->array_length = $2;
    $$->initializers = $4;
    $$->is_inited = true;
    $$->loc = @$;
  }
	;

ArrayExpList:ArrayExpList LBRACKET Exp RBRACKET{
    $1.push_back(SyntaxTree::Ptr<SyntaxTree::Expr>($3));
    $$=$1;
  }
	| %empty{
    $$=SyntaxTree::PtrList<SyntaxTree::Expr>();
  }
  ;

InitVal: Exp{
    $$=SyntaxTree::PtrList<SyntaxTree::Expr>();
    $$.push_back(SyntaxTree::Ptr<SyntaxTree::Expr>($1));
  }
  | LBRACE ExpList RBRACE{
    $$ = $2;
  }
  ;

ExpList:ExpList COMMA Exp{
    $1.push_back(SyntaxTree::Ptr<SyntaxTree::Expr>($3));
    $$ = $1;
  }
  | Exp{
    $$ = SyntaxTree::PtrList<SyntaxTree::Expr>();
    $$.push_back(SyntaxTree::Ptr<SyntaxTree::Expr>($1));
  }
  | %empty{
    $$ = SyntaxTree::PtrList<SyntaxTree::Expr>();
  }
	;

FuncDef:DefType IDENTIFIER LPARENTHESE RPARENTHESE Block{
    $$ = new SyntaxTree::FuncDef();
    $$->ret_type = $1;
    $$->name = $2;
    $$->body = SyntaxTree::Ptr<SyntaxTree::BlockStmt>($5);
    $$->loc = @$;
  }
  ;

Block:LBRACE BlockItemList RBRACE{
    $$ = new SyntaxTree::BlockStmt();
    $$->body = $2;
    $$->loc = @$;
  }
  ;

BlockItemList:BlockItemList BlockItem{
    $1.insert($1.end(), $2.begin(), $2.end());
    $$ = $1;
  }
  | %empty{
    $$ = SyntaxTree::PtrList<SyntaxTree::Stmt>();
  }
  ;

BlockItem:VarDecl{
    $$ = SyntaxTree::PtrList<SyntaxTree::Stmt>();
    $$.insert($$.end(), $1.begin(), $1.end());
  }
  | Stmt{
    $$ = SyntaxTree::PtrList<SyntaxTree::Stmt>();
    $$.push_back(SyntaxTree::Ptr<SyntaxTree::Stmt>($1));
  }
  ;

Stmt:LVal ASSIGN Exp SEMICOLON{
    auto temp = new SyntaxTree::AssignStmt();
    temp->target = SyntaxTree::Ptr<SyntaxTree::LVal>($1);
    temp->value = SyntaxTree::Ptr<SyntaxTree::Expr>($3);
    $$ = temp;
    $$->loc = @$;
  }
  | Exp SEMICOLON {
    auto temp = new SyntaxTree::FuncCallStmt();
    temp->expr = SyntaxTree::Ptr<SyntaxTree::Expr>($1);
    $$ = temp;
    $$->loc = @$;
  }
  | RETURN OptionRet SEMICOLON{
    auto temp = new SyntaxTree::ReturnStmt();
    temp->ret = SyntaxTree::Ptr<SyntaxTree::Expr>($2);
    $$ = temp;
    $$->loc = @$;
  }
  | Block{
    $$ = $1;
  }
  | SEMICOLON{
    $$ = new SyntaxTree::EmptyStmt();
    $$->loc = @$;
  }
  ;

OptionRet:Exp{
    $$ = $1;
  }
  | %empty{
    $$ = nullptr;
  }
  ;

LVal:IDENTIFIER ArrayExpList{
    $$ = new SyntaxTree::LVal();
    $$->name = $1;
    $$->array_index = $2;
    $$->loc = @$;
  }
  ;

%left PLUS MINUS;
%left MULTIPLY DIVIDE MODULO;
%precedence UPLUS UMINUS;

Exp:PLUS Exp %prec UPLUS{
    auto temp = new SyntaxTree::UnaryExpr();
    temp->op = SyntaxTree::UnaryOp::PLUS;
    temp->rhs = SyntaxTree::Ptr<SyntaxTree::Expr>($2);
    $$ = temp;
    $$->loc = @$;
  }
  | MINUS Exp %prec UMINUS{
    auto temp = new SyntaxTree::UnaryExpr();
    temp->op = SyntaxTree::UnaryOp::MINUS;
    temp->rhs = SyntaxTree::Ptr<SyntaxTree::Expr>($2);
    $$ = temp;
    $$->loc = @$;
  }
  | Exp PLUS Exp{
    auto temp = new SyntaxTree::BinaryExpr();
    temp->op = SyntaxTree::BinOp::PLUS;
    temp->lhs = SyntaxTree::Ptr<SyntaxTree::Expr>($1);
    temp->rhs = SyntaxTree::Ptr<SyntaxTree::Expr>($3);
    $$ = temp;
    $$->loc = @$;
  }
  | Exp MINUS Exp{
    auto temp = new SyntaxTree::BinaryExpr();
    temp->op = SyntaxTree::BinOp::MINUS;
    temp->lhs = SyntaxTree::Ptr<SyntaxTree::Expr>($1);
    temp->rhs = SyntaxTree::Ptr<SyntaxTree::Expr>($3);
    $$ = temp;
    $$->loc = @$;
  }
  | Exp MULTIPLY Exp{
    auto temp = new SyntaxTree::BinaryExpr();
    temp->op = SyntaxTree::BinOp::MULTIPLY;
    temp->lhs = SyntaxTree::Ptr<SyntaxTree::Expr>($1);
    temp->rhs = SyntaxTree::Ptr<SyntaxTree::Expr>($3);
    $$ = temp;
    $$->loc = @$;
  }
  | Exp DIVIDE Exp{
    auto temp = new SyntaxTree::BinaryExpr();
    temp->op = SyntaxTree::BinOp::DIVIDE;
    temp->lhs = SyntaxTree::Ptr<SyntaxTree::Expr>($1);
    temp->rhs = SyntaxTree::Ptr<SyntaxTree::Expr>($3);
    $$ = temp;
    $$->loc = @$;
  }
  | Exp MODULO Exp{
    auto temp = new SyntaxTree::BinaryExpr();
    temp->op = SyntaxTree::BinOp::MODULO;
    // if (temp->lhs != Type::INT || temp->rhs != Type::INT) {
    //     err.error(node.loc, ERROR_MODULO_FLOAT, "modulo for float");
    //     exit(1);
    // }
    temp->lhs = SyntaxTree::Ptr<SyntaxTree::Expr>($1);
    temp->rhs = SyntaxTree::Ptr<SyntaxTree::Expr>($3);
    $$ = temp;
    $$->loc = @$;
  }
  | LPARENTHESE Exp RPARENTHESE{
    $$ = $2;
  }
  | LVal{
    $$ = $1;
  }
  | Number{
    $$ = $1;
  }
  | IDENTIFIER LPARENTHESE RPARENTHESE{
    auto temp = new SyntaxTree::FuncCallExpr();
    temp->name = $1;
    $$ = temp;
    $$->loc = @$;
  }
  ;

Number: FLOATCONST {
    $$ = new SyntaxTree::Literal();
    $$->is_const = true;
    $$->type = SyntaxTree::Type::FLOAT;
    $$->fval = $1;
    $$->loc = @$;
  }
  | INTCONST {
    $$ = new SyntaxTree::Literal();
    $$->is_const = true;
    $$->type = SyntaxTree::Type::INT;
    $$->ival = $1;
    $$->loc = @$;
  }
  ;

%%

// Register errors to the driver:
void yy::C1Parser::error (const location_type& l,
                          const std::string& m)
{
    driver.error(l, m);
}
