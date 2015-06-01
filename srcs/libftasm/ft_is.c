/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_is.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/06/01 13:14:26 by jgigault          #+#    #+#             */
/*   Updated: 2015/06/01 13:27:11 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <strings.h>
#include <stdlib.h>
#include <stdio.h>

int				ft_isalpha(int n);
int				ft_isdigit(int n);
int				ft_isalnum(int n);
int				ft_isascii(int n);
int				ft_isprint(int n);
int				ft_toupper(int n);
int				ft_tolower(int n);

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
				ret = ft_isalpha(j);
			else if (i == 1)
				ret = ft_isdigit(j);
			else if (i == 2)
				ret = ft_isalnum(j);
			else if (i == 3)
				ret = ft_isascii(j);
			else if (i == 4)
				ret = ft_isprint(j);
			else if (i == 5)
				ret = ft_tolower(j);
			else if (i == 6)
				ret = ft_toupper(j);
			if (j % 10 == 0)
				printf("%d ", ret);
			else
				printf("%d", ret);
			j++;
		}
	}
	return (0);
}
