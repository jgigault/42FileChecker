#include <string.h>
#include <stdio.h>
#include "gnl.h"

/*
** 1 line via STDIN with 4 chars with Line Feed
*/

int				main(void)
{
	char		*line;
	int			fd;
	int			ret;
	int			count_lines;
	int			errors;

	fd = 0;
	count_lines = 0;
	errors = 0;
	line = NULL;
	while ((ret = get_next_line(fd, &line)) > 0)
	{
		if (count_lines == 0 && strcmp(line, "123") != 0)
			errors++;
		count_lines++;
		if (count_lines > 50)
			break ;
	}
	if (count_lines != 1)
		printf("-> must have returned '1' once instead of %d time(s)\n", count_lines);
	if (errors > 0)
		printf("-> must have read \"123\" instead of \"%s\"\n", line);
	if (count_lines == 1 && errors == 0)
		printf("OK\n");
	return (0);
}
