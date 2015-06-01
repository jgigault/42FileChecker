/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strdup.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/06/01 15:36:39 by jgigault          #+#    #+#             */
/*   Updated: 2015/06/01 15:39:41 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <strings.h>
#include <stdlib.h>
#include <stdio.h>

char			*ft_strdup(const char *s1);

int				main(int argc, char **argv)
{
	int			i;
	char		*str;


	if (argc == 3)
	{
		i = atoi(argv[1]);
		if (i == 0)
		{
			str = ft_strdup(argv[2]);
			printf("%s", str);
			free(str);
		}
	}
	return (0);
}
