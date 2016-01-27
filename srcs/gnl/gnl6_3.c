#include <string.h>
#include <stdio.h>
#include "gnl.h"

/*
** 4 lines via STDIN with 4 chars with Line Feed
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
		if (count_lines == 1 && strcmp(line, "abc") != 0)
			errors++;
		if (count_lines == 2 && strcmp(line, "456") != 0)
			errors++;
		if (count_lines == 3 && strcmp(line, "def") != 0)
			errors++;
		count_lines++;
		if (count_lines > 50)
			break ;
	}
	if (count_lines != 4)
		printf("-> must have returned '1' four times instead of %d time(s)\n", count_lines);
	if (errors > 0)
		printf("-> must have read \"123\", \"abc\", \"456\" and \"def\"\n");
	if (count_lines == 4 && errors == 0)
		printf("OK\n");
	return (0);
}
