#include <string.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include "gnl.h"

/*
** Invalid file descriptor #1
*/

int				main(void)
{
	char		*line;
	int			fd;
	int			ret;

	fd = -1;
	line = NULL;
	ret = get_next_line(fd, &line);
	if (ret != -1)
		printf("-> must have returned '-1' when receiving a negative file descriptor\n");
	else
		printf("OK\n");
	return (0);
}
