# include <stdio.h>
# include <fcntl.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include "get_next_line.h"
#include <string.h>
//#include "libft/includes/libft.h"


int main(void) 
{

	char *line; 
	int total;
	int total_lines;

	line = NULL;
	total_lines = 0;
	total = 0;
	if (get_next_line(0, &line) == 1)
	{
		printf("%s\n", line);
        total += strlen(line);
        total_lines++;
	}
    if (get_next_line(0, &line) == 1)
    {
		printf("%s\n", line);
        total += strlen(line);
        total_lines++;
    }
    if (get_next_line(0, &line) == 1)
    {
		printf("%s\n", line);
        total += strlen(line);
        total_lines++;
    }
    if (get_next_line(0, &line) == 1)
    {
		printf("%s\n", line);
        total += strlen(line);
        total_lines++;
    }
    if (get_next_line(0, &line) == 1)
    {
		printf("%s\n", line);
        total += strlen(line);
        total_lines++;
    }
	printf("\nNombre de caracteres lus : %d\n", total);
    printf("Nombre de lignes lues : %d", total_lines);
	if (line)
		free (line);
	return (0);
}
