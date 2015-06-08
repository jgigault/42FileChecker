
#include <strings.h>
#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int			i;
	size_t		size;
	char		*str;


	if (argc == 3)
	{
		i = atoi(argv[1]);
		if (i == 0)
		{
			size = atoi(argv[2]);
			str = (char *)malloc(size);
			bzero(str, size);
			while (size > 0)
			{
				size--;
				if (str + size == 0)
					printf("0");
			}
			free(str);
		}
	}
	return (0);
}
