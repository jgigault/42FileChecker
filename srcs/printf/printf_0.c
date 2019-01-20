#include <string.h>
#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int			ret;
	char		*str;

	(void)argc;
	if (argv[1][0] == 'p')
	{
		ret = printf(argv[2], (void *)(str = "I am a void"));
	}
	else
	{
		ret = printf(argv[2], NULL);
		// NULL is here to prevent security warning when compiling
	}
	printf("|%d", ret);
	return (0);
}
