#include <stdio.h>
#include <stdlib.h>
#include "aut.h"

args errorargs;

void
initexp()
{
  errorargs = ALLOC(args);
  errorargs->prev = 0;
  errorargs->arg = 0;
}

term
newterm(fun, arglist)
  def fun;
  args arglist;
{
  term e;

  e = ALLOC(term);
  e->kind = TERM;
  e->fun = fun;
  e->arglist = arglist;
  return e;
}

exp
call(fun, arglist, iscall)
  exp fun;
  args arglist;
  int iscall;
{
  def f;
  con d;
  args a, b;

  if (!fun || arglist == errorargs)
    return 0;
  if (fun->kind == DEF)
  {
    f = (def) fun;
    b = 0;
    for (a = arglist, d = f->back; a && d; b = a, a = a->prev, d = d->back)
      ;
    if (a)
    {
      error();
      (void) fprintf(stderr, "function has too many arguments: \"%s\"\n", f->id);
      return 0;
    }
    if (d)
    {
      if (!d->ref)
      {
        error();
        (void) fprintf(stderr, "implicit variable not in context: \"%s\", of function \"%s\"\n",
	  d->id, f->id);
        return 0;
      }
      if (b)
        b->prev = d->implicit;
      else
        arglist = d->implicit;
    }
    return (exp) newterm(f, arglist);
  }
  else
  {
    if (iscall)
    {
      error();
      if (fun->kind == CON)
        (void) fprintf(stderr, "a variable can't have arguments: \"%s\"\n", ((con) fun)->id);
      else
      if (fun->kind == VAR)
        (void) fprintf(stderr, "a variable can't have arguments: \"%s\"\n", ((var) fun)->lambda->id);
      else
        WRONG();
    }
    CHECK(fun->kind == CON || fun->kind == VAR);
    return fun;
  }
}

exp
appl(arg, fun)
  exp arg, fun;
{
  app e;

  if (!arg || !fun)
    return 0;
  e = ALLOC(app);
  e->kind = APP;
  e->fun = fun;
  e->arg = arg;
  return (exp) e;
}

var
absframe(id, type)
  char *id;
  exp type;
{
  abst e;
  var d;

  e = ALLOC(abst);
  e->kind = ABST;
  e->id = id;
  e->type = type;
  e->body = 0;
  e->ref = 0;
  e->clone = 0;
  d = ALLOC(var);
  d->kind = VAR;
  d->lambda = e;
  return d;
}

exp
openabs(id, type)
  char *id;
  exp type;
{
  var d;

  d = absframe(id, type);
  savevalue(id, (char *) d);
  return (exp) d;
}

exp
closeabs(d, body)
  exp d, body;
{
  abst e;

  CHECK(d && d->kind == VAR);
  e = ((var) d)->lambda;
  CHECK(e && e->kind == ABST);
  CHECK(getidvalue(e->id) == (char *) d);
  restorevalue();
  CHECK(getidvalue(e->id) != (char *) d);
  if (!e->type || !body)
    return 0;
  CHECK(!e->body);
  e->body = body;
  return (exp) e;
}

args
newlist(prev, e)
  args prev;
  exp e;
{
  args a;

  if (prev == errorargs || !e)
    return errorargs;
  a = ALLOC(args);
  a->prev = prev;
  a->arg = e;
  return a;
}
