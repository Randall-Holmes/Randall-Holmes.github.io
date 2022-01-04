/*
  exit status
    0: correct automath book
    1: incorrect automath book (either syntax or typing)
    2: incorrect usage, problems reading or writing files or user abort
    3: insufficient address space or memory
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <signal.h>
#include <setjmp.h>
#include "aut.h"

#ifdef macintosh
#include <CursorCtl.h>
#endif

#define COMPOUNDFLAGS "QZ"
#define LEGALFLAGS "abcdefilmopqrsvyz"
#define PARAMETERFLAGS "gkntx"
int flag[256], parameter[256];

int line, cdepth, errorcount, aborted;
char *progname, *filename = "-", **files;
jmp_buf env;

void
yield()
{
#ifdef macintosh
  SpinCursor(1);
#endif
}

void
error()
{
  (void) fflush(stdout);
  (void) fprintf(stderr, "file \"%s\"; line %d # ", filename, line);
  errorcount++;
}

void
sighandler(sig)
  int sig;
{
  error();
  (void) fprintf(stderr, "aborted in paragraph \"");
  (void) fprintpar(stderr, curpar);
  (void) fprintf(stderr, "\" with signal %d\n", sig);
  longjmp(env, 1);
}

int
yyerror(message)
  char *message;
{
  error();
  (void) fprintf(stderr, "%s: unexpected \"%s\"\n", message, yytext);
  return 0;
}

int
yywrap()
{
  char *s;

  if (*files)
  {
    filename = *files++;
    if (!freopen(filename, "r", stdin) &&
        !freopen((sprintf(s = alloc(strlen(filename) + 5), "%s.aut", filename), filename = s),
	  "r", stdin))
    {
      (void) fprintf(stderr, "%s: no such file\n", filename);
      exit(2);
    }
    line = 1;
    return 0;
  }
  if (cdepth)
  {
    error();
    (void) fprintf(stderr, "book ends inside comment, nested braces: %d\n", cdepth);
  }
  return 1;
}

void
usage()
{
  (void) fprintf(stderr, "usage: %s [-%s] [-%s] [-%s parameters] [--] [files]\n",
    progname, COMPOUNDFLAGS, LEGALFLAGS, PARAMETERFLAGS);
  exit(2);
}

int
main(argc, argv)
  int argc;
  char **argv;
{
  int i, b, c, n;
  char *s, *t;
  time_t start;

  (void) signal(SIGINT, &sighandler);
#ifdef macintosh
  InitCursorCtl(0);
#endif

  progname = *argv;
  PARAMETER('k') = 1;
  for (i = 1; i < argc && (s = argv[i]) && *s++ == '-'; i++)
  {
    b = 0;
    for (; c = *s; s++)
    {
      for (t = COMPOUNDFLAGS; *t; t++)
	if (c == *t)
	  break;
      if (*t)
      {
        FLAG(c)++;
	switch (c)
	{
	case 'Q':
	  t = "acopqs";
	  break;
	case 'Z':
	  t = "dlmrv";
	  break;
	default:
	  WRONG();
	}
	for (; *t; t++)
	  FLAG(*t)++;
      }
      else
      {
        for (t = LEGALFLAGS; *t; t++)
	  if (c == *t)
	    break;
        if (*t)
          FLAG(c)++;
	else
	{
          for (t = PARAMETERFLAGS; *t; t++)
	    if (c == *t)
	      break;
          if (*t)
          {
            FLAG(c)++;
	    if (++i < argc)
	    {
	      for (t = argv[i]; *t; t++)
	        if (*t < '0' || *t > '9')
	          usage();
	      PARAMETER(c) = atoi(argv[i]);
	    }
	    else
	      usage();
          }
	  else
            if (c == '-')
              b = 1;
            else
	      usage();
        }
      }
    }
    if (b)
    {
      i++;
      break;
    }
  }
  if (FLAG('d'))
    start = time(0);
  initalloc();
  initident();
  initpar();
  inititem();
  initexp();
  initsame();
  cdepth = 0;
  line = 1;
  files = argv + i;
  (void) yywrap(); /* open first file */
  errorcount = 0;
  aborted = 0;
  if (setjmp(env) == 0)
    (void) yyparse();
  else
  {
    aborted = 1;
    curpar = 0;
  }
  exitsame();
  exititem();
  exitpar();
  if (!errorcount)
  {
    if (FLAG('x'))
      excerpt();
    if (FLAG('y'))
      everything();
    if (FLAG('g'))
      deltalambda();
  }
  exitalloc();
  if (FLAG('d'))
  {
    n = difftime(time(0), start);
    (void) fprintf(STDSUM, "%d seconds = %d minutes %d seconds\n", n, n / 60, n % 60);
  }
  if (FLAG('v'))
    (void) fprintf(STDSUM, "aut 4.2, (c) 1997 by satan software\n");
  return aborted ? 2 : errorcount ? 1 : 0;
}
