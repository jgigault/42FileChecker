#include "../../tmp/printf.h"
#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int			ret;
	char		*str;

	(void)argc;
	if (argv[1][0] == 'p')
	{
		ret = ft_printf(argv[2], (void *)(str = "I am a void"));
	}
	else
	{
		ret = ft_printf(argv[2]);
	}
	printf("|%d", ret);
	return (0);
}
