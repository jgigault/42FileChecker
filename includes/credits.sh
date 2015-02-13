#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	function display_credits
	{
		local SEL LEN
		clear
		display_header
		printf "\n\n"
		printf "  42FileChecker is a tiny bash script developped at 42 school for testing and checking the files according to the rules of the subjects.\n\n"
		printf "  The script has the following dependencies:\n\n"
		printf "  $C_WHITE-> norminette (42 born2code)\n"$C_CLEAR
		printf "     http://www.42.fr\n\n"
		printf "  $C_WHITE-> moulitest (yyang42)\n"$C_CLEAR
		printf "     ${MOULITEST_URL}\n\n"
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