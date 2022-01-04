#include <stdio.h>
#include <stdlib.h>
#include "aut.h"

extern void convert();

#define dlputchar(c) \
  { putchar(c); if (colwidth && !--colsleft) { putchar('\n'); colsleft = colwidth; }}

int printids, sepitems, colwidth, colsleft;
long curseq;

void
dlputid(s)
  char *s;
{
  char c;

  for (; c = *s; s++)
    dlputchar(c);
}

void
dlputint(i)
  long i;
{
  if (i)
  {
    dlputint(i / 10);
    dlputchar('0' + (i % 10));
  }
}

void
convertargs(a)
  args a;
{
  if (a)
  {
    dlputchar('<');
    convert(a->arg);
    dlputchar('>');
    convertargs(a->prev);
  }
}

void
convert(e)
  exp e;
{
  if (e)
    switch (e->kind)
    {
    case ONE:
      dlputchar(((one) e)->code ? '+' : '*');
      break;
    case CON:
      dlputint(curseq - ((long) ((con) e)->ref));
      break;
    case TERM:
      convertargs(((term) e)->arglist);
      dlputint(curseq - ((term) e)->fun->seq);
      break;
    case APP:
      dlputchar('<');
      convert(((app) e)->arg);
      dlputchar('>');
      convert(((app) e)->fun);
      break;
    case ABST:
      dlputchar('[');
      if (printids)
      {
        dlputid(((abst) e)->id);
        dlputchar(':');
      }
      convert(((abst) e)->type);
      dlputchar(']');
      curseq++;
      CHECK(!((abst) e)->ref);
      ((abst) e)->ref = (abst) curseq;
      convert(((abst) e)->body);
      curseq--;
      ((abst) e)->ref = 0;
      break;
    case VAR:
      dlputint(curseq - ((long) ((var) e)->lambda->ref));
      break;
    default:
      WRONG();
    }
  else
    WRONG();
}

void
argabsts(c)
  con c;
{
  if (c)
  {
    argabsts(c->back);
    dlputchar('[');
    if (printids)
    {
      dlputid(c->id);
      dlputchar(':');
    }
    convert(c->type);
    dlputchar(']');
    curseq++;
    CHECK(!c->ref);
    c->ref = (exp) curseq;
  }
}

void
backabst(c)
  con c;
{
  if (c)
  {
    curseq--;
    c->ref = 0;
    backabst(c->back);
  }
}

void
deltalambda()
{
  item e;
  def d;
  con c;

  printids = PARAMETER('g') & 1;
  sepitems = PARAMETER('g') & 2;
  colwidth = PARAMETER('g') >> 2;
  if (colwidth)
    colsleft = colwidth;
  curseq = -1;
  for (e = firstitem; e; e = e->forth)
  {
    CHECK(e->kind == DEF || e->kind == CON);
    if (e->kind == DEF)
    {
      d = (def) e;
      c = d->back;
      if (d->body)
      {
        dlputchar('(');
        argabsts(c);
        convert(d->body);
	backabst(c);
        dlputchar(')');
      }
      dlputchar('[');
      if (printids)
      {
        dlputid(d->id);
        dlputchar(':');
      }
      argabsts(c);
      convert(d->type);
      backabst(c);
      dlputchar(']');
      curseq++;
      if (sepitems)
	if (colwidth)
	{
	  if (colsleft < colwidth)
	  {
            putchar('\n');
	    colsleft = colwidth;
	  }
	}
	else
	  putchar('\n');
    }
    yield();
  }
  if (!sepitems && colwidth && colsleft < colwidth)
    putchar('\n');
}
