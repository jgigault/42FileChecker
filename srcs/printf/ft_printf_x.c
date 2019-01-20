#include "../../tmp/printf.h"
#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int			ret;

	ret = -999;
	switch (argc)
	{
	case 4 :
		ret = ft_printf(argv[2], atoll(argv[3]));
		break;
	case 5 :
		ret = ft_printf(argv[2], atoll(argv[3]), atoll(argv[4]));
		break;
	case 6 :
		ret = ft_printf(argv[2], atoll(argv[3]), atoll(argv[4]), atoll(argv[5]));
		break;
	case 7 :
		ret = ft_printf(argv[2], atoll(argv[3]), atoll(argv[4]), atoll(argv[5]), atoll(argv[6]));
		break;
	case 8 :
		ret = ft_printf(argv[2], atoll(argv[3]), atoll(argv[4]), atoll(argv[5]), atoll(argv[6]), atoll(argv[7]));
		break;
	}
	printf("|%d", ret);
	return (0);
}
