# include <stdio.h>
# include <fcntl.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include "get_next_line.h"
#include <string.h>
//#include "libft/includes/libft.h"


int main(void) 
{

	char *line; 
	int total;
	int total_lines;
	int total_errors;
	line = NULL;
	total_errors = 0;
	total_lines = 0;
	total = 0;
	if (get_next_line(0, &line) == 1)
	{


		if (strcmp(line, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed risus massa, laoreet id tempus vitae, egestas vitae augue. Sed efficitur sapien nec lacus consectetur, ornare pharetra sem posuere. Quisque eu lacinia augue. Sed sit amet consequat mauris. Aliquam ac ex leo. Sed lacinia elementum tincidunt. Cras vel justo tincidunt, elementum nunc eget, congue est. Proin ut ipsum condimentum, facilisis mi et, tincidunt lorem. Curabitur congue, elit eget sollicitudin convallis, odio ex imperdiet metus, ornare laoreet enim elit sed urna. Phasellus vel turpis sed sem auctor condimentum a quis elit. Vestibulum porta libero non ligula pharetra sodales. In eget felis at enim vestibulum ultricies quis vel velit. Proin faucibus laoreet libero. Integer in orci eget velit hendrerit pulvinar. Aenean non dolor sed sapien finibus sodales.") != 0)
			total_errors++;
		total += strlen(line);
        total_lines++;
	}
    if (get_next_line(0, &line) == 1)
    {
		if (strcmp(line, "") != 0)
			total_errors++;
        total += strlen(line);
		total_lines++;
    }
    if (get_next_line(0, &line) == 1)
    {
		if (strcmp(line, "Aliquam magna magna, rhoncus gravida dignissim vel, maximus quis nibh. Nunc ut leo iaculis, commodo mauris eu, sollicitudin odio. Vestibulum sagittis augue vitae lorem porta, ut sodales mi porta. Aliquam erat volutpat. Nam luctus leo vestibulum tortor tempus, id tempus diam eleifend. Aliquam tempor tellus vel felis aliquet vestibulum. Nunc molestie elementum nisi, quis ultrices erat volutpat at. Quisque sit amet dui magna. Integer ac nisl lorem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris accumsan lacus ac odio congue aliquet. Donec a mollis libero. In justo odio, elementum in odio id, dignissim cursus sem. Pellentesque consequat leo vitae massa accumsan ullamcorper.") != 0)
			total_errors++;
        total += strlen(line);
		total_lines++;
    }
    if (get_next_line(0, &line) == 1)
    {
        if (strcmp(line, "") != 0)
            total_errors++;
        total += strlen(line);
		total_lines++;
    }
    if (get_next_line(0, &line) == 1)
    {
		if (strcmp(line, "Sed sed iaculis ex. Aenean vitae malesuada mauris. In in porta purus. Donec molestie urna sit amet ante feugiat congue. Integer iaculis est nec feugiat eleifend. Ut placerat risus vitae odio tempor eleifend sed nec purus. Nullam lacus dui, aliquam non posuere ac, imperdiet sit amet quam. Morbi fermentum accumsan risus, a egestas neque scelerisque lobortis. Curabitur bibendum, ligula tempor vulputate vulputate, velit nisi interdum justo, id feugiat velit orci nec ex. Cras vulputate aliquam porttitor.") != 0)
			total_errors++;
        total += strlen(line);
		total_lines++;
    }

    if (total_errors == 0 && total_lines == 5 && total == 2029)
    {
        printf("\033[0;32mOK");
    }
    else
    {
		printf("\nNombre de caracteres lus : %d\n", total);
		printf("Nombre de caracteres attendus : 2029\n");
		printf("Nombre de lignes lues : %d\n", total_lines);
		printf("Nombre de lignes attendues : 5\n");
	}
	free (line);
	return (0);
}
