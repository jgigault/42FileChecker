/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   cat.c                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/06/01 15:48:00 by jgigault          #+#    #+#             */
/*   Updated: 2015/06/01 15:58:00 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <strings.h>
#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int			i;
	int			fd;


	if (argc == 3)
	{
		i = atoi(argv[1]);
		if (i == 0)
		{
			printf("Montpellier, first mentioned in a document of 985, was founded under a local feudal dynasty, the Guilhem, who combined two hamlets and built a castle and walls around the united settlement.\nThe two surviving towers of the city walls, the Tour des Pins and the Tour de la Babotte, were built later, around the year 1200.\n\n");
		}
	}
	return (0);
}
