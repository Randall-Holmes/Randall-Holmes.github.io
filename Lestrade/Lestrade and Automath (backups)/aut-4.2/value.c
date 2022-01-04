#include <stdio.h>
#include <stdlib.h>
#include "aut.h"

value savedvalues = 0, unusedvalues = 0;

void
savevalue(id, newvalue)
  char *id, *newvalue;
{
  value v;

  if (unusedvalues)
  {
    v = unusedvalues;
    unusedvalues = unusedvalues->prev;
  }
  else
    v = ALLOC(value);
  v->id = id;
  if (id)
  {
    v->oldvalue = getidvalue(id);
    setidvalue(id, newvalue);
  }
  else
    v->oldvalue = newvalue;
  v->prev = savedvalues;
  savedvalues = v;
}

void
mark(markvalue)
  char *markvalue;
{
  savevalue(0, markvalue);
}

void
popvalue()
{
  value v;

  CHECK(savedvalues);
  v = savedvalues;
  savedvalues = v->prev;
  v->prev = unusedvalues;
  unusedvalues = v;
}

void
restorevalue()
{
  CHECK(savedvalues);
  setidvalue(savedvalues->id, savedvalues->oldvalue);
  popvalue();
}

char *
restoretomark()
{
  char *markvalue;

  while (savedvalues && savedvalues->id)
    restorevalue();
  CHECK(savedvalues);
  markvalue = savedvalues->oldvalue;
  popvalue();
  return markvalue;
}

exp
checkcontext(e)
  exp e;
{
  if (e->kind == CON && inbody && !((con) e)->ref)
  {
    error();
    (void) fprintf(stderr, "variable not in context: \"%s\"\n", ((con) e)->id);
    return 0;
  }
  return e;
}

exp
findsym(id)
  char *id;
{
  exp e;

  e = (exp) getidvalue(id);
  if (!e)
  {
    error();
    (void) fprintf(stderr, "unknown identifier: \"%s\"\n", id);
  }
  else
    e = checkcontext(e);
  return e;
}

exp
findexp(p, id)
  par p;
  char *id;
{
  item e;

  if (p)
  {
    for (e = p->last; e; e = e->prev)
      if (e->id == id)
      {
        if (FLAG('o') && e->kind == CON && inbody)
	{
	  error();
	  (void) fprintf(stderr, "variable should not have explicit paragraph: \"%s\"\n", id);
	}
        return checkcontext((exp) e);
      }
    error();
    (void) fprintf(stderr, "unknown identifier in paragraph: \"%s\" in paragraph \"", id);
    (void) fprintpar(stderr, p);
    (void) fprintf(stderr, "\"\n");
  }
  return 0;
}
