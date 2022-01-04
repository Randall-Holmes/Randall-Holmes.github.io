#include <stdio.h>
#include <stdlib.h>
#include "aut.h"

int newones = 1, contexting, curconvalid;

void
markitem(d)
  item d;
{
  if (!d->echo)
  {
    d->echo = 1;
    newones = 1;
  }
}

void
scanexp(e)
  exp e;
{
  args a;

  if (e)
    switch (e->kind)
    {
    case TERM:
      markitem(((term) e)->fun);
      for (a = ((term) e)->arglist; a; a = a->prev)
        scanexp(a->arg);
      break;
    case APP:
      scanexp(((app) e)->fun);
      scanexp(((app) e)->arg);
      break;
    case ABST:
      scanexp(((abst) e)->type);
      scanexp(((abst) e)->body);
      break;
    }
}

void
cleanpars(p)
  par p;
{
  for (; p; p = p->prev)
  {
    p->first = 0;
    p->last = 0;
    cleanpars(p->sub);
  }
}

int
contains(p, q)
  par p, q;
{
  while (1)
  {
    if (p == q)
      return 1;
    if (!q)
      return 0;
    q = q->super;
  }
}

int
fchangepar(F, p, q)
  FILE *F;
  par p, q;
{
  int n;

  n = 0;
  if (p != q)
  {
    n += fchangepar(F, p, q->super);
    n += fprintf(F, "+%s%s\n", q->last ? (curconvalid = 0, "*") : "", q->id);
    openpar(q->id, 1);
  }
  return n;
}

int
fprintitem(F, d)
  FILE *F;
  item d;
{
  par p;
  int n;

  n = 0;
  p = d->where;
  if (p != curpar)
  {
    if (contexting)
      n += fprintf(F, "\n");
    while (!contains(curpar, p))
    {
      n += fprintf(F, "-%s\n", curpar->id);
      closepar((char *) 0);
    }
    if (curpar != p)
      n += fchangepar(F, curpar, p);
    contexting = 0;
  }
  if (!curconvalid || d->back != curcon)
  {
    curcon = d->back;
    if (curcon)
      n += fprintsym(F, (exp) curcon);
    n += fprintf(F, "@");
    curconvalid = 1;
  }
  opencon();
  switch (d->kind)
  {
  case DEF:
    if (contexting)
      n += fprintf(F, "\n");
    n += fprintf(F, "%s:=", d->id);
    if (((def) d)->body)
      n += fprintexp(F, ((def) d)->body);
    else
      n += fprintf(F, "PRIM");
    n += fprintf(F, ":");
    n += fprintexp(F, d->type);
    n += fprintf(F, "\n");
    contexting = 0;
    break;
  case CON:
    n += fprintf(F, "[%s:", d->id);
    n += fprintexp(F, d->type);
    n += fprintf(F, "]");
    contexting = 1;
    curcon = (con) d;
    break;
  default:
    WRONG();
  }
  closecon();
  finalclosecon();
  return n;
}

int
printecho(F)
  FILE *F;
{
  item d, e;
  int n;

  n = 0;
  cleanpars(toplist);
  curconvalid = 1;
  contexting = 0;
  for (d = firstitem; d; d = d->forth)
    if (d->echo)
    {
      n += fprintitem(F, d);
      if (curpar)
      {
        e = curpar->last;
        d->prev = e;
        if (e)
          e->next = d;
        else
          curpar->first = d;
        curpar->last = d;
      }
      d->next = 0;
      savevalue(d->id, (char *) d);
      yield();
    }
  while (curpar)
  {
    n += fprintf(F, "-%s\n", curpar->id);
    closepar((char *) 0);
  }
  return n;
}

void
excerpt()
{
  item d;
  con e;

  while (newones)
  {
    newones = 0;
    for (d = firstitem; d; d = d->forth)
      if (d->echo == 1)
      {
        if (d->kind == DEF)
	{
	  for (e = d->back; e; e = e->back)
	    markitem((item) e);
	  scanexp(((def) d)->body);
	}
	scanexp(d->type);
	d->echo = 2;
	yield();
      }
  }
  (void) printecho(stdout);
}

void
everything()
{
  item d;

  for (d = firstitem; d; d = d->forth)
    d->echo = 2;
  (void) printecho(stdout);
}
