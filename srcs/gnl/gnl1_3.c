/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   gnl1_1.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2014/12/10 09:42:43 by jgigault          #+#    #+#             */
/*   Updated: 2014/12/10 12:37:29 by jgigault         ###   ########.fr       */
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

	filename = "gnl1_3.txt";
	fd = open(filename, O_RDONLY);
	if (argc && argv && fd > 2)
	{
		count = 0;
		errors = 0;
		line = NULL;
		while ((ret = get_next_line(fd, &line)) > 0)
		{
			if (count == 0 && strcmp(line, "1234567") != 0)
				errors++;
			if (count == 1 && strcmp(line, "abcdefg") != 0)
				errors++;
			if (count == 2 && strcmp(line, "4567890") != 0)
				errors++;
			if (count == 3 && strcmp(line, "defghij") != 0)
				errors++;
			count++;
		}
		close(fd);
		if (errors > 0)
		{
			printf("%d lines read | %d errors", count, errors);
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
