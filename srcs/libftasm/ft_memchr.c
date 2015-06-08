/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_memchr.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/06/08 16:10:33 by jgigault          #+#    #+#             */
/*   Updated: 2015/06/08 16:17:53 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <strings.h>
#include <stdlib.h>
#include <stdio.h>

void			*ft_memchr(const void *s, int c, size_t n);

int				main(int argc, char **argv)
{
	int			i;
	char		*str;

	if (argc == 5)
	{
		i = atoi(argv[1]);
		if (i == 0)
		{
			str = (char *)ft_memchr(argv[2], atoi(argv[3]), atoi(argv[4]));
			if (str)
				printf("%s", str);
			else
				printf("(null)");
		}
	}
	return (0);
}
