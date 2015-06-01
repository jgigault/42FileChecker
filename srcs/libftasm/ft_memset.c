/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_memset.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/06/01 12:39:06 by jgigault          #+#    #+#             */
/*   Updated: 2015/06/01 12:54:41 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <strings.h>
#include <stdlib.h>
#include <stdio.h>

void			*ft_memset(void *b, int c, size_t len);

int				main(int argc, char **argv)
{
	int			i;

	if (argc == 4)
	{
		i = atoi(argv[1]);
		if (i == 0)
		{
			printf("%s", argv[3]);
			argv[3] = ft_memset(argv[3], atoi(argv[2]), strlen(argv[3]));
			printf("%s", argv[3]);
		}
		else if (i == 1)
		{
			printf("%s", argv[3]);
			argv[3] = ft_memset(argv[3], atoi(argv[2]), 2);
			printf("%s", argv[3]);
		}
	}
	return (0);
}
