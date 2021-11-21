%{
  #include<stdio.h>
  #include <stdlib.h>
  #include <string.h>
  int yylex();
  void yyerror(char *);
  char * name(char *);
  int counter = 0;

%}

%union {char ch[200];}

%token <ch> digit

%type <ch> program expr number

%left '+' '-'
%left '*' '/'
%left '(' ')'

%%

program:
        program expr '\n'						{
													if(counter == 0) {
														printf("Assign %s to t%d\n", $2, counter);
														printf("print t%d\n", counter);
														counter = 0;
													}
													else {
														printf("print t%d\n", counter - 1);
														counter = 0;
													}
												}
        |										{;}
        ;
expr:
        number									{;}
        | expr '+' expr							{printf("Assign %s Plu %s to t%d\n", $1, $3, counter++); sprintf($$, "t%d", counter-1);}
        | expr '-' expr							{printf("Assign %s Min %s to t%d\n", $1, $3, counter++); sprintf($$, "t%d", counter-1);}
        | expr '*' expr							{printf("Assign %s Mul %s to t%d\n", $1, $3, counter++); sprintf($$, "t%d", counter-1);}
        | expr '/' expr							{printf("Assign %s Div %s to t%d\n", $1, $3, counter++); sprintf($$, "t%d", counter-1);}
        | '('expr')'							{sprintf($$, "t%d", counter-1);}
        ;
number:
		digit									{sprintf($$, "%s", name($1));}
		|digit digit							{sprintf($$, "%sTen_%s", name($1), name($2));}
		|digit digit digit						{sprintf($$, "%sHun_%sTen_%s", name($1), name($2), name($3));}
		|digit digit digit digit				{sprintf($$, "(%s)Tou_%sHun_%sTen_%s", name($1), name($2), name($3), name($4));}
		|digit digit digit digit digit			{sprintf($$, "(%sTen_%s)Tou_%sHun_%sTen_%s", name($1), name($2), name($3), name($4), name($5));}
        |digit digit digit digit digit digit	{sprintf($$, "(%sHun_%sTen_%s)Tou_%sHun_%sTen_%s", name($1), name($2), name($3), name($4), name($5), name($6));}
        ;

%%

int main(void) {
	yyparse();
	return 0;
}

char * name(char *dig) {
    switch(dig[0]) {
        case '0':
            return "Zer";
        case '1':
            return "One";
        case '2':
			return "Two";
        case '3':
			return "Thr";
        case '4':
			return "Fou";
        case '5':
			return "Fiv";
        case '6':
			return "Six";
        case '7':
			return "Sev";
        case '8':
			return "Eig";
        case '9':
			return "Nin";
    }
}

void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}
