#include <stdio.h>
#include <stdlib.h>
#include "aut.h"

#define SUB(p) (p ? p->sub : toplist)

par curpar = 0, toplist = 0;

int
fprintpar(F, p)
  FILE *F;
  par p;
{
  int n;

  if (p)
  {
    if (p->super)
    {
      n = fprintpar(F, p->super);
      return n + fprintf(F, "-%s", p->id);
    }
    else
      return fprintf(F, "%s", p->id);
  }
  else
    return fprintf(F, "{cover}");
}

int
fprintrelpar(F, p, q)
  FILE *F;
  par p, q;
{
  par r;
  int n;

  if (p == q)
    return 0;
  if (!p)
    return fprintf(F, "{cover}");
  for (r = q; r; r = r->super)
    if (r == p)
      break;
  if (r)
    return fprintf(F, "%s", p->id);
  n = fprintrelpar(F, p->super, q);
  return n + fprintf(F, "-%s", p->id);
}

void
initpar()
{
  mark((char *) curcon);
}

void
exitpar()
{
  if (curpar)
  {
    error();
    (void) fprintf(stderr, "book doesn't end at cover: \"");
    (void) fprintpar(stderr, curpar);
    (void) fprintf(stderr, "\"\n");
    while (curpar)
    {
      curpar = curpar->super;
      setcon((exp) restoretomark());
    }
  }
  setcon((exp) restoretomark());
}

par
superpar(id)
  char *id;
{
  par q;

  for (q = curpar; q; q = q->super)
    if (q->id == id)
      return q;
  error();
  (void) fprintf(stderr, "incorrect paragraph reference: \"%s\" in paragraph \"", id);
  (void) fprintpar(stderr, curpar);
  (void) fprintf(stderr, "\"\n");
  return curpar;
}

par
subpar(p, id)
  par p;
  char *id;
{
  par q;

  for (q = SUB(p); q; q = q->prev)
    if (q->id == id)
      return q;
  error();
  (void) fprintf(stderr, "incorrect paragraph reference: \"-%s\" in paragraph \"", id);
  (void) fprintpar(stderr, p);
  (void) fprintf(stderr, "\"\n");
  return p;
}

void
openpar(id, re)
  char *id;
  int re;
{
  par q;
  item d;

  for (q = SUB(curpar); q; q = q->prev)
    if (q->id == id)
    {
      if (!re && FLAG('s'))
      {
        error();
        (void) fprintf(stderr, "opening old paragraph (should have star): \"%s\" in paragraph \"", id);
        (void) fprintpar(stderr, curpar);
        (void) fprintf(stderr, "\"\n");
      }
      curpar = q;
      mark((char *) curcon);
      for (d = curpar->first; d; d = d->next)
        savevalue(d->id, (char *) d);
      return;
    }
  if (re)
  {
    error();
    (void) fprintf(stderr, "reopening non-existing paragraph: \"%s\" in paragraph \"", id);
    (void) fprintpar(stderr, curpar);
    (void) fprintf(stderr, "\"\n");
  }
  for (q = curpar; q; q = q->super)
    if (q->id == id)
    {
      error();
      (void) fprintf(stderr, "duplicate nested identifiers: \"%s\" in paragraph \"", id);
      (void) fprintpar(stderr, curpar);
      (void) fprintf(stderr, "\"\n");
    }
  q = ALLOC(par);
  q->id = id;
  q->super = curpar;
  q->sub = 0;
  q->prev = SUB(curpar);
  if (curpar)
    curpar->sub = q;
  else
    toplist = q;
  q->first = q->last = 0;
  curpar = q;
  mark((char *) curcon);  
}

void
closepar(id)
  char *id;
{
  par q, r;

  if (id)
  {
    if (curpar && curpar->id == id)
    {
      curpar = curpar->super;
      setcon((exp) restoretomark());
    }
    else
    {
      error();
      (void) fprintf(stderr, "closing paragraph that's not open: \"%s\" in paragraph \"", id);
      (void) fprintpar(stderr, curpar);
      (void) fprintf(stderr, "\"\n");
      for (q = curpar; q; q = q->super)
        if (q->id == id)
	{
	  for (r = curpar; r != q; r = r->super)
	    setcon((exp) restoretomark());
          curpar = q;
	  break;
	}
    }
  }
  else
  if (curpar)
  {
    curpar = curpar->super;
    setcon((exp) restoretomark());
  }
  else
  {
    error();
    (void) fprintf(stderr, "closing paragraph with no paragraphs open\n");
  }
}
