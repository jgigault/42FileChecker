#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	function check_configure
	{
		local AB0 AB2 MYPATH RETURNFUNC PROJECTNAME PROJECTNAME_DISPLAY
		RETURNFUNC=$1
		PROJECTNAME=$2
		PROJECTNAME_DISPLAY=$3
		MYPATH=$(get_config "$PROJECTNAME")
		display_header
		display_top "$MYPATH" "${PROJECTNAME_DISPLAY}"
		printf "  Please type the absolute path to your project:\n"$C_WHITE
		cd "$HOME/"
		tput cnorm
		read -p "  $HOME/" -e AB0
		tput civis
		if [ "$AB0" == "" ]
		then
			cd "$RETURNPATH"
			$RETURNFUNC
			return
		else
			AB0=`echo "$AB0" | sed 's/\/$//'`
			AB2="$HOME/$AB0"
			while [ "$AB0" == "" -o ! -d "$AB2" ]
			do
				display_header
				check_libftasm_top "$MYPATH"
				printf "  Please type the absolute path to your project:\n"
				if [ "$AB0" != "" ]
				then
					printf $C_RED"  $AB2: No such file or directory\n"$C_CLEAR$C_WHITE
				else
					printf $C_WHITE""
				fi
				tput cnorm
				read -p "  $HOME/" -e AB0
				tput civis
				if [ "$AB0" == "" ]
				then
					cd "$RETURNPATH"
					$RETURNFUNC
					return
				fi
				AB0=`echo "$AB0" | sed 's/\/$//'`
				AB2="$HOME/$AB0"
			done
			cd "$RETURNPATH"
			save_config "$PROJECTNAME" "$AB2"
			printf $C_CLEAR""
			$RETURNFUNC
		fi
	}

fi