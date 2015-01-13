/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   printf_s.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/01/06 11:34:07 by jgigault          #+#    #+#             */
/*   Updated: 2015/01/13 16:16:20 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../tmp/printf.h"
#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int			ret;

	ret = -999;
	if (argc == 4 && argv[1][1] == 'N')
		ret = ft_printf(argv[2], NULL);
	if (argc == 4)
		ret = ft_printf(argv[2], argv[3]);
	else if (argc == 5)
		ret = ft_printf(argv[2], argv[3], argv[4]);
	else if (argc == 6)
		ret = ft_printf(argv[2], argv[3], argv[4], argv[5]);
	else if (argc == 7)
		ret = ft_printf(argv[2], argv[3], argv[4], argv[5], argv[6]);
	else if (argc == 8)
		ret = ft_printf(argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
	printf("|%d", ret);
	return (0);
}
