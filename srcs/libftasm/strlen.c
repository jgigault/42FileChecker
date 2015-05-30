/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strlen.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/05/30 22:23:44 by jgigault          #+#    #+#             */
/*   Updated: 2015/05/30 23:15:06 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int				main(int argc, char **argv)
{
	size_t		ret;

	if (argc == 3)
	{
		if (atoi(argv[1]) == 0)
		{
			ret = strlen(argv[2]);
			printf("%zu", ret);
		}
	}
	return (0);
}
