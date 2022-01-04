#include <stdio.h>
#include <stdlib.h>
#include "aut.h"

#define MAXTRACEINDENT 32
#define TRACE (trace && (!traceline || line == traceline))
#define TRACERETURN(r) if (TRACE) { closetrace(r); return r; } else return r

extern int delta();

int mayeta = 0, betacount = 0, deltacount = 0, etacount = 0, trace, traceline, depth;

void
initsame()
{
  trace = FLAG('t');
  if (trace)
    traceline = PARAMETER('t');
}

void
exitsame()
{
  if (FLAG('r'))
    (void) fprintf(STDSUM, "%d beta reductions, %d delta reductions, %d eta reductions\n",
      betacount, deltacount, etacount);
}

int
sameargs(a, b)
  args a, b;
{
  args c, d;

  if (a == b)
    return 1;
  for (c = a, d = b; c && d; c = c->prev, d = d->prev)
    if (!same(c->arg, d->arg))
      return 0;
  CHECK(!c && !d);
  return 1;
}

void
outofreductions()
{
  if (reductionsleft == -1)
  {
    if (TRACE)
      (void) fprintf(stdout, "*\n");
    if (FLAG('e') || mayeta)
    {
      error();
      (void) fprintf(stderr, "maximum number of reductions exceeded: type errors can be wrong\n");
    }
  }
}

int
beta(xe)
  exp *xe;
{
  exp e, f;

  e = *xe;
  CHECK(e->kind == APP);
  f = ((app) e)->fun;
  while (1)
  {
    switch (f->kind)
    {
    case ABST:
      break;
    case APP:
      if (beta(&f))
        continue;
      return 0;
      break;
    case TERM:
      if (delta(&f))
        continue;
      return 0;
      break;
    default:
      return 0;
    }
    break;
  }
  CHECK(f->kind == ABST);
  yield();
  if (limitreductions && reductionsleft-- <= 0)
  {
    outofreductions();
    return 0;
  }
  betacount++;
  *xe = substvar(((app) e)->arg, (abst) f, ((abst) f)->body);
  return 1;
}

int
delta(xe)
  exp *xe;
{
  exp e, b;
  def f;
  
  e = *xe;
  CHECK(e->kind == TERM);
  f = ((term) e)->fun;
  b = f->body;
  if (b)
  {
    yield();
    if (limitreductions && reductionsleft-- <= 0)
    {
      outofreductions();
      return 0;
    }
    deltacount++;
    *xe = substcon(((term) e)->arglist, f->back, b);
    return 1;
  }
  return 0;
}

int
eta(xe)
  exp *xe;
{
  abst e;
  exp f, g;

  CHECK(mayeta);
  CHECK(xe && (*xe)->kind == ABST);
  e = (abst) *xe;
  f = e->body;
  while (1)
  {
    switch (f->kind)
    {
    case ABST:
      if (eta(&f))
        continue;
      return 0;
      break;
    case APP:
      g = ((app) f)->arg;
      if (g->kind == VAR && ((var) g)->lambda == e && !occurs(((app) f)->fun, e))
        break;
      if (beta(&f))
        continue;
      return 0;
      break;
    case TERM:
      if (delta(&f))
        continue;
      return 0;
      break;
    default:
      return 0;
    }
    break;
  }
  CHECK(f->kind == APP);
  yield();
  if (limitreductions && reductionsleft-- <= 0)
  {
    outofreductions();
    return 0;
  }
  etacount++;
  *xe = ((app) f)->fun;
  return 1;
}

void
opentrace(d, e, lastred)
  exp d, e;
  char *lastred;
{
  (void) fprintf(stdout, "%*s", (depth - 1) % MAXTRACEINDENT, "");
  (void) fprintexp(stdout, d);
  (void) fprintf(stdout, " ?= ");
  (void) fprintexp(stdout, e);
  if (*lastred)
    (void) fprintf(stdout, " {:%s}", lastred);
  (void) fprintf(stdout, "\n");
  (void) fflush(stdout);
}

void
closetrace(r)
  int r;
{
  depth--;
  (void) fprintf(stdout, "%*s%s\n", depth % MAXTRACEINDENT, "", r ? "+" : "-");
  (void) fflush(stdout);
}

int
same(d, e)
  exp d, e;
{
  abst l;
  int h;
  char *lastred;

  CHECK(d && e);
  if (d == e)
    return 1;
#if 1
  if (degree(d) != degree(e) || flavor(d) != flavor(e))
    return 0;
#endif
  if (TRACE)
    depth++;
  lastred = "";
  while (1)
  {
    if (TRACE)
      opentrace(d, e, lastred);
    lastred = "beta";
    if (d->kind == APP && beta(&d))
      continue;
    if (e->kind == APP && beta(&e))
      continue;
    lastred = "";
    if (d->kind == e->kind)
      switch (e->kind)
      {
      case ONE:
        TRACERETURN(1);
        break;
      case CON:
        TRACERETURN(d == e);
        break;
      case VAR:
        l = ((var) d)->lambda->ref;
        TRACERETURN((l ? l : ((var) d)->lambda) == ((var) e)->lambda);
        break;
      case TERM:
        if (((term) d)->fun == ((term) e)->fun && sameargs(((term) d)->arglist, ((term) e)->arglist))
          TRACERETURN(1);
        break;
      case APP:
        if (same(((app) d)->fun, ((app) e)->fun) && same(((app) d)->arg, ((app) e)->arg))
          TRACERETURN(1);
        break;
      case ABST:
        if (d == e)
          TRACERETURN(1);
        if (same(((abst) d)->type, ((abst) e)->type))
        {
          ((abst) d)->ref = (abst) e;
	  h = same(((abst) d)->body, ((abst) e)->body);
	  ((abst) d)->ref = 0;
	  if (h)
            TRACERETURN(1);
        }
        break;
      default:
        WRONG();
      }
    if (e->kind == ONE && d->kind == ABST && FLAG('q') && same(((abst) d)->body, e))
      TRACERETURN(1);
    lastred = "delta";
    if (d->kind == TERM)
    {
      if (e->kind == TERM)
      {
        if (((term) d)->fun->seq > ((term) e)->fun->seq)
	{
	  if (delta(&d) || delta(&e))
	    continue;
	}
	else
	{
	  if (delta(&e) || delta(&d))
	    continue;
	}
      }
      else
      if (delta(&d))
        continue;
    }
    if (e->kind == TERM && delta(&e))
      continue;
    lastred = "eta";
    if (d->kind == ABST && mayeta && eta(&d))
      continue;
    if (e->kind == ABST && mayeta && eta(&e))
      continue;
    break;
  }
  TRACERETURN(0);
}
