#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then


declare -a CHK_FT_LS='( "check_ft_ls_all" "all" "check_author" "auteur" "check_norme" "norminette" "check_ft_ls_makefile" "makefile" "check_ft_ls_forbidden_func" "forbidden functions" "check_ft_ls_leaks" "leaks" "check_ft_ls_speedtest" "speed test" "check_ft_ls_moulitest" "moulitest (https://github.com/yyang42/moulitest)" )'

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
		RET0=`cat .myret | sed 's/%/%%/g'`
		printf "$RET0\n"
		printf "\n"
		(( j += 1 ))
		(( i += 1 ))
	done
	display_menu\
		""\
		main "OK"\
		"open .mynorminette" "more info: norminette"\
		"open .mymakefile" "more info: makefile"\
		"open .myforbiddenfunc" "more info: forbidden functions"\
		"open .myleaks" "more info: leaks"\
		"open .myspeedtest" "more info: speed test"\
		"open .mymoulitest" "more info: moulitest"
}

function check_ft_ls_speedtest
{	if [ "$OPT_NO_SPEEDTEST" == "0" ]; then
	local LOGFILENAME
	LOGFILENAME=.myspeedtest
	rm -f $LOGFILENAME
	touch $LOGFILENAME
	make re -C "$MYPATH" >/dev/null
	if [ -f "$MYPATH/ft_ls" ]
	then
		check_speedtest "$MYPATH/ft_ls" "ls" "-1lR /" "$LOGFILENAME" "Your program is compared with the original 'ls'.\n\n"
	else
		printf $C_RED"  Fatal error: Cannot compile"$C_CLEAR
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_ft_ls_leaks
{	if [ "$OPT_NO_LEAKS" == "0" ]; then
	local RET0 LOGFILENAME PROGNAME
	LOGFILENAME=.myleaks
	rm -f $LOGFILENAME
	touch $LOGFILENAME
	make re -C "$MYPATH" >/dev/null
	if [ -f "$MYPATH/ft_ls" ]
	then
		check_leaks "$MYPATH/ft_ls" "-1R /" "$LOGFILENAME" ""
	else
		printf $C_RED"  Fatal error: Cannot compile"$C_CLEAR
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_ft_ls_makefile
{	if [ "$OPT_NO_MAKEFILE" == "0" ]; then
	local MYPATH
	MYPATH=$(get_config "ft_ls")
	check_makefile "$MYPATH" ft_ls
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_ft_ls_forbidden_func
{	if [ "$OPT_NO_FORBIDDEN" == "0" ]; then
	local RET0
	RET0=`make -C "$MYPATH" 2>&1`
	if [ -f "$MYPATH/ft_ls" ]
	then
		check_forbidden_func CHK_FT_LS_AUTHORIZED_FUNCS "$MYPATH/ft_ls"
	else
		printf $C_RED"  Test not performed (see details)"$C_CLEAR
		echo "$RET0" > .myforbiddenfunc
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_ft_ls_moulitest
{	if [ "$OPT_NO_MOULITEST" == "0" ]; then
	check_moulitest "ft_ls"
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
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
	local LPATH=$1
	local LHOME LEN
	LHOME=`echo "$HOME" | sed 's/\//\\\\\\//g'`
	LPATH="echo \"$LPATH\" | sed 's/$LHOME/~/'"
	LPATH=`eval $LPATH`
	printf $C_WHITE"\n"
	if [ "$1" != "" ]
	then
		printf "  Current configuration:"
		(( LEN=$COLUMNS - 24 ))
		printf "%"$LEN"s" "FT_LS  "
		printf $C_CLEAR"  $LPATH\n\n"
	else
		printf "  FT_LS\n"
		printf "\n"
	fi
	printf ""$C_CLEAR
}

fi;