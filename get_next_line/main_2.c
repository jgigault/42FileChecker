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

	int fd1;
	char *line; 
	int total;
	int total_lines;
	int total_errors;

	line = NULL;
	fd1 = open("test_2.txt", O_RDONLY);
	total_errors = 0;
	total_lines = 0;
	total = 0;
	while (get_next_line(fd1, &line) == 1)
	{

		if (total_lines == 0)
		{
			if (strcmp(line, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed risus massa, laoreet id tempus vitae, egestas vitae augue. Sed efficitur sapien nec lacus consectetur, ornare pharetra sem posuere. Quisque eu lacinia augue. Sed sit amet consequat mauris. Aliquam ac ex leo. Sed lacinia elementum tincidunt. Cras vel justo tincidunt, elementum nunc eget, congue est. Proin ut ipsum condimentum, facilisis mi et, tincidunt lorem. Curabitur congue, elit eget sollicitudin convallis, odio ex imperdiet metus, ornare laoreet enim elit sed urna. Phasellus vel turpis sed sem auctor condimentum a quis elit. Vestibulum porta libero non ligula pharetra sodales. In eget felis at enim vestibulum ultricies quis vel velit. Proin faucibus laoreet libero. Integer in orci eget velit hendrerit pulvinar. Aenean non dolor sed sapien finibus sodales.") != 0)
				total_errors++;
		}
        if (total_lines == 1)
		{
            if (strcmp(line, "") != 0)
                total_errors++;
        }
		if (total_lines == 2)
		{
            if (strcmp(line, "Aliquam magna magna, rhoncus gravida dignissim vel, maximus quis nibh. Nunc ut leo iaculis, commodo mauris eu, sollicitudin odio. Vestibulum sagittis augue vitae lorem porta, ut sodales mi porta. Aliquam erat volutpat. Nam luctus leo vestibulum tortor tempus, id tempus diam eleifend. Aliquam tempor tellus vel felis aliquet vestibulum. Nunc molestie elementum nisi, quis ultrices erat volutpat at. Quisque sit amet dui magna. Integer ac nisl lorem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris accumsan lacus ac odio congue aliquet. Donec a mollis libero. In justo odio, elementum in odio id, dignissim cursus sem. Pellentesque consequat leo vitae massa accumsan ullamcorper.") != 0)
				total_errors++;
		}
		if (total_lines == 3)
        {
            if (strcmp(line, "") != 0)
                total_errors++;
		}
        if (total_lines == 4)
		{
            if (strcmp(line, "Sed sed iaculis ex. Aenean vitae malesuada mauris. In in porta purus. Donec molestie urna sit amet ante feugiat congue. Integer iaculis est nec feugiat eleifend. Ut placerat risus vitae odio tempor eleifend sed nec purus. Nullam lacus dui, aliquam non posuere ac, imperdiet sit amet quam. Morbi fermentum accumsan risus, a egestas neque scelerisque lobortis. Curabitur bibendum, ligula tempor vulputate vulputate, velit nisi interdum justo, id feugiat velit orci nec ex. Cras vulputate aliquam porttitor.") != 0)
                total_errors++;
        }
        if (total_lines == 5)
		{
            if (strcmp(line, "") != 0)
                total_errors++;
        }
        if (total_lines == 6)
		{
            if (strcmp(line, "Etiam quis aliquet elit. Sed ut consequat dolor. Nullam aliquet nibh non aliquam efficitur. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris non rhoncus felis. Vestibulum tincidunt tortor et pellentesque tempor. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras ullamcorper sapien a libero volutpat pretium.") != 0)
                total_errors++;
        }
        if (total_lines == 7)
		{
            if (strcmp(line, "") != 0)
                total_errors++;
        }
        if (total_lines == 8)
		{
            if (strcmp(line, "Aenean nec mi orci. Donec commodo quam ac leo varius, ac consequat dui vulputate. Curabitur ut vulputate arcu, et tristique odio. Duis nibh justo, ultricies efficitur pharetra ut, sagittis a nibh. Aenean accumsan dapibus vehicula. Vestibulum ut tincidunt purus. Aenean augue nulla, eleifend vitae rhoncus eget, scelerisque quis lectus. Aenean a rutrum velit.") != 0)
                total_errors++;
        }

		total += strlen(line);
		total_lines++;
	}
    if (total_errors == 0 && total_lines == 9 && total == 2750)
    {
        printf("\033[0;32mOK");
    }
    else
    {
		printf("\nNombre de caracteres lus : %d\n", total);
		printf("Nombre de caracteres attendus : 2750\n");
		printf("Nombre de lignes lues : %d\n", total_lines);
		printf("Nombre de lignes attendues : 9\n");
	}
	close(fd1);
	free (line);
	return (0);
}
