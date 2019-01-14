#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <time.h>
#include <stdlib.h>

/*
**  retrieve inode of the given file
*/

static char*	formatdate(char* str, time_t val)
{
	strftime(str, 14, "%Y%m%d%H%M%S", localtime(&val));
	return str;
}

int				main(int argc, char **argv)
{
	int			fd;
	int			ret;
	struct stat	st;
	char		date[14];

	if (argc != 2)
		return (1);
	fd = open(argv[0], O_RDONLY);
	if (fd < 0)
		return (2);
	ret = fstat(fd, &st);
	close(fd);
	if (ret < 0)
		return (3);
	printf("%llu/%s", st.st_ino, formatdate(date, st.st_mtime));
	return (0);
}