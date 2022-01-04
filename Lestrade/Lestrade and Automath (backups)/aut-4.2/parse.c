
# line 2 "parse.y"
#include "aut.h"
#include "parse.h"
# define IDENT 257
# define ASSIGN 258
# define CLOSE 259
# define ESTI 260
# define EB 261
# define PN 262
# define TYPE 263
# define PROP 264
#define yyclearin yychar = -1
#define yyerrok yyerrflag = 0
extern int yychar;
extern short yyerrflag;
#ifndef YYMAXDEPTH
#define YYMAXDEPTH 150
#endif
YYSTYPE yylval, yyval;
# define YYERRCODE 256

# line 94 "parse.y"

short yyexca[] ={
-1, 1,
	0, -1,
	-2, 0,
-1, 10,
	42, 32,
	64, 32,
	-2, 18,
	};
# define YYNPROD 46
# define YYLAST 228
short yyact[]={

  66,  41,  36,  12,   4,  36,   5,  27,  26,  27,
  26,  53,  15,  58,  57,  29,  21,  18,  16,  41,
   3,  85,  71,  37,  12,  13,  59,  69,  31,  24,
  35,  54,  44,  45,  30,  78,  20,  19,  79,   7,
  46,  40,  32,   8,  47,  48,  13,   2,  17,   1,
  44,  67,   9,  42,  49,  28,  22,   0,   0,  52,
   0,   0,   0,  50,  51,  55,  56,   0,   0,   0,
   0,   0,   0,   0,  60,  61,   0,   0,  68,   0,
   0,   0,  62,   0,  65,   0,  74,  72,  73,  77,
  75,  76,  70,  80,  81,   0,   0,   0,   0,   0,
   0,  82,   0,  84,  83,   0,   0,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,  63,  64,   0,
  33,  34,   0,   0,   0,   0,   0,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,  43,   0,
   0,   0,   0,   0,  38,  39,   0,  23,   0,  25,
   0,  25,   0,   0,   0,   0,  43,  11,  10,   0,
   6,   0,  38,  39,   0,   0,   0,  14 };
short yypact[]={

-1000, -39,-1000,-1000, -30,-239,-1000,-1000, -18,-240,
   2,-1000,-1000,-1000,-1000,-241,-1000,-1000,-1000, -51,
-242,-1000, -16,-121, -59,-1000,-1000,-1000,  -1,-1000,
 -59,-1000,-1000, -49, -49, -59,-1000,-247,-1000,-1000,
  -9, -59, -59,   2,-243,-1000,-244,-1000,-1000,-1000,
 -59, -59, -49,-124, -41, -35,-1000, -16,-1000, -71,
-1000,-1000, -59,-1000,-1000, -59,-1000,  -6,-1000, -59,
 -59,-1000,-1000,-1000,-1000,-1000,-1000,-1000,-1000, -59,
-1000, -72,-1000,-1000,-1000,-1000 };
short yypgo[]={

   0,  30,  55,  23,  53,  41,  51,  49,  47,  39,
  37,  34,  26,  29,  40 };
short yyr1[]={

   0,   7,   7,   7,   8,   8,   8,   8,   8,   8,
   8,   8,   8,   8,   8,   8,   8,   8,  10,  12,
   1,   1,   3,   3,   3,   3,   3,   3,   3,   4,
   6,   6,   5,   5,   2,   2,   2,   9,   9,  11,
  11,  13,  13,  13,  14,  14 };
short yyr2[]={

   0,   0,   2,   2,   2,   3,   2,   1,   1,   2,
   7,   7,   7,   8,   7,   7,   8,   1,   0,   0,
   0,   1,   1,   1,   1,   3,   4,   4,   2,   5,
   1,   3,   1,   4,   0,   1,   3,   1,   1,   1,
   1,   1,   1,   1,   1,   1 };
short yychk[]={

-1000,  -7,  -8,  59,  43,  45, 259,  -9,  -5,  91,
 257, 256,  42,  64, 257,  42, 257,  -9, 257, -10,
  34, 257, -10, 258, -13, 260,  59,  58,  -2, 257,
 -11,  44,  58, 261, 262,  -1, 126,  -3, 263, 264,
  -5,  60,  -4, 257,  91,  34, -14,  45,  46,  -3,
 -13, -13,  -3, 258,  40,  -3,  -3, 257, 257, -12,
  -3,  -3, -13, 261, 262,  -1,  41,  -6,  -3,  62,
 -11,  93, -12, -12,  -3, -12, -12,  -3,  41,  44,
  -3,  -3, -12, -12,  -3,  93 };
