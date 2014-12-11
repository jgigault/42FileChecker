#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then


function update
{
	local UPTODATE MOULIDATE
	tput civis
	display_header
	display_righttitle ""
	printf "  Checking for updates...\n"
	(check_for_update > .myret) &
	display_spinner $!
	UPTODATE=`cat .myret`
	if [ "$UPTODATE" == "1" ]
	then
		(check_for_moulitest > .myret) &
		display_spinner $!
		MOULIDATE=`cat .myret`
		if [ "$MOULIDATE" == "0" ]
		then
			printf $C_RED"  Your version of 'moulitest' (yyang42@student.42.fr) is out-of-date.\n  Choose UPDATE MOULITEST (1) for getting the last version.\n\n"$C_CLEAR
			display_menu\
			   	""\
                install_update_moulitest "UPDATE MOULITEST"\
                exit_checker "EXIT"
		fi
		if [ "$MOULIDATE" == "2" ]
		then
			printf $C_RED"  The 'moulitest' (yyang42@student.42.fr) is not installed.\n  Choose INSTALL MOULITEST (1) for getting it.\n\n"$C_CLEAR
			display_menu\
             	""\
                install_update_moulitest "INSTALL MOULITEST"\
                exit_checker "EXIT"
		fi
	else
		if [ "$UPTODATE" == "2" ]
		then
			display_error "An error occured."
			printf $C_RED"$(cat .myret2 | awk 'BEGIN {OFS=""} {print "  ",$0}')"$C_CLEAR
			exit_checker
			printf "UPTODATE2" > .myret
		else
			printf $C_RED"  Your version of '42FileChecker' is out-of-date.\n  Choose UPDATE 42FILECHECKER (1) for getting the last version.\n\n"$C_CLEAR
			display_menu\
              	""\
                install_update "UPDATE 42FILECHECKER"\
                exit_checker "EXIT"
		fi
	fi
}


function check_for_update
{
	local DIFF0
	DIFF0=`git fetch origin 2>&1 | tee .myret2 | grep fatal`
	if [ "$DIFF0" != "" ]
	then
		printf "2"
	else
		DIFF0=`git diff origin/master 2>&1 | sed 's/\"//'`
		if [ "$DIFF0" != "" ]
		then
			printf "0"
		else
			printf "1"
		fi
	fi
}

function install_update
{
	local RES0
	display_header
	display_righttitle ""
	printf "  Updating 42FileChecker\n"
	(git merge origin/master 2>&1 > .myret) &
	display_spinner $!
	RES0=`cat .myret`
	sleep 0.5
	if [ "$RES0" == "" ]
	then
		printf $C_BLUE"  Done.\n"$C_CLEAR
		sleep 0.1
		display_hr
		printf $C_WHITE"\n  Please restart the program with the following command line: "$C_CLEAR"\n  sh ./42FileChecker.sh\n\n"
		tput cnorm
		#exit
		sh ./42FileChecker.sh
	else
		RES0=`git reset --hard origin/master 2>&1`
		RES0=`git merge origin/master 2>&1`
		if [ "$RES0" == "" ]
		then
			display_error "An error occured."
			printf $C_RED"\n  You should better discard your repository and clone again.\n"$C_CLEAR
			tput cnorm
		else
			printf $C_BLUE"  Done.\n"$C_CLEAR
			sleep 0.1
			display_hr
			printf $C_WHITE"\n  Please restart the program with the following command line: "$C_CLEAR"\n  sh ./42FileChecker.sh\n\n\n\n\n"
			tput cnorm
			#exit
			sh ./42FileChecker.sh
		fi
	fi
}

function check_for_moulitest
{
	local DIFF0
	if [ ! -d moulitest ]
	then
		printf "2"
	else
		cd moulitest
		DIFF0=`git fetch origin 1>/dev/null 2>&1`
		DIFF0=`git diff origin/master 2>&1 | sed 's/\"//'`
		cd ..
		if [ "$DIFF0" != "" ]
		then
			printf "0"
		else
			printf "1"
		fi
	fi
}


function install_update_moulitest
{
	local RES0 RES2
	if [ ! -d moulitest ]
	then
		display_header
		display_righttitle ""
		printf "  Installing moulitest...\n"
		(git clone https://github.com/yyang42/moulitest > .myret 2>&1) &
		display_spinner $!
		RES0=`cat .myret`
		RES2=`echo "$RES0" | grep fatal`
		if [ "$RES2" != "" ]
		then
			display_error "An error occured."
			printf $C_RED"$(echo "$RES0" | awk 'BEGIN {OFS=""} {print "  ",$0}')"$C_CLEAR
			tput cnorm
			exit_checker
		else
			printf $C_BLUE"  Done.\n"$C_CLEAR
			sleep 0.5
			main
		fi
	else
		display_header
		display_righttitle ""
		cd moulitest
		printf "  Updating moulitest...\n"
		((git reset --hard origin/master > .myret 2>&1) && git merge origin/master > .myrest 2>&1) &
		RES0=`cat .myret`
		RES2=`echo "$RES0" | grep fatal`
		display_spinner $!
		cd ..
		if [ "$RES2" == "" ]
		then
			display_error "An error occured."
			printf $C_RED"$(echo "$RES0" | awk 'BEGIN {OFS=""} {print "  ",$0}')"$C_CLEAR
			printf "\n"
		else
			printf $C_BLUE"  Done.\n"$C_CLEAR
			sleep 0.5
			main
		fi
	fi
}

fi