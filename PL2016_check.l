/*Definitions*/
%{
#include "y.tab.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
void yyerror(char* s);

%}

%option yylineno

%%
 /*Rules */
  /*Reserved words */
[ \t\r]	{}
[\n]    {yylineno++;}



DECLARATION	{printf("%s\n",yytext);return DECLARATION;}
OF	{printf("%s\n",yytext);return OF;}

END	{printf("%s\n",yytext);return END;}
CONST	{printf("%s\n",yytext);return CONST;}
VAR	{printf("%s\n",yytext);return VAR;}
PROCEDURE	{printf("%s\n",yytext);return PROCEDURE;}
FUNCTION {printf("%s\n",yytext);return FUNCTION;}
TYPE	{printf("%s\n",yytext);return TYPE;}
ARRAY	{printf("%s\n",yytext);return ARRAY;}
IMPLEMENTATION	{printf("%s\n",yytext);return IMPLEMENTATION;}
 /*for .. and := */
\.\.	{printf("%s\n",yytext);return DOUBLEQOUTE;}
\:\=	{printf("%s\n",yytext);return ASSIGN;}

FOR	{printf("%s\n",yytext);return FOR;}
EACH	{printf("%s\n",yytext);return EACH;}
DO	{printf("%s\n",yytext);return DO;}
IF	{printf("%s\n",yytext);return IF;}
THEN	{printf("%s\n",yytext);return THEN;}
WHILE	{printf("%s\n",yytext);return WHILE;}
BEGIN	{printf("%s\n",yytext);return BEGINS;}
CALL	{printf("%s\n",yytext);return CALL;}
IN	{printf("%s\n",yytext);return IN;}
 /*number is start 0, until a very big number  */
[0-9]+ 	{printf("%s\n",yytext);return NUMBER;}
 /*all ident are lowercase */
[a-z][a-z]*	{printf("%s\n",yytext);return CHARACTERS;} 
 /*for +,-,* and / */
[\+\-\*\/]	{printf("%s\n",yytext);return yytext[0];}
 /*for . , ; : () [] {} */
[\.\,\;\:\=\(\)\[\]\{\}] {printf("%s\n",yytext);return yytext[0];}
 /*when has error, print out the error symbol*/
.		{yyerror(yytext);}
%%

 /*call the function from Lex */
int yywrap(void) 
{
    return 1;
}


