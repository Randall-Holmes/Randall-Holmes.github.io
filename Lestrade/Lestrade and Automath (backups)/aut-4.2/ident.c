/* idvalues are initialized to 0
only call [sg]etidvalue on char *'s returned by ident */

#include <stdlib.h>
#include <stdio.h>
#include "aut.h"

#define HASHMODULUS 1997
  /* lekker puh */

char **identhash;
char *otherbuf;
int otherlen;

void
initident()
{
  int i;

  identhash = (char **) malloc(HASHMODULUS * sizeof(char *));
  if (!identhash)
  {
    (void) fprintf(stderr, "no memory for identifier hash table, needs %d kilobytes\n",
      (HASHMODULUS * sizeof(char *) + (1 << 10) - 1) >> 10);
    outofmem();
  }
  for (i = 0; i < HASHMODULUS; i++)
    identhash[i] = 0;
  otherlen = 10;
  otherbuf = alloc(otherlen);
}

char *
ident(s)
  char *s;
{
  int h, n;
  char c, *p, *q, *r, *t;

  h = 0;
  for (p = s; *p; p++)
    h += (h << 4) + *p + 1;
  h = (unsigned) h % HASHMODULUS;
  for (r = identhash[h]; r; r = *((char **) r))
  {
    p = s;
    q = t = r + 2 * sizeof(char *);
    while ((c = *p++) == *q++)
      if (!c)
        return t;
  }
  n = 0;
  for (p = s; *p; p++)
    n++;
  r = alloc(2 * sizeof(char *) + n + 1);
  *((char **) r) = identhash[h];
  identhash[h] = r;
  *((char **) (r + sizeof(char *))) = 0;
  p = s;
  q = t = r + 2 * sizeof(char *); 
  while (*p)
    *q++ = *p++;
  *q = 0;
  return t;
}

void
setidvalue(s, x)
  char *s, *x;
{
  *((char **) (s - sizeof(char *))) = x;
}

char *
getidvalue(s)
  char *s;
{
  return *((char **) (s - sizeof(char *)));
}

char *
other(s)
  char *s;
{
  char *p, *q;
  int n;

  n = 0;
  for (p = s; *p; p++)
    n++;
  if (n + 2 > otherlen)
  {
    otherlen = otherlen * 2;
    if (n + 2 > otherlen)
      otherlen = n + 2;
    otherbuf = alloc(otherlen);
  }
  for (p = s, q = otherbuf; *q = *p++; q++)
    ;
  *q++ = '\'';
  *q = 0;
  mayrestore = 0;
  return ident(otherbuf);
}
