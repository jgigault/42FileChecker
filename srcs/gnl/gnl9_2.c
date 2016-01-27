#include <string.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include "gnl.h"

/*
** Invalid file descriptor #2
*/

int				main(void)
{
	char		*line;
	int			fd;
	int			ret;
	char		*filename;

	filename = "gnl9_2.txt";
	fd = open(filename, O_RDONLY);
	if (fd > 2)
	{
		if (close(fd) == 0)
		{
			line = NULL;
			ret = get_next_line(fd, &line);
			if (ret != -1)
				printf("-> must have returned '-1' when receiving a closed file descriptor\n");
			else
				printf("OK\n");
		}
		else
		{
			printf("An error occured while closing file descriptor associated with file %s\n", filename);
			return (0);
		}
	}
	else
		printf("An error occured while opening file %s\n", filename);
	return (0);
}
