typedef struct par *par; /* 0 means "cover" */
typedef struct item *item;

struct par
{
  char *id;
  par super, sub, prev;
  item first, last;
};

#define ONE 1
#define DEF 2
#define CON 3
#define TERM 4
#define APP 5
#define ABST 6
#define VAR 7

typedef struct exp *exp;
typedef struct one *one;
typedef struct def *def;
typedef struct con *con;
typedef struct term *term;
typedef struct args *args;
typedef struct app *app;
typedef struct abst *abst;
typedef struct var *var;

struct exp
{
  short kind;
};

struct one
{
  short kind; /* 1 */
  char *id;
  short code;
};

struct item
{
  short kind; /* 2 or 3 */
  char *id;
  exp type;
  short deg, code;
  con back;
  par where;
  item prev, next, forth;
  short echo;
};

struct def
{
  short kind; /* 2 */
  char *id;
  exp type;
  short deg, code;
  con back;
  par where;
  item prev, next, forth;
  short echo;
  exp body; /* 0 means "PN" */
  int seq;
};

struct con
{
  short kind; /* 3 */
  char *id;
  exp type;
  short deg, code;
  con back;
  par where;
  item prev, next, forth;
  short echo;
  exp ref;
  args implicit;
};

struct term
{
  short kind; /* 4 */
  def fun;
  args arglist;
};

struct args
{
  exp arg;
  args prev;
};

struct app
{
  short kind; /* 5 */
  exp fun, arg;
};

struct abst
{
  short kind; /* 6 */
  char *id;
  exp type, body;
  abst ref;
  var clone;
};

struct var
{
  short kind; /* 7 */
  abst lambda;
};

/* */

typedef union
{
  int asint;
  char *asid;
  par aspar;
  exp asexp;
  args asargs;
} YYSTYPE;

extern YYSTYPE yylval;

extern int yylex();
extern int yyparse();
#undef yywrap
extern int yywrap();
extern int yyerror();

extern int line, cdepth;
extern int flag[], parameter[];
#define FLAG(x) flag[(unsigned) x]
#define PARAMETER(x) parameter[(unsigned) x]
#define HASPROP() FLAG('p')

extern char *ident();
extern par curpar;
extern par superpar();
extern par subpar();
extern void yield();
extern void openpar();
extern void closepar();
extern void setcon();
extern void newcon();
extern void newdef();
extern void opencon();
extern void closecon();
extern void finalclosecon();
extern void recover();
extern exp oneexp();
extern exp call();
extern exp appl();
extern exp openabs();
extern exp closeabs();
extern exp findsym();
extern exp findexp();
extern args newlist();

/* */

typedef struct value *value;
struct value
{
  char *id, *oldvalue;
  value prev;
};

#ifdef NOCHECK
#define WRONG()
#define CHECK(condition)
#else
#define WRONG() \
  (error(), \
  (void) fprintf(stderr, "\nfile \"%s\"; line %d # program error\n", __FILE__, __LINE__), \
  exit(2))
#define CHECK(condition) ((condition) || (WRONG(), 1))
#endif

#define ALLOC(x) (x) alloc(sizeof(struct x))
#define STDSUM (FLAG('z') ? stdout : stderr)

extern char *yytext; /* with the original lex this should be: "extern char yytext[];"! */

extern int mayrestore;
extern void outofmem();
extern void savemem();
extern void restoremem();
extern void initalloc();
extern void exitalloc();
extern char *alloc();
extern void initident();
extern char *getidvalue();
extern void setidvalue();
extern char *other();
extern void error();
extern par toplist;
extern int fprintpar();
extern int fprintrelpar();
extern void initpar();
extern void exitpar();
extern void inititem();
extern void exititem();
extern int inbody;
extern con curcon;
extern item firstitem;
extern void savevalue();
extern void mark();
extern void restorevalue();
extern char *restoretomark();
extern void initexp();
extern term newterm();
extern var absframe();
extern int occurs();
extern int fprintexp();
extern int fprintsym();
extern exp substvar();
extern exp substcon();
extern exp auttype();
extern int degree();
extern int flavor();
extern int mayeta;
extern int limitreductions, reductionsleft;
extern void initsame();
extern void exitsame();
extern int beta();
extern int delta();
extern int same();
extern int checktype();
extern int checkdegree();
extern int check();
extern exp domain();
extern void excerpt();
extern void everything();
extern void deltalambda();
