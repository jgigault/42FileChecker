# 42FileChecker

<img align="right"  src="http://i.imgur.com/6pC7t9P.png" width="50%" />42FileChecker is a tiny bash script developped at 42 school for testing and checking the files according to the rules of the subjects.

The script is designed as a reminder:
* author file terminated by a Line Feed
* count and names of files
* code's standard
* required and forbidden functions
* macro and static variables declarations
* makefile rules

Basic tests with compilation are also available for get_next_line and ft_printf (beta), whilst complete unit tests are handled by the "moulitest" (https://github.com/yyang42/moulitest) which is automatically installed and updated.

## install & launch
	git clone https://github.com/jgigault/42FileChecker ~/42FileChecker
	cd ~/42FileChecker && sh ./42FileChecker.sh

## supported projects
* libft
* get_next_line
* ft_ls
* ft_printf

## options
	--no-update   // Do not check for updates at launch
	--no-color    // Do not display color tags
	--no-timeout  // Disable time-out child process

## dependencies
* The script may automatically install and update the latest version of the "moulitest" project: https://github.com/yyang42/moulitest
* The "norminette" program from 42 school is required