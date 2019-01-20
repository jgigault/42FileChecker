#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int			ret;

	ret = printf(argv[2], strtod(argv[3]));
	printf("|%d", ret);
	return (0);
}
