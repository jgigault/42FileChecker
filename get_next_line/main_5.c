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
	char *line1; 
	char *line2;
	int total;
	int total_lines;
	int total_errors;
	int fd1;
	int fd2;

	line1 = NULL;
	line2 = NULL;
	fd1 = open("test_5.txt", O_RDONLY);
	fd2 = open("test_2.txt", O_RDONLY);

	total_errors = 0;
	total_lines = 0;
	total = 0;

    if (get_next_line(fd1, &line1) == 1)
    {
        total += strlen(line1);
        total_lines++;
    }
    if (get_next_line(fd2, &line2) == 1)
    {
        total += strlen(line2);
        total_lines++;
    }

	if (strcmp(line1, line2) != 0)
	{
		total_errors++;
	}
	else
	{
		
		
		if (get_next_line(fd1, &line1) == 1)
		{
			total += strlen(line1);
			total_lines++;
		}
		if (get_next_line(fd2, &line2) == 1)
		{
			total += strlen(line2);
			total_lines++;
		}
		if (strcmp(line1, line2) != 0)
		{
			total_errors++;
		}
		
		
		if (get_next_line(fd1, &line1) == 1)
		{
			total += strlen(line1);
			total_lines++;
		}
		if (get_next_line(fd2, &line2) == 1)
		{
			total += strlen(line2);
			total_lines++;
		}
		if (strcmp(line1, line2) != 0)
		{
			total_errors++;
		}
		
		
		if (get_next_line(fd1, &line1) == 1)
		{
			total += strlen(line1);
			total_lines++;
		}
		if (get_next_line(fd2, &line2) == 1)
		{
			total += strlen(line2);
			total_lines++;
		}
		if (strcmp(line1, line2) != 0)
		{
			total_errors++;
		}
		
		
		if (get_next_line(fd1, &line1) == 1)
		{
			total += strlen(line1);
			total_lines++;
		}
		if (get_next_line(fd2, &line2) == 1)
		{
			total += strlen(line2);
			total_lines++;
		}
		if (strcmp(line1, line2) != 0)
		{
			total_errors++;
		}
		
		
		if (get_next_line(fd1, &line1) == 1)
		{
			total += strlen(line1);
			total_lines++;
		}
		if (get_next_line(fd2, &line2) == 1)
		{
			total += strlen(line2);
			total_lines++;
		}
		if (strcmp(line1, line2) != 0)
		{
			total_errors++;
		}
		
		
		if (get_next_line(fd1, &line1) == 1)
		{
			total += strlen(line1);
			total_lines++;
		}
		if (get_next_line(fd2, &line2) == 1)
		{
			total += strlen(line2);
			total_lines++;
		}
		if (strcmp(line1, line2) != 0)
		{
			total_errors++;
		}
		
		
		if (get_next_line(fd1, &line1) == 1)
		{
			total += strlen(line1);
			total_lines++;
		}
		if (get_next_line(fd2, &line2) == 1)
		{
			total += strlen(line2);
			total_lines++;
		}
		if (strcmp(line1, line2) != 0)
		{
			total_errors++;
		}
		
		
		if (get_next_line(fd1, &line1) == 1)
		{
			total += strlen(line1);
			total_lines++;
		}
		if (get_next_line(fd2, &line2) == 1)
		{
			total += strlen(line2);
			total_lines++;
		}
		if (strcmp(line1, line2) != 0)
		{
			total_errors++;
		}
		
		
		if (get_next_line(fd1, &line1) == 1)
		{
			total += strlen(line1);
			total_lines++;
		}
		if (get_next_line(fd2, &line2) == 1)
		{
			total += strlen(line2);
			total_lines++;
		}
		if (strcmp(line1, line2) != 0)
		{
			total_errors++;
		}
		
		
		if (get_next_line(fd1, &line1) == 1)
		{
			total += strlen(line1);
			total_lines++;
		}
		if (get_next_line(fd2, &line2) == 1)
		{
			total += strlen(line2);
			total_lines++;
		}
		if (strcmp(line1, line2) != 0)
		{
			total_errors++;
		}
	}

	close(fd1);
	close(fd2);
    if (total_errors == 0 && total_lines == 18 && total == 5500)
    {
        printf("\033[0;32mOK");
    }
    else
    {
		printf("\nMulti-fichiers non gere.");
		printf("\nNombre de caracteres lus : %d\n", total);
		printf("Nombre de caracteres attendus : 5500\n");
		printf("Nombre de lignes lues : %d\n", total_lines);
		printf("Nombre de lignes attendues : 18\n");
	}
	free (line1);
	free (line2);
	return (0);
}
