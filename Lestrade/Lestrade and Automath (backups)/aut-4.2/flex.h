/* stupid flex */

#include <stdlib.h>

#define exit(status) (status, flexexit())
#define isatty(fd) (fd, flexisatty())

void
flexexit()
{
  exit(2);
}

int
flexisatty()
{
  return 0;
}
