
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   printf_s.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/01/06 11:34:07 by jgigault          #+#    #+#             */
/*   Updated: 2015/01/10 13:05:17 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int		ret;

	ret = -999;
	switch(argc)
	{
	case 4 :
		ret = printf(argv[2], argv[3]);
		break;
	case 5 :
		ret = printf(argv[2], argv[3], argv[4]);
		break;
	case 6 :
		ret = printf(argv[2], argv[3], argv[4], argv[5]);
		break;
	case 7 :
		ret = printf(argv[2], argv[3], argv[4], argv[5], argv[6]);
		break;
	case 8 :
		ret = printf(argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
		break;
	}
	printf("|%d", ret);
	return (0);
}
