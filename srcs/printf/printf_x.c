/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   printf_x.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/01/10 14:44:17 by jgigault          #+#    #+#             */
/*   Updated: 2015/01/10 15:40:45 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int		ret;

	ret = -999;
	switch (argc)
	{
	case 4 :
		ret = printf(argv[2], atoll(argv[3]));
		break;
	case 5 :
		ret = printf(argv[2], atoll(argv[3]), atoll(argv[4]));
		break;
	case 6 :
		ret = printf(argv[2], atoll(argv[3]), atoll(argv[4]), atoll(argv[5]));
		break;
	case 7 :
		ret = printf(argv[2], atoll(argv[3]), atoll(argv[4]), atoll(argv[5]), atoll(argv[6]));
		break;
	case 8 :
		ret = printf(argv[2], atoll(argv[3]), atoll(argv[4]), atoll(argv[5]), atoll(argv[6]), atoll(argv[7]));
		break;
	}
	printf("|%d", ret);
	return (0);
}
