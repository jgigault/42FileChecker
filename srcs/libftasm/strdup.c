/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strdup.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/06/01 15:38:17 by jgigault          #+#    #+#             */
/*   Updated: 2015/06/01 15:38:34 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <strings.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int			i;
	char		*str;


	if (argc == 3)
	{
		i = atoi(argv[1]);
		if (i == 0)
		{
			str = strdup(argv[2]);
			printf("%s", str);
			free(str);
		}
	}
	return (0);
}
