#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int			ret;

	ret = printf(argv[1], strtof(argv[2], NULL));
	printf("|%d", ret);
	return (0);
}
