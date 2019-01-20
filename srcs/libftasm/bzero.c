#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <strings.h>

int				main(int argc, char **argv)
{
	int			i;

	if (argc == 3)
	{
		i = atoi(argv[1]);
		if (i == 0)
		{
			printf("%s", argv[2]);
			bzero(argv[2], strlen(argv[2]));
			printf("%s", argv[2]);
		}
		else if (i == 1)
		{
			printf("%s", argv[2]);
			bzero(argv[2] + 2, strlen(argv[2]) - 2);
			printf("%s", argv[2]);
		}
		else if (i == 2)
		{
			printf("%s", argv[2]);
			bzero(argv[2] + 2, 2);
			printf("%s", argv[2]);
			printf("%s", argv[2] + 3);
			printf("%s", argv[2] + 4);
		}
	}
	return (0);
}
