/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   gnl1_1.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2014/12/10 09:42:43 by jgigault          #+#    #+#             */
/*   Updated: 2014/12/10 14:29:43 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <string.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include "gnl.h"

int				main(int argc, char **argv)
{
	char		*line;
	int			fd;
	int			ret;
	char		*filename;
	int			errors;

	filename = "./srcs/gnl/gnl9.txt";
	fd = open(filename, O_RDONLY);
	if (argc && argv)
	{
		errors = 0;
		line = NULL;
		ret = get_next_line(fd, &line);
		if (ret != -1)
			errors++;
		if (errors > 0)
		{
			printf("get_next_line should return -1");
		}
		else
		{
			printf("OK");
		}
	}
	return (0);
}
