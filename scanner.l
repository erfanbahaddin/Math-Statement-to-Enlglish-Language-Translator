%{
	#include<string.h>
	#include<stdio.h>
	#include <stdlib.h>
	#include "y.tab.h"
	void yyerror(char *);
%}



%%

[0-9]					{sprintf(yylval.ch, "%d", yytext[0] - '0'); return digit;}

[ \t]					{;}

[+-/*()\n]				{return yytext[0];}

.						yyerror("invalid character");

%% 

int yywrap(void) {
	return 1;
}
