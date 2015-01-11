/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   gnl1_1.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2014/12/10 09:42:43 by jgigault          #+#    #+#             */
/*   Updated: 2014/12/30 12:26:15 by jgigault         ###   ########.fr       */
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
	int			count;
	char		*filename;
	int			errors;

	filename = "./srcs/gnl/gnl3_1.txt";
	fd = open(filename, O_RDONLY);
	if (argc && argv && fd > 2)
	{
		count = 0;
		errors = 0;
		line = NULL;
		while ((ret = get_next_line(fd, &line)) > 0)
		{
			if (count == 0 && strcmp(line, "1234567890abcde") != 0)
				errors++;
			count++;
		}
		if (count == 0)
		{
			if (strcmp(line, "1234567890abcde") != 0)
				errors++;
			else
				count++;
		}
		if (count != 1)
			errors++;
		close(fd);
		if (errors > 0)
		{
			printf("\"%s\" was read instead of \"1234567890abcde\"", line);
		}
		else
		{
			printf("OK");
		}
	}
	else
	{
		printf("An error occured while opening file %s", filename);
	}
	return (0);
}
