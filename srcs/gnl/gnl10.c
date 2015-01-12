#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include "gnl.h"
int  main(void)
{
  char  *line = NULL;
  int   fd = open("./srcs/gnl/gnl10.txt", O_RDONLY);
  while ((get_next_line(fd, &line)) > 0)
  {
    printf("%s\n", line);
    //free(line)         <-- In my opinion, this line should not exist
  }
  close(fd);
  while (1);
  return (0);
}
