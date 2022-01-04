#include <stdlib.h>
#include <stdio.h>
#include "aut.h"

extern int recfprintexp();

int
fprintsym(F, e)
  FILE *F;
  exp e;
{
  int n;
  char *id;
  par p;

  CHECK(e && (e->kind == CON || e->kind == DEF));
  id = ((item) e)->id;
  n = 0;
  if ((exp) getidvalue(id) == e)
    n += fprintf(F, "%s", id);
  else
  {
    p = ((item) e)->where;
    if (findexp(p, id) == e)
    {
      n += fprintf(F, "%s\"", id);
      n += fprintrelpar(F, p, curpar);
      n += fprintf(F, "\"");
    }
    else
    {
      n += fprintf(F, "{%s\"", id);
      n += fprintrelpar(F, p, curpar);
      n += fprintf(F, "\"}");
    }
  }
  return n;
}

int
fprintargs(F, a, b)
  FILE *F;
  args a, b;
{
  int n;

  n = 0;
  if (a)
  {
    if (a != b)
    {
      n += fprintargs(F, a->prev, b);
      n += fprintf(F, ",");
    }
    n += recfprintexp(F, a->arg);
  }
  return n;
}

int
recfprintexp(F, e)
  FILE *F;
  exp e;
{
  int n;
  args a, b;
  con c;
  char *id, *oldvalue;

  n = 0;
  if (!e)
    n += fprintf(F, "{???}");
  else
    switch (e->kind)
    {
    case ONE:
      n += fprintf(F, "%s", ((one) e)->id);
      break;
    case CON:
      n += fprintsym(F, e);
      break;
    case DEF:
      n += fprintf(F, "{");
      n += fprintsym(F, e);
      n += fprintf(F, "}");
      break;
    case TERM:
      n += fprintsym(F, ((term) e)->fun);
      b = 0;
      switch (PARAMETER('k'))
      {
      case 0:
        for (a = ((term) e)->arglist, c = ((term) e)->fun->back; a && c; a = a->prev, c = c->back)
	  if (a->arg != (exp) c)
	    b = a;
	break;
      case 1:
        for (a = ((term) e)->arglist, c = ((term) e)->fun->back; a && c; a = a->prev, c = c->back)
	  if (a != c->implicit)
	    b = a;
        break;
      case 2:
      default:
        for (a = ((term) e)->arglist; a; a = a->prev)
	  b = a;
      }
      if (b)
      {
        n += fprintf(F, "(");
        n += fprintargs(F, ((term) e)->arglist, b);
        n += fprintf(F, ")");
      }
      break;
    case APP:
      n += fprintf(F, "<");
      n += recfprintexp(F, ((app) e)->arg);
      n += fprintf(F, ">");
      n += recfprintexp(F, ((app) e)->fun);
      break;
    case ABST:
      id = ((abst) e)->id;
      if (FLAG('i'))
        n += fprintf(F, "{%08X}", e);
      n += fprintf(F, "[%s,", id);
      n += recfprintexp(F, ((abst) e)->type);
      n += fprintf(F, "]");
      oldvalue = getidvalue(id);
      setidvalue(id, (char *) 0);
      n += recfprintexp(F, ((abst) e)->body);
      setidvalue(id, oldvalue);
      break;
    case VAR:
      if (FLAG('i'))
        n += fprintf(F, "{%08X}", ((var) e)->lambda);
      n += fprintf(F, "%s", ((var) e)->lambda->id);
      break;
    default:
      n += fprintf(F, "{{%d}}", e->kind);
    }
  return n;
}

int
occurs(e, l)
  exp e;
  abst l;
{
  args a;

  if (e)
    switch (e->kind)
    {
    case TERM:
      for (a = ((term) e)->arglist; a; a = a->prev)
        if (occurs(a->arg, l))
	  return 1;
      return 0;
      break;
    case APP:
      return occurs(((app) e)->fun, l) || occurs(((app) e)->arg, l);
      break;
    case ABST:
      return occurs(((abst) e)->type, l) || occurs(((abst) e)->body, l);
      break;
    case VAR:
      return ((var) e)->lambda == l;
      break;
    }
  return 0;
}

int
abstclash(e, l)
  exp e;
  abst l;
{
  args a;

  if (e)
    switch (e->kind)
    {
    case TERM:
      for (a = ((term) e)->arglist; a; a = a->prev)
        if (abstclash(a->arg, l))
	  return 1;
      return 0;
      break;
    case APP:
      return abstclash(((app) e)->fun, l) || abstclash(((app) e)->arg, l);
      break;
    case ABST:
      if (((abst) e)->id == l->id)
        return occurs(((abst) e)->body, l);
      else
        return abstclash(((abst) e)->type, l) || abstclash(((abst) e)->body, l);
      break;
    }
  return 0;
}

void
alpha(e)
  exp e;
{
  args a;
  abst l;

  if (e)
    switch (e->kind)
    {
    case TERM:
      for (a = ((term) e)->arglist; a; a = a->prev)
        alpha(a->arg);
      break;
    case APP:
      alpha(((app) e)->fun);
      alpha(((app) e)->arg);
      break;
    case ABST:
      l = (abst) e;
      while (abstclash(l->body, l))
        l->id = other(l->id);
      alpha(l->type);
      alpha(l->body);
      break;
    }
}

int
fprintexp(F, e)
  FILE *F;
  exp e;
{
  alpha(e);
  return recfprintexp(F, e);
}
