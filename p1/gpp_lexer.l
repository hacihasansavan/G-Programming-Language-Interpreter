%{ 
#include <stdio.h>
int counter = 0;
%} 

%option caseless

%%

[a][n][d]					{fprintf(yyout,"KW_AND\n");}
[o][r]						{fprintf(yyout,"KW_OR\n");}
[n][o][t]					{fprintf(yyout,"KW_NOT\n");}
[e][q][u][a][l] 			{fprintf(yyout,"KW_EQUAL\n");}
[l][e][s][s]				{fprintf(yyout,"KW_LESS\n");}
[n][i][l]					{fprintf(yyout,"KW_NIL\n");}
[l][i][s][t]				{fprintf(yyout,"KW_LIST\n");}
[a][p][p][e][n][d]		    {fprintf(yyout,"KW_APPEND\n");}
[c][o][n][c][a][t]		    {fprintf(yyout,"KW_CONCAT\n");}
[s][e][t]					{fprintf(yyout,"KW_SET\n");}
[d][e][f][f][u][n]	    	{fprintf(yyout,"KW_DEFFUN\n");}
[f][o][r]					{fprintf(yyout,"KW_FOR\n");}
[i][f]						{fprintf(yyout,"KW_IF\n");}

[l][o][a][d]				{fprintf(yyout,"KW_LOAD\n");}
[d][i][s][p]				{fprintf(yyout,"KW_DISP\n");}
[t][r][u][e]				{fprintf(yyout,"KW_TRUE\n");}
[f][a][l][s][e]	    		{fprintf(yyout,"KW_FALSE\n");}
[e][x][i][t]	    		{printf("KW_EXIT\n"); exit(EXIT_FAILURE);}
[+] 						{fprintf(yyout,"OP_PLUS\n");}
[-] 						{fprintf(yyout,"OP_MINUS\n");}
[/] 						{fprintf(yyout,"OP_DIV\n");}
[*][*] 						{fprintf(yyout,"OP_DBLMULT\n");}
[*] 						{fprintf(yyout,"OP_MULT\n");}
[(] 						{fprintf(yyout,"OP_OP\n");}
[)] 						{fprintf(yyout,"OP_CP\n");}
["] 						{
								
								counter++;
								if(counter == 1){
									fprintf(yyout,"OP_OC\n");		
								}
								else if(counter == 2){
									fprintf(yyout,"OP_CC\n");	
									counter = 0;		
								} 
									
							}

[,]								{fprintf(yyout,"OP_COMMA\n");}

[;;](.*)						{fprintf(yyout,"COMMENT\n");}

[a-zA-Z_][a-zA-Z0-9_]*			{fprintf(yyout,"IDENTIFIER\n");}

[0]|[1-9][0-9]*					{fprintf(yyout,"VALUE\n");}




[ ]+							{/*empty*/}
.								{
									fprintf(yyout,"SYNTAX_ERROR %s cannot be tokenized!\n",yytext);
                         			exit(EXIT_FAILURE);
								}

%% 
int yywrap(){}
int main(){ 

    while(1){
        yylex();
    }
    
	return 0; 
}
