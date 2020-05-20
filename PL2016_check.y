%{
int yylex(void);
void yyerror(char* s);/*function for error is detected*/

#include <stdio.h>
#include <stdlib.h>
extern int yylineno;/*current line number*/
%}

%union{
	char* str;/*token for ident*/
	/*number token sent by lex*/
	int number;
}

/*declare all tokens */
%token DECLARATION
%token OF
%token END
%token CONST
%token VAR
%token PROCEDURE
%token FUNCTION
%token TYPE
%token ARRAY
%token DOUBLEQOUTE
%token IMPLEMENTATION
%token ASSIGN
%token CALL
%token IF
%token THEN
%token DO
%token WHILE
%token FOR
%token EACH
%token BEGINS
%token IN





%token NUMBER
%token CHARACTERS


%%
/* the grammer rules*/
basic_program	:declaration_unit
		|implementation_unit
		;

/*declaration_ unit part*/
declaration_unit	:DECLARATION OF ident
                     opt_const_declaration
                     opt_var_declaration
                     opt_type_declaration  
                     opt_procedure_interface   
                     opt_function_interface          
                     DECLARATION END;
opt_const_declaration:
                     | CONST const_declaration;

opt_var_declaration :
                    | VAR var_declaration;

opt_type_declaration    :
                        | type_declaration;
opt_function_interface  :
                        | function_interface;
opt_procedure_interface   :
                        | procedure_interface;
procedure_interface	: PROCEDURE ident 
			| PROCEDURE ident formal_parameters
			;
function_interface	: FUNCTION ident
			        | FUNCTION ident formal_parameters
			        ;

type_declaration	: TYPE ident ':' type ';'
			;
/*because need recursion between ( ), so declare a new variable*/
formal_parameters	: '(' insideFormal')'
			;
/*right recursion used because optional bymbol at the end of recursion */
insideFormal		:ident
			|ident ';' insideFormal
			;

const_declaration	: ident '=' number ';'
			| ident '=' number ',' const_declaration
			;
var_declaration		: ident':' ident';'
			| ident ':' ident',' var_declaration
			;
type		: basic_type
		| array_type
		;
basic_type	: ident
		| enumerated_type
		| range_type
		;
/*because need recursion between { }, so declare a new variable*/
enumerated_type	: '{' insideEnum'}'
		;

insideEnum	: ident
		| ident ',' insideEnum
		;
range_type	: '[' range ']'
		;
array_type	: ARRAY ident '[' range']' OF type
		;
range		: number DOUBLEQOUTE number		
		;

/*implementation_unit part*/
implementation_unit	: IMPLEMENTATION OF ident block '.'
			;
block		: specification_part implementation_part
		;
specification_part	:
			| CONST const_declaration
			| VAR var_declaration
           		| proceduce_declaration
			| function_declaration
			
			;
proceduce_declaration	: PROCEDURE ident ';' block ';'
			;
function_declaration	: FUNCTION ident ';' block ';'
			;
implementation_part	:compound_statement
			;
statement		: assignment
			| procedure_call
			| if_statement
			| while_statement
			| do_statement
			| for_statement
			| compound_statement
			;
assignment	:ident ASSIGN expression
		;
procedure_call	:CALL ident
		;
if_statement	: IF expression THEN compound_statement END IF
		;
while_statement	: WHILE	 expression DO compound_statement END WHILE
		;
do_statement	: DO compound_statement WHILE expression END DO
		;
for_statement	: FOR EACH ident IN ident DO compound_statement END FOR
		;
/*declare a new variable beacuse need recursion between two things*/
compound_statement	: BEGINS RepeatStatement END
			;
/*right recursion used because optional bymbol at the end of recursion */
RepeatStatement	:statement 
		|statement ';' RepeatStatement
		;
expression	:term
		|expression '+' term 
		|expression '-' term
		;
term	: id_num
	| term '*' id_num
	| term '/' id_num
	;
id_num	:ident
	|number
	;
number	: NUMBER;
ident	: CHARACTERS;

%%

/*function for print the error and line number*/
void yyerror(char *s) {
	fprintf(stderr, "at line: %d %s\n",yylineno,s); 
}


int main(void)
{
		

	return yyparse();
}







