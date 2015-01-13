/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   printf_u.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/01/06 11:34:07 by jgigault          #+#    #+#             */
/*   Updated: 2015/01/10 12:58:26 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int		ret;

	ret = -999;
	if (argv[1][0] == 'h')
	{
		ret = printf(argv[2], atoi(argv[3]));
	}
	else if (argv[1][0] == 'l')
	{
		ret = printf(argv[2], atoll(argv[3]));
	}
	else
	{
		if (argc == 4)
			ret = printf(argv[2], atoll(argv[3]));
		else if (argc == 5)
			ret = printf(argv[2], atoi(argv[3]), atoi(argv[4]));
		else if (argc == 6)
			ret = printf(argv[2], atoi(argv[3]), atoi(argv[4]), atoi(argv[5]));
		else if (argc == 7)
			ret = printf(argv[2], atoi(argv[3]), atoi(argv[4]), atoi(argv[5]), atoi(argv[6]));
		else if (argc == 8)
			ret = printf(argv[2], atoi(argv[3]), atoi(argv[4]), atoi(argv[5]), atoi(argv[6]), atoi(argv[7]));
	}
	printf("|%d", ret);
	return (0);
}
