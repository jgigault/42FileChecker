/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   printf_s.c                                         :+:      :+:    :+:   */
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
		ret = printf(argv[2], atol(argv[3]));
	}
	printf("|%d", ret);
	return (0);
}
