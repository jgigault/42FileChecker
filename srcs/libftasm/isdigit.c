
#include <ctype.h>
#include <strings.h>
#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int			i;
	int			j;
	int			ret;

	if (argc == 3)
	{
		i = atoi(argv[1]);
		j = -9;
		while (j < 255)
		{
			ret = isdigit(j);
			if (j % 10 == 0)
				printf("%d ", ret);
			else
				printf("%d", ret);
			j++;
		}
	}
	return (0);
}
