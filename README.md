# lex_calculator
Simple calculaor
#Features:-
•	Can read from stdin or a file whose name is input 
•	Exits on end of file or quit command  
•	All expressions can be evaluayed and/or set to a variable usin set command or simple assignment operation  
•	Recognizes integer, floating point constant with or without exponent part after e/E having optional sign  
•	All operations are double precision  
•	Commands like set , sqrt,  quit are available 
•	Operators like +,-,*,/,^  are available  
•	52 variables [a-zA-Z] are available  
#Compiling 
Windows->
flex calc.l
bison calc.y -d
gcc lex.yy.c calc.tab.c -o calc.exe
calc.exe [optional input filename]
Ubuntu
lex calc.l
yacc calc.y
gcc lex.yy.c calc.tab.c -ll -o calc.out
calc.out [optional input filename]
