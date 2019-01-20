#include <stdlib.h>
#include <stdio.h>

char			*ft_strchr(const char *s, int c);

int				main(int argc, char **argv)
{
	int			i;
	char		*str;

	if (argc == 4)
	{
		i = atoi(argv[1]);
		if (i == 0)
		{
			str = ft_strchr(argv[2], atoi(argv[3]));
			if (str)
				printf("%s", str);
			else
				printf("(null)");
		}
	}
	return (0);
}
