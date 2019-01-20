#include "../../tmp/printf.h"
#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int			ret;

	ret = ft_printf(argv[1], strtof(argv[2], NULL));
	printf("|%d", ret);
	return (0);
}
