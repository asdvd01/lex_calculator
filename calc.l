%{
	/* Author: Ashutosh Dwivedi */	
#include "calc.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}
%%
sqrt					{
						return sqrt_;
						}
set				        {
						return set_command;
						}
print				    {
						return print;
						}
quit				    {
						return quit_command;
						}
[a-zA-Z]			    {
						yylval.id = yytext[0]; 
						return identifier;
						}
[0-9]+	                {
						yylval.num = (double)atoi(yytext); 
						return number;
						}
[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?	{
						yylval.num = (double)atof(yytext); 
						return number;
						}
[ \t]                   ;
[-+=()*/\^\n]           	{
						return yytext[0];
					    }
.                       {
						ECHO; 
						yyerror ("unexpected character");
					    }

%%
int yywrap (void) {return 1;}

