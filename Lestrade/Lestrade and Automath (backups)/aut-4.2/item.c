#include <stdio.h>
#include <stdlib.h>
#include "aut.h"

int inbody = 0, stillopen = 0, seq = 0, pncount = 0, defcount = 0, ebcount = 0;
con curcon = 0;
item curcover = 0, curitem = 0, firstitem = 0;
one typeone, propone;

void
inititem()
{
  typeone = ALLOC(one);
  typeone->kind = ONE;
  typeone->id = ident("TYPE");
  typeone->code = 0;
  propone = ALLOC(one);
  propone->kind = ONE;
  propone->id = ident("PROP");
  propone->code = 1;
}

void
exititem()
{
  if (FLAG('l'))
    (void) fprintf(STDSUM, "%d + %d = %d definitions, %d + %d = %d lines\n",
      pncount, defcount, pncount + defcount,
      ebcount, pncount + defcount, pncount + defcount + ebcount);
}

exp
oneexp(code)
  int code;
{
  one e;

  e = code ? propone : typeone;
  CHECK(e->code == code);
  return (exp) e;
}

void
pullargs(c)
  con c;
{
  if (c)
  {
    pullargs(c->back);
    savevalue(c->id, (char *) c);
  }
}

void
opencon()
{
  con c;

  if (FLAG('c'))
  {
    mark((char *) 0);
    pullargs(curcon); /* stack overflow? */
  }
  for (c = curcon; c; c = c->back)
    c->ref = (exp) c;
  inbody = 1;
  stillopen = 2;
}

void
closecon()
{
  con c;

  inbody = 0;
  for (c = curcon; c; c = c->back)
    c->ref = 0;
  /* delay restoretomark until just before the end of newcon/newdef, for fprintexp */
  stillopen = 1;
}

void
finalclosecon()
{
  char *e;

  if (FLAG('c'))
  {
    e = restoretomark();
    CHECK(e == 0);
  }
  stillopen = 0;
}

void
recover()
{
  switch (stillopen)
  {
  case 2:
    closecon();
  case 1:
    finalclosecon();
  }
}

void
setcon(c)
  exp c;
{
  if (c && c->kind != CON)
  {
    error();
    if (c->kind == DEF)
      (void) fprintf(stderr, "can't set context to a defined constant: \"%s\"\n", ((def) c)->id);
    else
      WRONG();
    curcon = 0;
  }
  else
    curcon = (con) c;
}

void
newcon(id, type)
  char *id;
  exp type;
{
  con c;
  item e;
  args a;

  for (c = curcon; c; c = c->back)
    if (c->id == id)
    {
      error();
      (void) fprintf(stderr, "duplicate variable identifier in context: \"%s\"\n", id);
    }
  c = ALLOC(con);
  c->kind = CON;
  c->id = id;
  c->back = curcon;
  c->where = curpar;
  if (curpar)
  {
    e = curpar->last;
    c->prev = e;
    if (e)
      e->next = (item) c;
    else
      curpar->first = (item) c;
    curpar->last = (item) c;
  }
  else
  {
    c->prev = curcover;
    curcover = (item) c;
  }
  c->next = 0;
  if (curitem)
    curitem->forth = (item) c;
  else
    firstitem = (item) c;
  curitem = (item) c;
  c->forth = 0;
  c->echo = 0;
  c->deg = 0;
  c->code = 0;
  c->ref = 0;
  a = ALLOC(args);
  a->prev = curcon ? curcon->implicit : 0;
  a->arg = (exp) c;
  c->implicit = a;
  savemem();
  if (!type || !check(type) || !checkdegree(type, 1, 2) || (curcon && !curcon->type))
  {
    c->type = 0;
    c->deg = 0;
    c->code = 0;
  }
  else
  {
    c->type = type;
    c->deg = degree(type);
    c->code = flavor(type);
  }
  restoremem();
  finalclosecon();
  e = (item) getidvalue(id);
  if (e)
  {
    CHECK(e->kind == CON || e->kind == DEF);
    if (e->where == curpar && e->kind == DEF)
    {
      error();
      (void) fprintf(stderr,
        "variable covers definition with same name on same level: \"%s\"\n", id);
    }
  }
  savevalue(id, (char *) c);
  curcon = c;
  ebcount++;
}

void
newdef(id, body, type, noexpand)
  char *id;
  exp body, type;
  int noexpand;
{
  def d;
  item e;

  d = ALLOC(def);
  d->kind = DEF;
  d->id = id;
  d->back = curcon;
  d->where = curpar;
  if (curpar)
  {
    e = curpar->last;
    d->prev = e;
    if (e)
      e->next = (item) d;
    else
      curpar->first = (item) d;
    curpar->last = (item) d;
  }
  else
  {
    d->prev = curcover;
    curcover = (item) d;
  }
  d->next = 0;
  if (curitem)
    curitem->forth = (item) d;
  else
    firstitem = (item) d;
  curitem = (item) d;
  d->forth = 0;
  d->echo = FLAG('x') && ((!body && !PARAMETER('x')) || line == PARAMETER('x'));
  d->deg = 0;
  d->code = 0;
  d->seq = seq++;
  savemem();
  if (!type || !check(type) || !checkdegree(type, 1, 2) || (curcon && !curcon->type))
  {
    d->type = 0;
    d->deg = 0;
    d->code = 0;
  }
  else
  {
    d->type = type;
    d->deg = degree(type);
    d->code = flavor(type);
    if (!body || !check(body) || !checktype(body, type) || (noexpand && !FLAG('f')))
      d->body = 0;
    else
      d->body = body;
  }
  restoremem();
  finalclosecon();
  e = (item) getidvalue(id);
  if (e)
  {
    CHECK(e->kind == CON || e->kind == DEF);
    if (e->where == curpar)
    {
      error();
      (void) fprintf(stderr, "definition covers item with same name on same level: \"%s\"\n", id);
    }
  }
  savevalue(id, (char *) d);
  if (body)
    defcount++;
  else
    pncount++;
}
