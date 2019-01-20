#include <strings.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int				main(int argc, char **argv)
{
	int			i;
	char		*str;

	if (argc == 4)
	{
		i = atoi(argv[1]);
		str = (char *)malloc(sizeof(char) * 100);
		str[0] = 0;
		if (i == 0)
		{
			memcpy(str, argv[2], atoi(argv[3]));
			printf("%s", str);
		}
	}
	return (0);
}
