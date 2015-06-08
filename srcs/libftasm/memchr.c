/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   memchr.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/06/08 16:12:09 by jgigault          #+#    #+#             */
/*   Updated: 2015/06/08 16:18:07 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <strings.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int				main(int argc, char **argv)
{
	int			i;
	char		*str;

	if (argc == 5)
	{
		i = atoi(argv[1]);
		if (i == 0)
		{
			str = (char *)memchr(argv[2], atoi(argv[3]), atoi(argv[4]));
			if (str)
				printf("%s", str);
			else
				printf("(null)");
		}
	}
	return (0);
}
