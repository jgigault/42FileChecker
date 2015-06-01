/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_cat.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/06/01 15:42:59 by jgigault          #+#    #+#             */
/*   Updated: 2015/06/01 15:56:58 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <fcntl.h>
#include <unistd.h>
#include <strings.h>
#include <stdlib.h>
#include <stdio.h>

char			*ft_cat(int fd);

int				main(int argc, char **argv)
{
	int			i;
	int			fd;


	if (argc == 3)
	{
		i = atoi(argv[1]);
		if (i == 0)
		{
			fd = open(argv[2], O_RDONLY);
			if (fd > 0)
			{
				ft_cat(fd);
				close(fd);
			}
		}
		else if (i == 1)
		{
			ft_cat(-1);
		}
		else if (i == 2)
		{
			fd = open(argv[2], O_RDONLY);
			if (fd > 0)
			{
				close(fd);
				ft_cat(fd);
			}
		}
	}
	return (0);
}
