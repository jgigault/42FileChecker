#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  declare -a CHK_FDF_AUTHORIZED_FUNCS='(open read write close malloc free exit perror strerror main)'
  declare -a CHK_FILLIT_AUTHORIZED_FUNCS='(exit open close write read malloc free main)'
  declare -a CHK_FT_LS_AUTHORIZED_FUNCS='(write opendir readdir closedir stat lstat getpwuid getgrgid listxattr getxattr time ctime readlink malloc free perror strerror exit main)'
  declare -a CHK_FT_P_AUTHORIZED_FUNCS='(write malloc free exit socket open close setsockopt getsockname getprotobyname gethostbyname getaddrinfo bind connect listen accept htons htonl ntohs ntohl inet_addr inet_ntoa send recv execve execl dup2 wait4 fork getcwd printf signal mmap munmap lseek fstat opendir readdir closedir chdir mkdir unlink select main)'
  declare -a CHK_FT_PRINTF_AUTHORIZED_FUNCS='(write malloc free exit main)'
  declare -a CHK_GNL_AUTHORIZED_FUNCS='(read malloc free get_next_line main)'
  declare -a CHK_LIBFT_AUTHORIZED_FUNCS='(free malloc write main)'
  declare -a CHK_LIBFTASM_AUTHORIZED_FUNCS='(malloc write read main)'
  declare -a CHK_MINISHELL_AUTHORIZED_FUNCS='(malloc free access open close read write opendir readdir closedir getcwd chdir stat lstat fstat fork execve wait waitpid wait3 wait4 signal kill exit main)'
  declare -a CHK_PUSH_SWAP_AUTHORIZED_FUNCS='(write read malloc free exit main)'

fi
