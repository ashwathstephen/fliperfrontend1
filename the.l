%{
	#include <stdio.h>
	#include "if.tab.h"
	int yylineno=0;
%}

alpha [a-zA-Z]
digit [0-9]

%%
[ \t]		;
[ \n]   { yylineno = yylineno + 1;}
int	return INT;
float return FLOAT;
char return CHAR;
for return FOR;
while return WHILE;
if	return IF;
else	return ELSE;
printf  return PRINTF;
scanf return SCANF;
switch return SWITCH;
case  return CASE;
break return BREAK;
default return DEFAULT;
{digit}+       return NUM;
{alpha}({alpha}|{digit})* return ID;
"<="    return LE;
">="    return GE;
"\""    return QU;
"=="    return EQ;
"!="    return NE;
"++"    return INC;
"--"    return DEC;
"="     return EQL;
">"	return GT;
"<"	return LT;
.       return yytext[0];
%%