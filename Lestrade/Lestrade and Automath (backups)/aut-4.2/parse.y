%{
#include "aut.h"
#include "parse.h"
%}

%token IDENT ASSIGN CLOSE ESTI EB PN TYPE PROP
%type <asint> noexpand
%type <asid> IDENT
%type <aspar> identlist
%type <asexp> expr, abst, sym
%type <asargs> exprlist
%%
text
	:
	| text item			{ yield(); }
	| text ';'
	;
item
	: '+' IDENT			{ openpar($2, 0); }
	| '+' '*' IDENT			{ openpar($3, 1); }
	| '-' IDENT			{ closepar($2); }
	| CLOSE				{ closepar((par) 0); }
	| STAR				{ setcon((exp) 0); }
	| sym STAR			{ setcon($1); }
	| '[' IDENT open
	    COMMA expr close ']'	{ newcon($2, $5); }
	| IDENT open ASSIGN EB
	    SEMI expr close		{ newcon($1, $6); }
	| IDENT open ASSIGN PN
	    SEMI expr close		{ newdef($1, (exp) 0, $6, 0); }
	| IDENT open
	    ASSIGN noexpand expr
	    SEMI expr close		{ newdef($1, $5, $7, $4); }
	| IDENT open SEMI expr
	    ASSIGN EB close		{ newcon($1, $4); }
	| IDENT open SEMI expr
	    ASSIGN PN close		{ newdef($1, (exp) 0, $4, 0); }
	| IDENT open SEMI expr
	    ASSIGN noexpand expr close	{ newdef($1, $7, $4, $6); }
	| error				{ recover(); }
	;
open
	: 				{ opencon(); }
	;
close
	: 				{ closecon(); }
	;
noexpand
	:				{ $$ = 0; }
	| '~'				{ $$ = 1; }
	;
expr
	: TYPE				{ $$ = oneexp(0); }
	| PROP				{ $$ = oneexp(1); }
	| sym				{ $$ = call($1, (args) 0, 0); }
	| sym '(' ')'			{ $$ = call($1, (args) 0, 1); }
	| sym '(' exprlist ')'		{ $$ = call($1, $3, 1); }
	| '<' expr '>' expr		{ $$ = appl($2, $4); }
	| abst expr			{ $$ = closeabs($1, $2); }
	;
abst
	: '[' IDENT COMMA expr ']'	{ $$ = openabs($2, $4); }
	;
exprlist
	: expr				{ $$ = newlist((args) 0, $1); }
	| exprlist ',' expr		{ $$ = newlist($1, $3); }
	;
sym
	: IDENT				{ $$ = findsym($1); }
	| IDENT '"' identlist '"'	{ $$ = findexp($3, $1); }
	;
identlist
	: 				{ $$ = curpar; }
	| IDENT				{ $$ = superpar($1); }
	| identlist HYPHEN IDENT	{ $$ = subpar($1, $3); }
	;
STAR
	: '*'
	| '@'
	;
COMMA
	: ','
	| ':'
	;
SEMI
	: ESTI
	| ';'
	| ':'
	;
HYPHEN
	: '-'
	| '.'
	;
%%
