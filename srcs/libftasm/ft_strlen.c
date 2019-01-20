#include <stdlib.h>
#include <stdio.h>

size_t			ft_strlen(const char *s);

int				main(int argc, char **argv)
{
	size_t		ret;

	if (argc == 3)
	{
		if (atoi(argv[1]) == 0)
		{
			ret = ft_strlen(argv[2]);
			printf("%zu", ret);
		}
	}
	return (0);
}
