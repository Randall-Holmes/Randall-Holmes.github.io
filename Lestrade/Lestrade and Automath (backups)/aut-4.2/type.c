#include <stdio.h>
#include <stdlib.h>
#include "aut.h"

extern exp fillexp();

args
substargs(d, l, a)
  exp d;
  abst l;
  args a;
{
  args b;
  exp c;

  if (a)
  {
    b = substargs(d, l, a->prev);
    c = substvar(d, l, a->arg);
    if (b != a->prev || c != a->arg)
      return newlist(b, c);
  }
  return a;
}

exp
substvar(d, l, e)
  exp d;
  abst l;
  exp e;
{
  exp f, g;
  args a;
  var c;

  if (e)
    switch (e->kind)
    {
    case TERM:
      a = substargs(d, l, ((term) e)->arglist);
      if (a != ((term) e)->arglist)
        return (exp) newterm(((term) e)->fun, a);
      break;
    case APP:
      f = substvar(d, l, ((app) e)->fun);
      g = substvar(d, l, ((app) e)->arg);
      if (f != ((app) e)->fun || g != ((app) e)->arg)
        return appl(g, f);
      break;
    case ABST:
      f = substvar(d, l, ((abst) e)->type);
      CHECK(!((abst) e)->clone);
      c = absframe(((abst) e)->id, f);
      ((abst) e)->clone = c;
      g = substvar(d, l, ((abst) e)->body);
      ((abst) e)->clone = 0;
      if (f != ((abst) e)->type || g != ((abst) e)->body)
      {
        e = (exp) ((var) c)->lambda;
	((abst) e)->body = g;
	return e;
      }
      break;
    case VAR:
      if (((var) e)->lambda == l)
        return d;
      c = ((var) e)->lambda->clone;
      if (c)
        return (exp) c;
      break;
    }
  else
    WRONG();
  return e;
}

abst
wireabst(e, type, body)
  abst e;
  exp type, body;
{
  var d;
  abst l;

  d = absframe(e->id, type);
  l = d->lambda;
  l->body = substvar((exp) d, e, body);
  return l;
}

args
fillargs(a)
  args a;
{
  args b;
  exp c;

  if (a)
  {
    b = fillargs(a->prev);
    c = fillexp(a->arg);
    if (b != a->prev || c != a->arg)
      return newlist(b, c);
  }
  return a;
}

exp
fillexp(e)
  exp e;
{
  exp f, g;
  args a;

  if (e)
    switch (e->kind)
    {
    case CON:
      e = ((con) e)->ref;
      CHECK(e);
      break;
    case TERM:
      a = fillargs(((term) e)->arglist);
      if (a != ((term) e)->arglist)
        return (exp) newterm(((term) e)->fun, a);
      break;
    case APP:
      f = fillexp(((app) e)->fun);
      g = fillexp(((app) e)->arg);
      if (f != ((app) e)->fun || g != ((app) e)->arg)
        return appl(g, f);
      break;
    case ABST:
      f = fillexp(((abst) e)->type);
      g = fillexp(((abst) e)->body);
      if (f != ((abst) e)->type || g != ((abst) e)->body)
        return (exp) wireabst((abst) e, f, g);
      break;
    }
  return e;
}

exp
substcon(a, c, e)
  args a;
  con c;
  exp e;
{
  args b;
  con d;
  exp f;

  for (b = a, d = c; b && d; b = b->prev, d = d->back)
  {
    CHECK(!d->ref);
    d->ref = b->arg;
  }
  CHECK(!b && !d);
  f = fillexp(e);
  for (d = c; d; d = d->back)
  {
    CHECK(d->ref);
    d->ref = 0;
  }
  return f;
}

exp
auttype(e)
  exp e;
{
  exp d;

  if (e)
    switch (e->kind)
    {
    case CON:
      return ((con) e)->type;
      break;
    case TERM:
      return substcon(((term) e)->arglist, ((term) e)->fun->back, ((term) e)->fun->type);
      break;
    case APP:
      return appl(((app) e)->arg, auttype(((app) e)->fun));
      break;
    case ABST:
      d = auttype(((abst) e)->body);
      if (d->kind == ONE && FLAG('b'))
        return d;
      else
        return (exp) wireabst((abst) e, ((abst) e)->type, d);
      break;
    case VAR:
      return ((var) e)->lambda->type;
      break;
    }
  WRONG();
  return 0;
}

int
degree(e)
  exp e;
{
  int n;

  n = 1;
  while (e)
    switch (e->kind)
    {
    case ONE:
      return n;
      break;
    case DEF:
    case CON:
      return n + ((item) e)->deg;
      break;
    case TERM:
      e = (exp) ((term) e)->fun;
      break;
    case APP:
      e = ((app) e)->fun;
      break;
    case ABST:
      e = ((abst) e)->body;
      break;
    case VAR:
      e = (exp) ((var) e)->lambda->type;
      n++;
      break;
    default:
      WRONG();
    }
  WRONG();
  return 0;
}

int
flavor(e)
  exp e;
{
  while (e)
    switch (e->kind)
    {
    case ONE:
      return ((one) e)->code;
      break;
    case DEF:
    case CON:
      return ((item) e)->code;
      break;
    case TERM:
      e = (exp) ((term) e)->fun;
      break;
    case APP:
      e = ((app) e)->fun;
      break;
    case ABST:
      e = ((abst) e)->body;
      break;
    case VAR:
      e = (exp) ((var) e)->lambda->type;
      break;
    default:
      WRONG();
    }
  WRONG();
  return 0;
}
