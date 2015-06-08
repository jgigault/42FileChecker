
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int			i;
	int			ret;


	if (argc == 5)
	{
		i = atoi(argv[1]);
		if (i == 0)
		{
			ret = memcmp(argv[2], argv[3], atoi(argv[4]));
			printf("%d", ret);
		}
		else if (i == 1)
		{
			ret = memcmp("\200", "\0", 1);
			printf("%d", ret);
		}
	}
	return (0);
}
