# 42FileChecker

<img align="right"  src="http://i.imgur.com/6pC7t9P.png" width="50%" />42FileChecker is a tiny bash script developped at 42 school for testing and checking the files according to the rules of the subjects.

The script is designed as a reminder:
* author file terminated by a Line Feed
* count and names of files
* code's standard
* required and forbidden functions
* macro and static variables declarations

Basic tests with compilation are also available for get_next_line and complete unit tests are handled by the "moulitest" (please refer to the dependencies bellow).

## install & launch
	git clone https://github.com/jgigault/42FileChecker ~/42FileChecker
	cd ~/42FileChecker && sh ./42FileChecker.sh

## options
	--no-update   // Do not check for updates at launch
	--no-color    // Do not display color tags

## supported projects
* libft
* get_next_line

## dependencies
* The script automatically download, configure and launch for you the latest version of the "moulitest" project (Yan Yang): https://github.com/yyang42/moulitest
* The "norminette" program from 42 school is required