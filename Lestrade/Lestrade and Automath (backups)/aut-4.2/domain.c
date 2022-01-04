#include <stdio.h>
#include <stdlib.h>
#include "aut.h"

exp
domain(e)
  exp e;
{
  exp f;

  while (e)
  {
    if (e->kind == ABST)
      return ((abst) e)->type;
    if (degree(e) > 1)
    {
      f = domain(auttype(e));
      if (f)
        return f;
    }
    switch (e->kind)
    {
    case ONE:
    case CON:
    case VAR:
      return 0;
      break;
    case TERM:
      if (!delta(&e))
        return 0;
      break;
    case APP:
      if (!beta(&e))
        return 0;
      break;
    default:
      WRONG();
    }
  }
  WRONG();
  return 0;
}
