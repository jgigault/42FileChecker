/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_printf.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jgigault <jgigault@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2015/01/07 11:40:52 by jgigault          #+#    #+#             */
/*   Updated: 2015/01/10 14:15:46 by jgigault         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../tmp/printf.h"
#include <stdlib.h>
#include <stdio.h>

int				main(int argc, char **argv)
{
	int		ret;
	char	*str;

	(void)argc;
	if (argv[1][0] == 'p')
	{
		ret = ft_printf(argv[2], (void *)(str = "I am a void"));
	}
	else
	{
		ret = ft_printf(argv[2]);
	}
	printf("|%d", ret);
	return (0);
}
