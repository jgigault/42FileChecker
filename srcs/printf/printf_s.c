
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   printf_s.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/01/06 11:34:07 by jgigault          #+#    #+#             */
/*   Updated: 2015/01/13 16:38:57 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int		ret;
	char	str;

	ret = -999;
	if (argc == 4 && argv[1][1] == 'N')
		ret = printf(argv[2], NULL);
	if (argc == 4)
		ret = printf(argv[2], argv[3]);
	if (argc == 5)
		ret = printf(argv[2], argv[3], argv[4]);
	if (argc == 6)
		ret = printf(argv[2], argv[3], argv[4], argv[5]);
	if (argc == 7)
		ret = printf(argv[2], argv[3], argv[4], argv[5], argv[6]);
	if (argc == 8)
		ret = printf(argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
	printf("|%d", ret);
	return (0);
}
