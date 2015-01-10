#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then


function update
{
	local UPTODATE MOULIDATE VERSION RET0 RET1 LOCALHASH REMOTEHASH
	tput civis
	display_header
	printf "\n\n"
	printf "  Checking for updates...\n"
	(check_for_update > .myret) &
	display_spinner $!
	UPTODATE=`cat .myret`
	if [ "$UPTODATE" == "1" ]
	then
		(check_for_moulitest > .myret) &
		display_spinner $!
		display_header
		printf "\n\n"
		MOULIDATE=`cat .myret`
		if [ "$MOULIDATE" == "0" ]
		then
			printf $C_RED"  Your version of 'moulitest' (https://github.com/yyang42/moulitest) is out-of-date.\n  Choose UPDATE MOULITEST (1) for installing the latest version or SKIP UPDATE (2) if you want to skip this warning.\n\n"$C_CLEAR
			display_menu\
			   	""\
                install_update_moulitest "UPDATE MOULITEST"\
				"" "SKIP UPDATE"\
                exit_checker "EXIT"
		fi
		if [ "$MOULIDATE" == "2" ]
		then
			printf $C_RED"  The 'moulitest' (https://github.com/yyang42/moulitest) is not installed.\n  Choose INSTALL MOULITEST (1) for installing it or SKIP INSTALL (2) if you want to skip this warning.\n\n"$C_CLEAR
			display_menu\
             	""\
                install_update_moulitest "INSTALL MOULITEST"\
				"" "SKIP INSTALL"\
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
			display_header
			printf "\n\n"
			LOCALHASH=`git show-ref | grep -v remotes | cut -d" " -f1`
			REMOTEHASH=`git ls-remote 2>/dev/null | grep HEAD | cut -f1`
			VERSION=$(git shortlog origin/master -s | awk 'BEGIN {rev=0} {rev+=$1} END {printf rev}')
			printf $C_RED""
			if [ "$REMOTEHASH" != "$LOCALHASH" ]
			then
				display_center "Your version of '42FileChecker' is out-of-date."
				display_center "REMOTE: r$VERSION       LOCAL: r$CVERSION"
				RET0=`git show-ref | grep -v remotes | cut -d" " -f1`
				if [ "$RET0" != "" ]
				then
					RET1=`git log origin/master --pretty=oneline 2>/dev/null | awk -v lhash=$RET0 '{if ($1 == lhash) {exit} print}' | cut -d" " -f2- | awk '{print "  -> "$0}'`
					if [ "$RET1" != "" ]
					then
						printf "\n\n  Last commits:\n$RET1\n"
					fi
				fi
			else
				display_center "Your copy of '42FileChecker' has been modified locally."
				display_center "Skip update if you don't want to erase your changes."
			fi
			printf "\n  Choose UPDATE 42FILECHECKER (1) for installing the last version or skip this warning by choosing SKIP UPDATE (2) or by using '--no-update' at launch.\n\n"$C_CLEAR
			display_menu\
              	""\
                install_update "UPDATE 42FILECHECKER"\
				"" "SKIP UPDATE"\
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
	printf "\n\n"
	printf "  Updating 42FileChecker\n"
	(git merge origin/master 2>&1 > .myret) &
	display_spinner $!
	RES0=`cat .myret`
	sleep 0.5
	if [ "$RES0" == "" ]
	then
		printf $C_BLUE"  Done.\n"$C_CLEAR
		git shortlog -s | awk 'BEGIN {rev=0} {rev+=$1} END {printf rev"\n"}' > .myrev 2>/dev/null
		sleep 0.5
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
			git shortlog -s | awk 'BEGIN {rev=0} {rev+=$1} END {printf rev"\n"}' > .myrev 2>/dev/null
			sleep 0.5
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
		printf "\n\n"
		printf "  Installing moulitest...\n"
		(git clone https://github.com/yyang42/moulitest > .myret 2>&1) &
		display_spinner $!
		RES0=`cat .myret`
		RES2=`echo "$RES0" | grep fatal`
		if [ "$RES2" != "" ]
		then
			display_error "An error occured."
			printf $C_RED"$(echo "$RES0" | awk 'BEGIN {OFS=""} {print "  ",$0}')"$C_CLEAR
			exit_checker
		else
			printf $C_BLUE"  Done.\n"$C_CLEAR
			sleep 0.5
			main
		fi
	else
		display_header
		printf "\n\n"
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