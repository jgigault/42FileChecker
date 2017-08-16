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
#include <string.h>

int				main(int argc, char **argv)
{
	int			ret;

	ret = -999;
	if (argc == 4)
		ret = ft_printf(argv[2], (strcmp(argv[3], "NULL") == 0 ? NULL : argv[3]));
	else if (argc == 5)
		ret = ft_printf(argv[2], (strcmp(argv[3], "NULL") == 0 ? NULL : argv[3]), (strcmp(argv[4], "NULL") == 0 ? NULL : argv[4]));
	else if (argc == 6)
		ret = ft_printf(argv[2], (strcmp(argv[3], "NULL") == 0 ? NULL : argv[3]), (strcmp(argv[4], "NULL") == 0 ? NULL : argv[4]), (strcmp(argv[5], "NULL") == 0 ? NULL : argv[5]));
	else if (argc == 7)
		ret = ft_printf(argv[2], (strcmp(argv[3], "NULL") == 0 ? NULL : argv[3]), (strcmp(argv[4], "NULL") == 0 ? NULL : argv[4]), (strcmp(argv[5], "NULL") == 0 ? NULL : argv[5]), (strcmp(argv[6], "NULL") == 0 ? NULL : argv[6]));
	else if (argc == 8)
		ret = ft_printf(argv[2], (strcmp(argv[3], "NULL") == 0 ? NULL : argv[3]), (strcmp(argv[4], "NULL") == 0 ? NULL : argv[4]), (strcmp(argv[5], "NULL") == 0 ? NULL : argv[5]), (strcmp(argv[6], "NULL") == 0 ? NULL : argv[6]), (strcmp(argv[7], "NULL") == 0 ? NULL : argv[7]));
	printf("|%d", ret);
	return (0);
}
