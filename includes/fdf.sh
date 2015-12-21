#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

declare -a CHK_FDF='( "check_author" "auteur" "check_norme" "norminette" "check_fdf_makefile" "makefile" "check_fdf_forbidden_func" "forbidden functions" )'

declare -a CHK_FDF_AUTHORIZED_FUNCS='(open read write close malloc free exit perror strerror main)'

function check_fdf_all
{
	local FUNC TITLE i j RET0 MYPATH
	MYPATH=$(get_config "fdf")
	configure_moulitest "fdf" "$MYPATH"
	i=0
	j=1
	display_header
	check_fdf_top "$MYPATH"
	while [ "${CHK_FDF[$i]}" != "" ]
	do
		FUNC="${CHK_FDF[$i]}"
		(( i += 1 ))
		TITLE=`echo "${CHK_FDF[$i]}"  | sed 's/%/%%/g'`
		printf "  $C_WHITE$j -> $TITLE$C_CLEAR\n"
		(eval "$FUNC" > .myret) &
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
		"open .myforbiddenfunc" "more info: forbidden functions"
}

function check_fdf_makefile
{	if [ "$OPT_NO_MAKEFILE" == "0" ]; then
	check_makefile "$MYPATH" fdf
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_fdf_forbidden_func
{	if [ "$OPT_NO_FORBIDDEN" == "0" ]; then
	local F RET0
	if [ -f "$MYPATH/Makefile" ]
	then
		RET0=`make -C "$MYPATH" 2>&1`
		if [ -f "$MYPATH/fdf" ]
		then
			check_forbidden_func CHK_FDF_AUTHORIZED_FUNCS "$MYPATH/fdf"
		else
			echo "$RET0" > .myforbiddenfunc
			printf $C_RED"  Fatal error: Cannot compile"$C_CLEAR
		fi
	else
		printf $C_RED"  Makefile not found"$C_CLEAR
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_fdf
{
	local MYPATH
	MYPATH=$(get_config "fdf")
	display_header
	check_fdf_top "$MYPATH"
	if [ -d "$MYPATH" ]
	then
		display_menu\
            ""\
			check_fdf_all "check it!"\
			config_fdf "change path"\
			main "BACK TO MAIN MENU"
	else
		display_menu\
			""\
			config_fdf "configure"\
			main "BACK TO MAIN MENU"
	fi
}

function config_fdf
{
	local AB0 AB2 MYPATH
	MYPATH=$(get_config "fdf")
	display_header
	check_fdf_top "$MYPATH"
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
		check_fdf_top
		echo "  Please type the absolute path to your project:"
		if [ "$AB0" != "" ]
		then
			echo $C_RED"  $AB2: No such file or directory"$C_CLEAR$C_WHITE
		else
			printf $C_WHITE""
		fi
		tput cnorm
		read -p "  $HOME/" -e AB0
		tput civis
		AB0=`echo "$AB0" | sed 's/\/$//'`
		AB2="$HOME/$AB0"
	done
	cd "$RETURNPATH"
	save_config "fdf" "$AB2"
	printf $C_CLEAR""
	check_fdf
}

function check_fdf_top
{
	local LPATH=$1
	local LHOME
	LHOME=`echo "$HOME" | sed 's/\//\\\\\\//g'`
	LPATH="echo \"$LPATH\" | sed 's/$LHOME/~/'"
	LPATH=`eval $LPATH`
	printf $C_WHITE"\n\n"
	if [ "$1" != "" ]
		then
		printf "  Current configuration:"
		(( LEN=$COLUMNS - 24 ))
		printf "%"$LEN"s" "FDF  "
		printf $C_CLEAR"  $LPATH\n\n"
	else
		printf "  FDF\n"
		printf "\n"
	fi
	printf ""$C_CLEAR
}

fi;