#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int				main(int argc, char **argv)
{
	size_t		ret;

	if (argc == 3)
	{
		if (atoi(argv[1]) == 0)
		{
			ret = strlen(argv[2]);
			printf("%zu", ret);
		}
	}
	return (0);
}
