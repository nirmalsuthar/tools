%{
    void yyerror (char *s);
    int yylex();

    #include <iostream>
    #include <stdio.h>     /* C declarations used in actions */
    #include <stdlib.h>
    #include <string.h>
    #include <utility>
    #include <ctype.h>
    #include <sstream>
    #include <unordered_map>
    #include <math.h>

    /* Container to store parse values and results. */
    std::unordered_map<std::string, double> symbol_table;

    double symbolVal(const char* symbol);
    void updateSymbolVal(const char* symbol, double val);
    extern int yyparse();
%}

/* Yacc definitions */



%union {double num; const char* id;}         

%start program

%token print
%token exit_command
%token <num> number
%token <id> identifier
%token SIN COS TAN LOG POW comma

//%type stmt_list program assignment
%type <num> exp term

%left '+' '-'
%left '*' '/'
%%

/* descriptions of expected inputs  &   corresponding actions */

program : stmt_list
        ;

stmt_list : stmt_list assignment ';' 
          | stmt_list print exp ';'    {printf("%lf\n", $3);}
          | stmt_list exit_command ';' {printf("Exitting...\n"); exit(0);}
          | /* Empty */
          ;

assignment : identifier '=' exp  { updateSymbolVal($1, $3); }
           ;

exp : term        	{ $$ = $1;}
    | exp '+' exp 	{ $$ = $1 + $3;}
    | exp '-' exp 	{ $$ = $1 - $3;}
    | exp '*' exp 	{ $$ = $1 * $3;}
    | exp '/' exp 	{ $$ = $1 / $3;}
    | '(' exp ')' 	{ $$ = $2; }
    | SIN exp  		{ $$ = sin($2); }
    | COS exp  		{ $$ = cos($2); }
    | TAN exp  		{ $$ = tan($2); }
    | LOG exp  		{ $$ = log($2); }
    | POW '(' exp comma exp ')' { $$ = pow($3,$5); }
    ;

term : number     { $$ = $1; }
     | identifier { $$ = symbolVal($1); }
     
     ;

%%     

/* returns the value of a given symbol from symbol table */
double symbolVal(const char* symbol)
{
std::string find(symbol);
    return symbol_table[find];
}

/* updates the value of a given symbol in symbol table */
void updateSymbolVal(const char* symbol, double val)
{
    std::string input(symbol);
    symbol_table[input] = val;
}

int main (int argc, char *argv[] ) {
    
    if (argc == 1) {
	return yyparse();
    } 

   else if (argc > 2) {
	printf("Usage Error: ./mycalc <input_file>\n");
	return 0;
    }   

    extern FILE* yyin;
    yyin = fopen(argv[1], "r");
    int result = yyparse();
    fclose(yyin);
    return result;

}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

