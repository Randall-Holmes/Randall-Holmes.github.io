/* alloc currently returns memory in blocks a multiple of four bytes
it _should_ be maximally aligned, really
save/restore pairs cannot be nested */

#include <stdlib.h>
#include <stdio.h>
#include "aut.h"

struct block
{
  char *data;
  int size;
  struct block *next;
} *firstblock, *curblock, *savedblock;
char *curdata, *curlimit, *saveddata;

#define HEADERSIZE ((sizeof(struct block) + 3) & ~3)
  /* here the four is hard coded */
#define BLOCKSIZE 32724
  /* 32 bytes for _them:_ malloc uses 4 & the memory manager uses another 12 */

int mayrestore;

int
fprintmemused(F)
  FILE *F;
{
  struct block *b;
  int n, m;

  n = 0;
  for (b = firstblock; b; b = b->next)
    n++;
  m = fprintf(F, "%d blocks = ", n);
  n = 0;
  for (b = firstblock; b; b = b->next)
    n += HEADERSIZE + b->size;
  return m + fprintf(F, "%d kilobytes", (n + (1 << 10) - 1) >> 10);
}

void
outofmem()
{
  struct block *b, *a;

  error();
  (void) fprintf(stderr, "out of memory: ");
  (void) fprintmemused(stderr);
  (void) fprintf(stderr, " were used\n");
  for (b = firstblock; b; b = a)
  {
    a = b->next;
    free(b);
  }
  exit(3);
}

void
initalloc()
{
  curblock = firstblock = (struct block *) malloc(HEADERSIZE + BLOCKSIZE);
  if (!curblock)
    outofmem();
  curblock->data = (char *) curblock + HEADERSIZE;
  curblock->size = BLOCKSIZE;
  curblock->next = 0;
  curdata = curblock->data;
  curlimit = curdata + curblock->size;
  savedblock = 0;
  saveddata = 0;
}

void
exitalloc()
{
  if (FLAG('m'))
  {
    (void) fprintmemused(STDSUM);
    (void) fprintf(STDSUM, "\n");
  }
}

char *
alloc(n)
  int n;
{
  int m;
  char *p;
  struct block *b, *a;

  n = (n + 3) & ~3; /* here the four is hard coded */
  p = curdata;
  curdata = p + n;
  if (curdata > curlimit)
  {
    for (a = curblock, b = a->next; b; a = b, b = a->next)
      if (b->size >= n)
        break;
    if (b)
      a->next = b->next;
    else
    {
      m = BLOCKSIZE;
      if (n > m)
        m = n;
      b = (struct block *) malloc(HEADERSIZE + m);
      if (!b)
        outofmem();
      b->data = (char *) b + HEADERSIZE;
      b->size = m;
    }
    b->next = curblock->next;
    curblock->next = b;
    curblock = b;
    curdata = curblock->data;
    curlimit = curdata + curblock->size;
    p = curdata;
    curdata = p + n;
  }
  return p;
}

void
savemem()
{
  if (savedblock || saveddata)
    WRONG();
  savedblock = curblock;
  saveddata = curdata;
  mayrestore = 1;
}

void
restoremem()
{
  if (!savedblock || !saveddata)
    WRONG();
  if (mayrestore)
  {
    curblock = savedblock;
    curdata = saveddata;
    curlimit = curblock->data + curblock->size;
  }
  savedblock = 0;
  saveddata = 0;
}
