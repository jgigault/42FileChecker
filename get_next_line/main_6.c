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

	int fd1;
	char *line; 
	int total;
	int total_lines;
	int total_errors;
	line = NULL;
	fd1 = open("test_6.txt", O_RDONLY);


	total_errors = 0;
	total_lines = 0;
	total = 0;
	while (get_next_line(fd1, &line) == 1)
	{
        total += strlen(line);
        total_lines++;
	}
	close(fd1);
    if (total_errors == 0 && total_lines == 2097152 && total == 134217728)
    {
        printf("\033[0;32mOK");
    }
    else
    {
		printf("\nNombre de caracteres lus : %d\n", total);
		printf("Nombre de caracteres attendus : 134217728\n");
		printf("Nombre de lignes lues : %d\n", total_lines);
		printf("Nombre de lignes attendues : 2097152\n");
	}
	free (line);
	return (0);
}
