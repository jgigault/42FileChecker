#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <strings.h>

int				main(int argc, char **argv)
{
	int			i;

	if (argc == 4)
	{
		i = atoi(argv[1]);
		if (i == 0)
		{
			printf("%s", argv[3]);
			argv[3] = memset(argv[3], atoi(argv[2]), strlen(argv[3]));
			printf("%s", argv[3]);
		}
		else if (i == 1)
		{
			printf("%s", argv[3]);
			argv[3] = memset(argv[3], atoi(argv[2]), 2);
			printf("%s", argv[3]);
		}
	}
	return (0);
}
