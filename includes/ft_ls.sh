#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then


declare -a CHK_FT_LS='( "check_ft_ls_all" "all" "check_author" "auteur" "check_norme" "norminette" "check_ft_ls_forbidden_func" "forbidden functions" "check_ft_ls_moulitest" "moulitest (yyang@student.42.fr)" )'

declare -a CHK_FT_LS_AUTHORIZED_FUNCS='(write opendir readdir closedir stat lstat getpwuid getgrgid listxattr getxattr time ctime readlink malloc free perror strerror exit main)'

function check_ft_ls_all
{
	local FUNC TITLE i j RET0 MYPATH
	MYPATH=$(get_config "ft_ls")
	configure_moulitest "ft_ls" "$MYPATH"
	i=2
	j=1;
	display_header
	display_righttitle ""
	check_ft_ls_top "$MYPATH"
	while [ "${CHK_FT_LS[$i]}" != "" ]
	do
		FUNC=${CHK_FT_LS[$i]}
		(( i += 1 ))
		TITLE=${CHK_FT_LS[$i]}
		printf "  $C_WHITE$j -> $TITLE$C_CLEAR\n"
		(eval "$FUNC" "all" > .myret) &
		display_spinner $!
		RET0=`cat .myret`
		printf "$RET0\n"
		printf "\n"
		(( j += 1 ))
		(( i += 1 ))
	done
	display_menu\
		""\
		main "OK"\
		"open .mynorminette" "see details: norminette"\
		"open .myforbiddenfunc" "see details: forbidden functions"\
		"open .mymoulitest" "see details: moulitest"
}

function check_ft_ls_forbidden_func
{
	local RET0
	RET0=`make -C "$MYPATH" 2>&1`
	if [ -f "$MYPATH/ft_ls" ]
	then
		check_forbidden_func CHK_FT_LS_AUTHORIZED_FUNCS "$MYPATH/ft_ls"
	else
		printf $C_RED"  Test not performed (see details)"$C_CLEAR
		echo "$RET0" > .myforbiddenfunc
	fi
}

function check_ft_ls_moulitest
{
	local RET0 TOTAL
	if [ -d moulitest ]
	then
		rm -f "$RETURNPATH"/.mymoulitest
		cd "$RETURNPATH/moulitest/"
		make ft_ls 1> "$RETURNPATH"/.mymoulitest 2>&1
		cd "$RETURNPATH"
		RET0=`cat .mymoulitest | sed 's/\^\[\[[0-9;]*m//g' | sed 's/\^\[\[0m//g' | sed 's/\$$//' | grep "STARTING ALL UNIT TESTS"`
		if [ "$RET0" == "" ]
		then
			printf $C_RED"  Fatal error: moulitest cannot compile (see details)"$C_CLEAR
		else
			RET0=`cat .mymoulitest | sed 's/\^\[\[[0-9;]*m//g' | sed 's/\^\[\[0m//g' | sed 's/\$$//' | grep "END OF UNIT TESTS"`
			if [ "$RET0" == "" ]
			then
				printf $C_RED"  Fatal error: moulitest has aborted (see details)"$C_CLEAR
			else
				RET0=`cat -e .mymoulitest | grep FAIL | sed 's/\^\[\[[0-9;]*m//g' | sed 's/\^\[\[0m//g' | sed 's/\$$//' | awk 'BEGIN {OFS = ""} {print "  ",$0}'`
				if [ "$RET0" != "" ]
				then
					TOTAL=`printf "$RET0" | wc -l | sed 's/ //g'`
					printf $C_RED"  $TOTAL failed test(s)"$C_CLEAR
				else
					printf $C_GREEN"  All Unit Tests passed"$C_CLEAR
				fi
			fi
		fi
		RET0=`cat -e .mymoulitest | sed 's/\^\[\[[0-9;]*m//g' | sed 's/\^\[\[0m//g' | sed 's/\$$//'`
		echo "$RET0" > "$RETURNPATH"/.mymoulitest
	else
		printf $C_RED"  'moulitest' is not installed"$C_CLEAR
	fi
}

function check_ft_ls
{
	local MYPATH
	MYPATH=$(get_config "ft_ls")
	display_header
	display_righttitle ""
	check_ft_ls_top "$MYPATH"
	if [ -d "$MYPATH" ]
	then
		display_menu\
            ""\
			check_ft_ls_all "check it!"\
			config_ft_ls "change path"\
			main "BACK TO MAIN MENU"
	else
		display_menu\
			""\
			config_ft_ls "configure"\
			main "BACK TO MAIN MENU"
	fi
}

function config_ft_ls
{
	local AB0 AB2 MYPATH
	MYPATH=$(get_config "ft_ls")
	display_header
	display_righttitle ""
	check_ft_ls_top "$MYPATH"
	echo "  Please type the absolute path to your project:"$C_WHITE
	cd "$HOME/"
	tput cnorm
	read -p "  $HOME/" -e AB0
	tput civis
	AB0=`echo "$AB0" | sed 's/\/$//'`
	AB2="$HOME/$AB0"
	while [ "$AB0" == "" -o ! -d "$AB2" ]
	do
		display_header
		display_righttitle ""
		check_ft_ls_top
		echo "  Please type the absolute path to your project:"
		if [ "$AB0" != "" ]
		then
			echo $C_RED"  $AB2: No such file or directory"$C_CLEAR$C_WHITE
		else
			printf $C_WHITE
		fi
		tput cnorm
		read -p "  $HOME/" -e AB0
		tput civis
		AB0=`echo "$AB0" | sed 's/\/$//'`
		AB2="$HOME/$AB0"
	done
	cd "$RETURNPATH"
	save_config "ft_ls" "$AB2"
	printf $C_CLEAR""
	check_ft_ls
}

function check_ft_ls_top
{
	printf "$C_GREY"
	display_center "FT_LS"
	printf "\n"$C_CLEAR
	if [ "$1" != "" ]
	then
		printf "  "$C_WHITE"Current configuration:$C_CLEAR\n  $1\n\n"
	fi
}

fi;