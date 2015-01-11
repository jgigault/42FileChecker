/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   gnl1_1.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2014/12/10 09:42:43 by jgigault          #+#    #+#             */
/*   Updated: 2014/12/30 12:27:22 by jgigault         ###   ########.fr       */
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

	filename = "./srcs/gnl/gnl3_3.txt";
	fd = 0;
	if (argc && argv)
	{
		count = 0;
		errors = 0;
		line = NULL;
		while ((ret = get_next_line(fd, &line)) > 0)
		{
			if (count == 0 && strcmp(line, "1234567890abcde") != 0)
				errors++;
			if (count == 1 && strcmp(line, "fghijklmnopqrst") != 0)
				errors++;
			if (count == 2 && strcmp(line, "edcba0987654321") != 0)
				errors++;
			if (count == 3 && strcmp(line, "tsrqponmlkjihgf") != 0)
				errors++;
			count++;
		}
		if (count == 3)
		{
			if (strcmp(line, "tsrqponmlkjihgf") != 0)
				errors++;
			else
				count++;
		}
		if (count != 4)
			errors++;
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
		printf("An error occured while reading file %s through STDIN", filename);
	}
	return (0);
}
