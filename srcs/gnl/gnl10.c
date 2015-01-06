/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   gnl10.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/01/06 08:56:30 by jgigault          #+#    #+#             */
/*   Updated: 2015/01/06 09:08:51 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include "gnl.h"

int				main(void)
{
	char		*line;
	int			fd;

	fd = open("./srcs/gnl/gnl10.txt", O_RDONLY);
	line = NULL;
	while ((get_next_line(fd, &line)) > 0)
	{
		printf("%s\n", line);
	}
	close(fd);
	if (line)
		free(line);
	while (1);
	return (0);
}