short yydef[]={

   1,  -2,   2,   3,   0,   0,   7,   8,   0,   0,
  -2,  17,  37,  38,   4,   0,   6,   9,  18,   0,
  34,   5,   0,  20,   0,  41,  42,  43,   0,  35,
   0,  39,  40,   0,   0,   0,  21,   0,  22,  23,
  24,   0,   0,  32,   0,  33,   0,  44,  45,  19,
   0,   0,   0,  20,   0,   0,  28,   0,  36,   0,
  19,  19,   0,  19,  19,   0,  25,   0,  30,   0,
   0,  10,  11,  12,  19,  14,  15,  19,  26,   0,
  27,   0,  13,  16,  31,  29 };
#ifndef lint
static char yaccpar_sccsid[] = "@(#)yaccpar	4.1	(Berkeley)	2/11/83";
#endif not lint

#
# define YYFLAG -1000
# define YYERROR goto yyerrlab
# define YYACCEPT return(0)
# define YYABORT return(1)

/*	parser for yacc output	*/

#ifdef YYDEBUG
int yydebug = YYDEBUG; /* 1 for debugging */
#endif
YYSTYPE yyv[YYMAXDEPTH]; /* where the values are stored */
int yychar = -1; /* current input token number */
int yynerrs = 0;  /* number of errors */
short yyerrflag = 0;  /* error recovery flag */

