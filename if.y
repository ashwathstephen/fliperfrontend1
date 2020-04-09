%{
void yyerror (char *s);
#include <stdio.h>
#include <stdlib.h>
%}


%token INT FLOAT CHAR 
%token FOR WHILE SWITCH CASE BREAK
%token IF ELSE PRINTF SCANF QU
%token NUM ID INC DEC EQL DEFAULT

%right '='
%left '<' '>' LE GE EQ NE LT GT
%%

start:	Function 
	| declare start
	|declare
	;

/* declare block */
declare: Type Assign ';' 
	| Assign ';'  	
	| function ';' 	
	| array  ';'	
	| Type array  ';'   
	;

/* Assign block */
Assign: ID '=' Assign
	| ID '=' function
	| ID '=' array 
	| array  '=' Assign
	| ID ',' Assign
	| ID '+' Assign
	| ID '-' Assign
	| ID '*' Assign
	| ID '/' Assign	
	| NUM '+' Assign
	| NUM '-' Assign
	| NUM '*' Assign
	| NUM '/' Assign
	| '\'' Assign '\''	
	|   NUM
	|   ID
	;

/* Function Call Block */
function : ID'('')'
	| ID'('Assign')'
	;

/* Array Usage */
array  : ID'['Assign']'
	|ID'['Assign']''['Assign']'
	;

/* Function block */
Function: Type ID '(' ArgListOpt ')' CompoundStmt 
	;
ArgListOpt: ArgList
	|
	;
ArgList:  ArgList ',' Arg
	| Arg
	;
Arg:	Type ID
	;
CompoundStmt:	'{' StmtList '}'
	;
StmtList:	StmtList Stmt
	|
	;
Stmt: PrintFunc
	|ScanFunc
	|WhileStmt
	|IfStmt 
	|ForStmt
	|switch
	|declare
	|
	;

switch: SWITCH '(' Expression ')' '{' switchcases '}';

switchcases: CASE NUM ':' Stmt BREAK ';' switchcases
	|DEFAULT ':' Stmt BREAK ';'
	|;

/* Loop Blocks */ 
WhileStmt: WHILE '(' Expression ')' Stmt  
	| WHILE '(' Expression ')' CompoundStmt 
	;
/* For Block */
ForStmt: FOR '(' Expression ';' Expression ';' Expression ')' Stmt 
       | FOR '(' Expression ';' Expression ';' Expression ')' CompoundStmt 
       | FOR '(' Expression ')' Stmt 
       | FOR '(' Expression ')' CompoundStmt 
	;

/* Print Function */
PrintFunc: PRINTF'('Stmt1')'';'
	;

/* Scan Function */
ScanFunc : SCANF '(' Stmt2 ')' ';'
	;
Stmt2: QU '%' ID QU ',' '&' ID
  ;
Stmt1 : QU Stmt1 QU
    | QU Stmt1 QU ',' ID
    |Expression
  ;


/* IfStmt Block */
IfStmt : IF '(' Expression ')'CompoundStmt
	|IF '(' Expression ')' else
    ;
else : ELSE CompoundStmt
    ;

Expression:	
	| Expression LE Expression 
	| Expression GE Expression
	| Expression NE Expression
	| Expression EQ Expression
	| Expression GT Expression
	| Expression LT Expression
	| Expression EQL Expression
	|Expression INC
	|Expression DEC
	| Assign
	| array 
	; 
Type:	INT 
	| FLOAT
	| CHAR
	;


%%
int main(){
    if(yyparse() == 0)
        printf("accepted");
    else
        return 0;
}
int yywrap(){
return 1;
}
void yyerror (char *s) {fprintf (stderr, "%s\n", s);}   