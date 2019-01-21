#include <string.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include "gnl.h"

/*
** reading 4 lines while freeing them
*/

int				main(void)
{
	char		*line;
	int			fd;
	int			ret;
	int			count_lines;
	char		*filename;
	int			errors;

	filename = "gnl_to_free_or_not_to_free.txt";
	fd = open(filename, O_RDONLY);
	if (fd > 2)
	{
		count_lines = 0;
		errors = 0;
		line = NULL;
		while ((ret = get_next_line(fd, &line)) > 0)
		{
			if (count_lines == 0 && strcmp(line, "This is the first line") != 0)
				errors++;
			if (count_lines == 1 && strcmp(line, "This is the second one") != 0)
				errors++;
			if (count_lines == 2 && strcmp(line, "This is the third") != 0)
				errors++;
			if (count_lines == 3 && strcmp(line, "This is the last") != 0)
				errors++;
			count_lines++;
			free(line);
			if (count_lines > 50)
				break ;
		}
		close(fd);
		if (count_lines != 4)
			printf("-> must have returned '1' four times instead of %d time(s)\n", count_lines);
		if (errors > 0)
			printf("-> must have read \"This is the first line\", \"This is the second one\", \"This is the third\", \"This is the last\".\n");
		if (count_lines == 4 && errors == 0)
			printf("OK");
	}
	else
		printf("An error occured while opening file %s\n", filename);
	return (0);
}
