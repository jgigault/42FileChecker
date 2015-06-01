/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_memcpy.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/06/01 14:59:17 by jgigault          #+#    #+#             */
/*   Updated: 2015/06/01 15:06:34 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <strings.h>
#include <stdlib.h>
#include <stdio.h>

void			ft_memcpy(void *restrict dst, const void *restrict src, size_t n);

int				main(int argc, char **argv)
{
	int			i;
	char		*str;


	if (argc == 4)
	{
		i = atoi(argv[1]);
		str = (char *)malloc(sizeof(char) * 100);
		str[0] = 0;
		if (i == 0)
		{
			ft_memcpy(str, argv[2], atoi(argv[3]));
			printf("%s", str);
		}
	}
	return (0);
}
