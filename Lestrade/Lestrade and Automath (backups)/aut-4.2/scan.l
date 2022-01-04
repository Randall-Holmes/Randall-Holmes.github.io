%{
#include "flex.h"
#include "aut.h"
#include "parse.h"
%}
%start TEXT COMMENT
%%
<TEXT>":="|"="				return ASSIGN;
<TEXT>"--"				return CLOSE;
<TEXT>"'E'"|"_\bE"			return ESTI;
<TEXT>"EB"|"'eb'"|"---"			return EB;
<TEXT>"PN"|"'pn'"|"PRIM"|"'prim'"|"???"	return PN;
<TEXT>"TYPE"|"'type'"			return TYPE;
<TEXT>"PROP"|"'prop'"			if (HASPROP()) return PROP; else { yylval.asid = ident(yytext); return IDENT; }
<TEXT>[a-zA-Z0-9_\b`']+			yylval.asid = ident(yytext); return IDENT;
<TEXT>"{"				cdepth++; BEGIN(COMMENT);
<TEXT>[#%][^\n\r]*[\n\r]		line++;
<TEXT>[#%][^\n\r]*\r\n			line++;
<TEXT>[\n\r]				line++;
<TEXT>\r\n				line++;
<TEXT>[ \t]				;
<TEXT>.					return *yytext;
<COMMENT>"{"				cdepth++;
<COMMENT>"}"				cdepth--; if (!cdepth) BEGIN(TEXT);
<COMMENT>[\n\r]				line++;
<COMMENT>\r\n				line++;
<COMMENT>.				;
.|[\n\r]				unput(*yytext); BEGIN(TEXT);
%%
