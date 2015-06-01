/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   is.c                                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/06/01 13:17:18 by jgigault          #+#    #+#             */
/*   Updated: 2015/06/01 13:25:21 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <ctype.h>
#include <strings.h>
#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int			i;
	int			j;
	int			ret;

	if (argc == 3)
	{
		i = atoi(argv[1]);
		j = -9;
		while (j < 255)
		{
			if (i == 0)
				ret = isalpha(j);
			else if (i == 1)
				ret = isdigit(j);
			else if (i == 2)
				ret = isalnum(j);
			else if (i == 3)
				ret = isascii(j);
			else if (i == 4)
				ret = isprint(j);
			else if (i == 5)
				ret = tolower(j);
			else if (i == 6)
				ret = toupper(j);
			if (j % 10 == 0)
				printf("%d ", ret);
			else
				printf("%d", ret);
			j++;
		}
	}
	return (0);
}
