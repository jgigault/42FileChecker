/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_puts.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/06/01 14:29:13 by jgigault          #+#    #+#             */
/*   Updated: 2015/06/01 14:56:10 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int				ft_puts(char *str);

int				main(int argc, char **argv)
{
	int			i;
	int			ret;

	if (argc == 3)
	{
		i = atoi(argv[1]);
		if (i == 0)
		{
			ret = ft_puts(argv[2]);
			if (ret > 0)
				printf("(nonnegative value returned)");
			else if (ret < 0)
				printf("(negative value returned)");
			else
				printf("(returns 0)");
		}
		else if (i == 1)
		{
			ret = ft_puts(NULL);
			if (ret > 0)
				printf("(nonnegative value returned)");
			else if (ret < 0)
				printf("(negative value returned)");
			else
				printf("(returns 0)");
		}
	}
	return (0);
}
