%{
	#include "header.h"
%}

%union
{
	int value;
	void* valueP;
	char id[16];
}

%start INPUT

%token	KW_AND KW_OR KW_NOT KW_EQUAL KW_LESS KW_NIL KW_LIST KW_APPEND KW_CONCAT KW_SET
		KW_DEFFUN KW_FOR KW_IF KW_EXIT KW_LOAD KW_DISP KW_TRUE KW_FALSE
		OP_PLUS OP_MINUS OP_DIV OP_MULT OP_OP OP_CP OP_DBLMULT OP_OC OP_CC OP_COMMA COMMENT
		
%token <value> VALUE
%token <id> IDENTIFIER

%type <value> INPUT
%type <value> EXPI
%type <value> EXPB
%type <valueP> EXPLISTI
%type <valueP> VALUES
%type <valueP> LISTVALUE

%%
INPUT:
	EXPI { printf("Syntax OK.\nResult: %d\n", $1); }
	|
	EXPLISTI { 	printf("Syntax OK.\nResult: "); 
				_print($1);
			 }	
	|
	INPUT EXPI { printf("Syntax OK.\nResult: %d\n", $2); }
	|
	INPUT EXPLISTI  { 	printf("Syntax OK.\nResult: "); 
						_print($2);

			 		}	
	;

EXPI:
	OP_OP OP_PLUS EXPI EXPI OP_CP {$$ = $3 + $4;}
	|
	OP_OP OP_MINUS EXPI EXPI OP_CP {$$ = $3 - $4;}
	|
	OP_OP OP_MULT EXPI EXPI OP_CP {$$ = $3 * $4;}
	|
	OP_OP OP_DIV EXPI EXPI OP_CP {$$ = $3 / $4;}
	|
	OP_OP OP_DBLMULT EXPI EXPI OP_CP {$$ = _pow($3, $4);}
	|
	IDENTIFIER { 
					Input* inp = _getInput($1); 
					if(inp == NULL) 
						$$ = 1; 
					else 
						$$ = inp->val; 
				}
	|
	VALUE {$$ = $1;}
	|
	OP_OP KW_SET IDENTIFIER EXPI OP_CP { $$ = $4; _addInput($3, $4); } 
	|
	OP_OP KW_IF EXPB EXPI OP_CP { 
									if($3 == 1)	$$ = $4;
									else $$ = 0;
								}
	|
	OP_OP KW_IF EXPB EXPI EXPI OP_CP { 
										if($3 == 1)	$$ = $4;
										else $$ = $5; 
									}
	|
    OP_OP KW_FOR EXPB EXPI OP_CP { $$ = (1 == $3) ? $4 : 0; }
	;

EXPB:
	OP_OP KW_AND EXPB EXPB OP_CP { $$ = $3 && $4; }
	|	
	OP_OP KW_OR EXPB EXPB OP_CP { $$ = $3 || $4; }
	|
	OP_OP KW_NOT EXPB OP_CP { $$ = !$3;}
	|
	OP_OP KW_EQUAL EXPB EXPB OP_CP {
										if($3 == $4) $$ = 1;
										else $$ = 0;  
									}
	|
	OP_OP KW_EQUAL EXPI EXPI OP_CP {
										if($3 == $4) $$ = 1;
										else $$ = 0;  
									}
	|

	KW_TRUE { $$ = 1; }
	|
	KW_FALSE { $$ = 0; }
	;

EXPLISTI:
	OP_OP KW_CONCAT EXPLISTI EXPLISTI OP_CP { $$ = _concatinate($3, $4); }
	|
	OP_OP KW_APPEND EXPI EXPLISTI OP_CP { $$ = _appendItem($4, $3); }
	|
	OP_OP KW_LIST VALUES OP_CP {$$ = $3;}
	|
	LISTVALUE { $$ = $1; }
	|
	OP_OP KW_DISP LISTVALUE OP_CP { $$ = $3; printf("Print: "); _print($3);}
	;

LISTVALUE:
	OP_OP VALUES OP_CP { $$ = $2; }
	|
	OP_OP OP_CP { $$ = _initializer(); }
	|
	KW_NIL { $$ = NULL; }
	;

VALUES:
	VALUES VALUE { $$ = _addItem($1, $2); }
	|
	VALUE { $$ = _addItem(NULL, $1); }
	;
%%

int yyerror(char* str) 
{ 
	printf("SYNTAX_ERROR Expression not recognized\n");
	return 0; 
}

int main()
{
	
		printf("> ");
		_createIdCont();
		startInterpreter();

		_free();
	


	return 0;
}