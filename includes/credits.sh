#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	function display_credits
	{
		local SEL LEN
		display_header
		printf "\n\n"
		printf "  42FileChecker is a tiny bash script developped at 42 school for testing and checking the files according to the rules of the subjects.\n\n"
		printf "  The script has the following dependencies:\n\n"
		printf "  $C_WHITE-> norminette (42 born2code)\n"$C_CLEAR
		printf "     http://www.42.fr\n\n"
		printf "  $C_WHITE-> moulitest (yyang42 and other contributors)\n"$C_CLEAR
		printf "     ${MOULITEST_URL}\n\n"
		printf "  $C_WHITE-> libft-unit-test (alelievr)\n"$C_CLEAR
		printf "     ${LIBFTUNITTEST_URL}\n\n"
		printf "  $C_WHITE-> fillit_checker (anisg)\n"$C_CLEAR
		printf "     ${EXTERNAL_REPOSITORY_FILLITCHECKER_URL}\n\n"
		printf "  $C_WHITE-> Maintest (QuentinPerez and other contributors)\n"$C_CLEAR
		printf "     ${EXTERNAL_REPOSITORY_MAINTEST_URL}\n\n"
		printf "  $C_WHITE-> 42ShellTester (gabkk, jgigault)\n"$C_CLEAR
		printf "     ${EXTERNAL_REPOSITORY_42SHELLTESTER_URL}\n\n"
		printf "  Other credits:\n\n"
		printf "  $C_WHITE-> Text to ASCII Art Generator (patorjk@gmail.com)\n"$C_CLEAR
		printf "     http://patorjk.com/software/taag/\n\n"
		printf $C_INVERT""
		printf "%"$COLUMNS"s" " "
		printf "  Press ENTER to continue..."
		(( LEN=$COLUMNS - 28 ))
		printf "%"$LEN"s" " "
		printf "%"$COLUMNS"s" " "
		printf ""$C_CLEAR
		read -s SEL
		main
	}

fi;
