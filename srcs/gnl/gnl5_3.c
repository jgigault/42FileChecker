#include <string.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include "gnl.h"

/*
** 4 lines with 4 chars with Line Feed
*/

int				main(void)
{
	char		*line;
	int			fd;
	int			ret;
	int			count_lines;
	char		*filename;
	int			errors;

	filename = "gnl5_3.txt";
	fd = open(filename, O_RDONLY);
	if (fd > 2)
	{
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
		close(fd);
		if (count_lines != 4)
			printf("-> must have returned '1' four times instead of %d time(s)\n", count_lines);
		if (errors > 0)
			printf("-> must have read \"123\", \"abc\", \"456\" and \"def\"\n");
		if (count_lines == 4 && errors == 0)
			printf("OK\n");
	}
	else
		printf("An error occured while opening file %s\n", filename);
	return (0);
}
