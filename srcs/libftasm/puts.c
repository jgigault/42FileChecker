/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   puts.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/06/01 14:27:48 by jgigault          #+#    #+#             */
/*   Updated: 2015/06/01 14:56:20 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int				main(int argc, char **argv)
{
	int			i;
	int			ret;

	if (argc == 3)
	{
		i = atoi(argv[1]);
		if (i == 0)
		{
			ret = puts(argv[2]);
			if (ret > 0)
				printf("(nonnegative value returned)");
			else if (ret < 0)
				printf("(negative value returned)");
			else
				printf("(returns 0)");
		}
		else if (i == 1)
		{
			ret = puts(NULL);
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
