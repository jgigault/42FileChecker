/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   gnl11.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/01/06 10:00:52 by jgigault          #+#    #+#             */
/*   Updated: 2015/01/06 10:27:08 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <string.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include "gnl.h"

int				main(int argc, char **argv)
{
	char		*line1;
	char		*line2;
	int			fd1;
	int			fd2;
	int			ret1;
	int			ret2;
	char		*filename1;
	char		*filename2;
	int			errors;

	filename1 = "./srcs/gnl/gnl11_1.txt";
	filename2 = "./srcs/gnl/gnl11_2.txt";
	fd1 = open(filename1, O_RDONLY);
	fd2 = open(filename2, O_RDONLY);
	if (argc && argv && fd1 > 2 && fd2 > 2)
	{
		errors = 0;
		line1 = NULL;
		line2 = NULL;

		ret1 = get_next_line(fd1, &line1);
		if (ret1 == 1 && strcmp(line1, "The getdelim() function reads a line from stream, delimited by the character") != 0)
			errors++;
		ret1 = get_next_line(fd1, &line1);
		if (ret1 == 1 && strcmp(line1, "delimiter.  The getline() function is equivalent to getdelim() with the new-") != 0)
			errors++;
		ret1 = get_next_line(fd1, &line1);
		if (ret1 == 1 && strcmp(line1, "line character as the delimiter.  The delimiter character is included as") != 0)
			errors++;
		ret1 = get_next_line(fd1, &line1);
		if (ret1 == 1 && strcmp(line1, "part of the line, unless the end of the file is reached.") != 0)
			errors++;

		ret2 = get_next_line(fd2, &line2);
		if (ret2 == 1 && strcmp(line2, "The Festival de Radio France et Montpellier is a summer festival of opera and other music held in Montpellier.") != 0)
			errors++;
		ret2 = get_next_line(fd2, &line2);
		if (ret2 == 1 && strcmp(line2, "The festival concentrates on classical music and jazz with about 150 events, including opera, concerts, films, and talks. ") != 0)
			errors++;
		ret2 = get_next_line(fd2, &line2);
		if (ret2 == 1 && strcmp(line2, "Most of these events are free and are held in the historic courtyards of the city or in the modern concert halls of Le Corum. ") != 0)
			errors++;
		ret2 = get_next_line(fd2, &line2);
		if (ret2 == 1 && strcmp(line2, "Le Corum cultural and conference centre contains 3 auditoriums. ") != 0)
			errors++;

		ret1 = get_next_line(fd1, &line1);
		if (ret1 == 1 && strcmp(line1, "") != 0)
			errors++;
		ret1 = get_next_line(fd1, &line1);
		if (ret1 == 1 && strcmp(line1, "The caller may provide a pointer to a malloced buffer for the line in") != 0)
			errors++;

		ret2 = get_next_line(fd2, &line2);
		if (ret2 == 1 && strcmp(line2, "The city is a center for cultural events since there are many students. ") != 0)
			errors++;

		close(fd1);
		close(fd2);
		if (errors > 0)
		{
			printf("%d errors", errors);
		}
		else
		{
			printf("OK");
		}
	}
	else
	{
		printf("An error occured while opening files %s and/or %s", filename1, filename2);
	}
	return (0);
}
