#include <stdio.h>
#include <stdlib.h>
#include "aut.h"

int limitreductions, reductionsleft; /* Grundlagen needs 74 for t10"-8286" */

int
checktype(body, type)
  exp body, type;
{
  exp t;
  int h, n, m;

  CHECK(body && type);
  n = degree(body);
  CHECK(n);
  if (n <= 1)
  {
    error();
    (void) fprintf(stderr, "type error: \"");
    (void) fprintexp(stderr, body);
    (void) fprintf(stderr, "\" does not have a type, != ");
    (void) fprintexp(stderr, type);
    (void) fprintf(stderr, "\n");
    return 0;
  }
  m = degree(type);
  CHECK(m);
  t = auttype(body);
  CHECK(t);
  h = (n == m + 1);
  if (h)
  {
    limitreductions = FLAG('n');
    if (limitreductions)
      reductionsleft = PARAMETER('n');
    h = same(t, type);
    if (!h && !FLAG('e'))
    {
      if (limitreductions)
        reductionsleft = PARAMETER('n');
      mayeta = 1;
      h = same(t, type);
      mayeta = 0;
    }
    limitreductions = 0;
  }
  if (!h)
  {
    error();
    (void) fprintf(stderr, "type error: ");
    (void) fprintexp(stderr, body);
    (void) fprintf(stderr, ": ");
    (void) fprintexp(stderr, t);
    (void) fprintf(stderr, " != ");
    (void) fprintexp(stderr, type);
    (void) fprintf(stderr, "\n");
    return 0;
  }
  return 1;
}

int
checkargs(c, a)
  con c;
  args a;
{
  if (a)
  {
    CHECK(c);
    return checkargs(c->back, a->prev) && checktype(a->arg, substcon(a->prev, c->back, c->type));
  }
  else
  {
    CHECK(!c);
    return 1;
  }
}

int
checkdomain(fun, arg)
  exp fun, arg;
{
  exp dom;

  CHECK(fun && arg);
  dom = domain(fun);
  if (!dom)
  {
    error();
    (void) fprintf(stderr, "expression is not a function: ");
    (void) fprintexp(stderr, fun);
    (void) fprintf(stderr, "\n");
    return 0;
  }
  return checktype(arg, dom);
}

int
checkdegree(e, from, to)
  exp e;
  int from, to;
{
  int n;

  CHECK(e);
  n = degree(e);
  if (n < from || n > to)
  {
    error();
    (void) fprintf(stderr, "expression should have degree ");
    if (from != to)
      (void) fprintf(stderr, "%d or %d: ", from, to);
    else
      (void) fprintf(stderr, "%d: ", from);
    (void) fprintexp(stderr, e);
    (void) fprintf(stderr, "\n");
    return 0;
  }
  return 1;
}

int
check(e)
  exp e;
{
  int ok;
  args a;

  ok = 1;
  if (e)
  {
    switch (e->kind)
    {
    case ONE:
    case VAR:
      break;
    case CON:
      if (!((con) e)->type)
        ok = 0;
      break;
    case TERM:
      if (((term) e)->fun->type == 0)
        ok = 0;
      for (a = ((term) e)->arglist; a; a = a->prev)
        if (!check(a->arg) || !checkdegree(a->arg, 2, 3))
	  ok = 0;
      ok = ok && checkargs(((term) e)->fun->back, ((term) e)->arglist);
      break;
    case APP:
      if (!check(((app) e)->fun) || !check(((app) e)->arg))
        ok = 0;
      ok = ok && checkdegree(((app) e)->arg, 3, 3);
      ok = ok && checkdomain(((app) e)->fun, ((app) e)->arg);
      break;
    case ABST:
      if (!check(((abst) e)->type) || !check(((abst) e)->body))
        ok = 0;
      ok = ok && checkdegree(((abst) e)->type, 2, 2);
      if (degree(((abst) e)->body) == 1 && !FLAG('a'))
      {
        error();
	(void) fprintf(stderr, "illegal abstraction of degree one: ");
	(void) fprintexp(stderr, e);
        (void) fprintf(stderr, "\n");
	ok = 0;
      }
      break;
    default:
      WRONG();
    }
  }
  else
    WRONG();
  return ok;
}
