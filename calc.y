%{
/* Author: Ashutosh Dwivedi */	
void yyerror (char *s);
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <math.h>
extern FILE * yyin;
double symbols[52];
double symbolVal(char symbol);
void updateSymbolVal(char symbol, double val);
%}

%union {double num;char id;}         /* Yacc definitions */
%start program
%token print
%token sqrt_
%token quit_command
%token set_command
%token <num> number
%token <id> identifier
%type <id> assignment
%type <num> line exp factor term
%%

/* descriptions of expected inputs     corresponding actions (in C) */
program : program line '\n'     {;}
		| line '\n'			    {;}
		;
line    : assignment 			{;}
		| quit_command 			{exit(EXIT_SUCCESS);}
		| print exp 			{printf("Printing %G\n", $2);}
		| exp 					{$$ = $1;printf("%G\n",$$);}
        ;

assignment : identifier '=' exp  { updateSymbolVal($1,$3);printf("%c:%G\n",$1,$3 ); }
		| set_command identifier exp { updateSymbolVal($2,$3);printf("%c:%G\n",$2,$3 );}
			;
exp    	:factor                  {$$ = $1;}
       	| exp '+' factor          {$$ = $1 + $3;}
       	| exp '-' factor          {$$ = $1 - $3;}
       	;
factor	: term					{$$ = $1;}
		| sqrt_ term			{$$ = sqrt($2);}
		| term '^' term			{$$ = pow($1,$3);}
		| factor '*' term		{$$ = $1 * $3;}
		| factor '/' term		{$$ = $1 / $3;}
term   	:'('  exp ')'			{$$ = $2;}
		|number                 {$$ = $1;}
		| identifier			{$$ = symbolVal($1);} 
        ;

%%                     /* C code */

int computeSymbolIndex(char token)
{
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
} 

/* returns the value of a given symbol */
double symbolVal(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}

/* updates the value of a given symbol */
void updateSymbolVal(char symbol, double val)
{
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}
int main (int argc, char const *argv[]) {
	/* init symbol table */
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}
	yyin = fopen(argv[1],"r");
	return yyparse ( );
	fclose(yyin);
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