yyparse() {

	short yys[YYMAXDEPTH];
	short yyj, yym;
	register YYSTYPE *yypvt;
	register short yystate, *yyps, yyn;
	register YYSTYPE *yypv;
	register short *yyxi;

	yystate = 0;
	yychar = -1;
	yynerrs = 0;
	yyerrflag = 0;
	yyps= &yys[-1];
	yypv= &yyv[-1];

 yystack:    /* put a state and value onto the stack */

#ifdef YYDEBUG
	if( yydebug  ) printf( "state %d, char 0%o\n", yystate, yychar );
#endif
		if( ++yyps>=&yys[YYMAXDEPTH] ) { yyerror( "yacc stack overflow" ); return(1); }
		*yyps = yystate;
		++yypv;
		*yypv = yyval;

 yynewstate:

	yyn = yypact[yystate];

	if( yyn<= YYFLAG ) goto yydefault; /* simple state */

	if( yychar<0 ) if( (yychar=yylex())<0 ) yychar=0;
	if( (yyn += yychar)<0 || yyn >= YYLAST ) goto yydefault;

	if( yychk[ yyn=yyact[ yyn ] ] == yychar ){ /* valid shift */
		yychar = -1;
		yyval = yylval;
		yystate = yyn;
		if( yyerrflag > 0 ) --yyerrflag;
		goto yystack;
		}

 yydefault:
	/* default state action */

	if( (yyn=yydef[yystate]) == -2 ) {
		if( yychar<0 ) if( (yychar=yylex())<0 ) yychar = 0;
		/* look through exception table */

		for( yyxi=yyexca; (*yyxi!= (-1)) || (yyxi[1]!=yystate) ; yyxi += 2 ) ; /* VOID */

		while( *(yyxi+=2) >= 0 ){
			if( *yyxi == yychar ) break;
			}
		if( (yyn = yyxi[1]) < 0 ) return(0);   /* accept */
		}

	if( yyn == 0 ){ /* error */
		/* error ... attempt to resume parsing */

		switch( yyerrflag ){

		case 0:   /* brand new error */

			yyerror( "syntax error" );
		yyerrlab:
			++yynerrs;

		case 1:
		case 2: /* incompletely recovered error ... try again */

			yyerrflag = 3;

			/* find a state where "error" is a legal shift action */

			while ( yyps >= yys ) {
			   yyn = yypact[*yyps] + YYERRCODE;
			   if( yyn>= 0 && yyn < YYLAST && yychk[yyact[yyn]] == YYERRCODE ){
			      yystate = yyact[yyn];  /* simulate a shift of "error" */
			      goto yystack;
			      }
			   yyn = yypact[*yyps];

			   /* the current yyps has no shift onn "error", pop stack */

#ifdef YYDEBUG
			   if( yydebug ) printf( "error recovery pops state %d, uncovers %d\n", *yyps, yyps[-1] );
#endif
			   --yyps;
			   --yypv;
			   }

			/* there is no state on the stack with an error shift ... abort */

	yyabort:
			return(1);


		case 3:  /* no shift yet; clobber input char */

#ifdef YYDEBUG
			if( yydebug ) printf( "error recovery discards char %d\n", yychar );
#endif

			if( yychar == 0 ) goto yyabort; /* don't discard EOF, quit */
			yychar = -1;
			goto yynewstate;   /* try again in the same state */

			}

		}

	/* reduction by production yyn */

#ifdef YYDEBUG
		if( yydebug ) printf("reduce %d\n",yyn);
#endif
		yyps -= yyr2[yyn];
		yypvt = yypv;
		yypv -= yyr2[yyn];
		yyval = yypv[1];
		yym=yyn;
			/* consult goto table to find next state */
		yyn = yyr1[yyn];
		yyj = yypgo[yyn] + *yyps + 1;
		if( yyj>=YYLAST || yychk[ yystate = yyact[yyj] ] != -yyn ) yystate = yyact[yypgo[yyn]];
		switch(yym){
			
case 2:
# line 15 "parse.y"
{ yield(); } break;
case 4:
# line 19 "parse.y"
{ openpar(yypvt[-0].asid, 0); } break;
case 5:
# line 20 "parse.y"
{ openpar(yypvt[-0].asid, 1); } break;
case 6:
# line 21 "parse.y"
{ closepar(yypvt[-0].asid); } break;
case 7:
# line 22 "parse.y"
{ closepar((par) 0); } break;
case 8:
# line 23 "parse.y"
{ setcon((exp) 0); } break;
case 9:
# line 24 "parse.y"
{ setcon(yypvt[-1].asexp); } break;
case 10:
# line 26 "parse.y"
{ newcon(yypvt[-5].asid, yypvt[-2].asexp); } break;
case 11:
# line 28 "parse.y"
{ newcon(yypvt[-6].asid, yypvt[-1].asexp); } break;
case 12:
# line 30 "parse.y"
{ newdef(yypvt[-6].asid, (exp) 0, yypvt[-1].asexp, 0); } break;
case 13:
# line 33 "parse.y"
{ newdef(yypvt[-7].asid, yypvt[-3].asexp, yypvt[-1].asexp, yypvt[-4].asint); } break;
case 14:
# line 35 "parse.y"
{ newcon(yypvt[-6].asid, yypvt[-3].asexp); } break;
case 15:
# line 37 "parse.y"
{ newdef(yypvt[-6].asid, (exp) 0, yypvt[-3].asexp, 0); } break;
case 16:
# line 39 "parse.y"
{ newdef(yypvt[-7].asid, yypvt[-1].asexp, yypvt[-4].asexp, yypvt[-2].asint); } break;
case 17:
# line 40 "parse.y"
{ recover(); } break;
case 18:
# line 43 "parse.y"
{ opencon(); } break;
case 19:
# line 46 "parse.y"
{ closecon(); } break;
case 20:
# line 49 "parse.y"
{ yyval.asint = 0; } break;
case 21:
# line 50 "parse.y"
{ yyval.asint = 1; } break;
case 22:
# line 53 "parse.y"
{ yyval.asexp = oneexp(0); } break;
case 23:
# line 54 "parse.y"
{ yyval.asexp = oneexp(1); } break;
case 24:
# line 55 "parse.y"
{ yyval.asexp = call(yypvt[-0].asexp, (args) 0, 0); } break;
case 25:
# line 56 "parse.y"
{ yyval.asexp = call(yypvt[-2].asexp, (args) 0, 1); } break;
case 26:
# line 57 "parse.y"
{ yyval.asexp = call(yypvt[-3].asexp, yypvt[-1].asargs, 1); } break;
case 27:
# line 58 "parse.y"
{ yyval.asexp = appl(yypvt[-2].asexp, yypvt[-0].asexp); } break;
case 28:
# line 59 "parse.y"
{ yyval.asexp = closeabs(yypvt[-1].asexp, yypvt[-0].asexp); } break;
case 29:
# line 62 "parse.y"
{ yyval.asexp = openabs(yypvt[-3].asid, yypvt[-1].asexp); } break;
case 30:
# line 65 "parse.y"
{ yyval.asargs = newlist((args) 0, yypvt[-0].asexp); } break;
case 31:
# line 66 "parse.y"
{ yyval.asargs = newlist(yypvt[-2].asargs, yypvt[-0].asexp); } break;
case 32:
# line 69 "parse.y"
{ yyval.asexp = findsym(yypvt[-0].asid); } break;
case 33:
# line 70 "parse.y"
{ yyval.asexp = findexp(yypvt[-1].aspar, yypvt[-3].asid); } break;
case 34:
# line 73 "parse.y"
{ yyval.aspar = curpar; } break;
case 35:
# line 74 "parse.y"
{ yyval.aspar = superpar(yypvt[-0].asid); } break;
case 36:
# line 75 "parse.y"
{ yyval.aspar = subpar(yypvt[-2].aspar, yypvt[-0].asid); } break;
		}
		goto yystack;  /* stack new state and value */

	}
