#include <string.h>
#include <stdio.h>
#include "gnl.h"

/*
** 4 lines via STDIN with 16 chars with Line Feed
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
		if (count_lines == 0 && strcmp(line, "1234567890abcde") != 0)
			errors++;
		if (count_lines == 1 && strcmp(line, "fghijklmnopqrst") != 0)
			errors++;
		if (count_lines == 2 && strcmp(line, "edcba0987654321") != 0)
			errors++;
		if (count_lines == 3 && strcmp(line, "tsrqponmlkjihgf") != 0)
			errors++;
		count_lines++;
		if (count_lines > 50)
			break ;
	}
	if (count_lines != 4)
		printf("-> must have returned '1' four times instead of %d time(s)\n", count_lines);
	if (errors > 0)
		printf("-> must have read \"1234567890abcde\", \"fghijklmnopqrst\", \"edcba0987654321\" and \"tsrqponmlkjihgf\"\n");
	if (count_lines == 4 && errors == 0)
		printf("OK\n");
	return (0);
}
