#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	function check_set_env
	{
		COLUMNS=`tput cols`
		if [ "$COLUMNS" == "" ]
		then
			$COLUMNS=80;
		fi
	}

	function check_set_colors
	{
		if [ "$OPT_NO_COLOR" == "0" ]
		then
			C_BLACKBG="\033[40m\033[37m"
			C_CLEAR="\033[0m"$C_BLACKBG
			C_YELLOW=$C_BLACKBG"\033[33;1m"
			C_RED=$C_BLACKBG"\033[31m\033[38;5;160m"
			C_GREEN=$C_BLACKBG"\033[32m\033[38;5;70m"
			C_CYAN=$C_BLACKBG"\033[36;1m"
			C_WHITE=$C_BLACKBG"\033[37;1m"
			C_BLUE=$C_BLACKBG"\033[34;1m"
			C_GREY=$C_BLACKBG"\033[1;30m"
			C_GREY=$C_BLACKBG"\033[38;5;239m"
			C_BLACK="\033[30;1m"
			C_INVERT="\033[48;5;17m""\033[38;5;104m"
			C_INVERTGREY="\033[48;5;233m""\033[38;5;95m"
			C_INVERTRED="\033[48;5;88m""\033[38;5;107m"
		else
			C_BLACKBG=
			C_CLEAR="\033[0m"
			C_YELLOW=
			C_RED=
			C_GREEN=
			C_CYAN=
			C_WHITE=
			C_BLUE=
			C_GREY=
			C_GREY=
			C_BLACK=
			C_INVERT=
			C_INVERTGREY=
			C_INVERTRED=
		fi
	}

	CMD_RM=/bin/rm
	CMD_TOUCH=/usr/bin/touch
	CMD_GCC=/usr/bin/gcc
	MOULITEST_URL="https://github.com/yyang42/moulitest_42projects"
	MOULITEST_DIR="moulitest_42projects"
	LIBFTUNITTEST_URL="https://github.com/alelievr/libft-unit-test"
	LIBFTUNITTEST_DIR="libft-unit-test"

	function check_option_set
	{
		case "$1" in
			"OPT_NO_TIMEOUT")
				if [ "$OPT_NO_TIMEOUT" == 1 ]; then OPT_NO_TIMEOUT=0; else OPT_NO_TIMEOUT=1; fi
				;;
			"OPT_NO_NORMINETTE")
				if [ "$OPT_NO_NORMINETTE" == 1 ]; then OPT_NO_NORMINETTE=0; else OPT_NO_NORMINETTE=1; fi
				;;
			"OPT_NO_SPEEDTEST")
				if [ "$OPT_NO_SPEEDTEST" == 1 ]; then OPT_NO_SPEEDTEST=0; else OPT_NO_SPEEDTEST=1; fi
				;;
			"OPT_NO_LEAKS")
				if [ "$OPT_NO_LEAKS" == 1 ]; then OPT_NO_LEAKS=0; else OPT_NO_LEAKS=1; fi
				;;
			"OPT_NO_MOULITEST")
				if [ "$OPT_NO_MOULITEST" == 1 ]; then OPT_NO_MOULITEST=0; else OPT_NO_MOULITEST=1; fi
				;;
			"OPT_NO_COLOR")
				if [ "$OPT_NO_COLOR" == 1 ]; then OPT_NO_COLOR=0; else OPT_NO_COLOR=1; fi
				check_set_colors
				;;
		esac
		main
	}

	function display_error
	{
		echo $C_RED"  !!! $1 !!!"$C_CLEAR
	}

	function display_hr
	{
		local MARGIN
		(( MARGIN= $COLUMNS ))
		if [ "$1" == "" ]
		then
			printf $C_GREY""
		else
			printf "$1"
		fi
		printf "%"$MARGIN"s" "" | sed s/' '/"${c:=_}"/g | cut -c1-$MARGIN
		printf "$C_CLEAR"
	}

	function display_hr2
	{
		local MARGIN
		(( MARGIN= $COLUMNS ))
		printf $C_GREY""
		printf "%"$MARGIN"s" "" | sed s/' '/"${c:=¯ }"/g | cut -c1-$MARGIN
		printf $C_CLEAR""
		if [ "$1" != "" ]
		then
			echo "$1";
		fi
	}

	function display_righttitle
	{
		local LEN MARGIN
		if [ "$1" != "" ]
		then
			LEN=${#1}
			if [ ! -z $2 ]
			then
				(( MARGIN= $COLUMNS - $LEN - $2))
			else
				(( MARGIN= $COLUMNS - $LEN))
			fi
			printf "%"$MARGIN"s" " "
			printf "$1\n"
		else
			printf "\n"
		fi
	}

	function display_center
	{
		local LEN MARGIN
		if [ "$1" != "" ]
		then
			LEN=${#1}
			(( MARGIN= ($COLUMNS - $LEN) / 2 ))
			printf "%"$MARGIN"s" " "
			printf "$1"
			(( MARGIN= $MARGIN + ($COLUMNS - $LEN - $MARGIN * 2) ))
			printf "%"$MARGIN"s" " "
		else
			printf "\n"
		fi
	}

	function display_header
	{
		local MARGIN
		check_set_env
		echo "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
		echo "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n "
		clear
		if [ "$1" != "" ]
		then
			printf "$1"
		else
			printf $C_INVERT""
		fi
		display_righttitle "PRESS ESCAPE TO EXIT - V1.r$CVERSION"
		display_center "  _  _  ____  _____ _ _       ____ _               _              "
		display_center " | || ||___ \|  ___(_) | ___ / ___| |__   ___  ___| | _____ _ __  "
		display_center " | || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ __| |/ / _ \ '__| "
		display_center " |__   _/ __/|  _| | | |  __/ |___| | | |  __/ (__|   <  __/ |    "
		display_center "    |_||_____|_|   |_|_|\___|\____|_| |_|\___|\___|_|\_\___|_|    "
		display_center "    jgigault @ student.42.fr                    06 51 15 98 82    "
		display_center " "
		printf $C_CLEAR""
	}

	function display_top
	{
		local LPATH=$1
		local LHOME LEN PROJECTNAME MYPATH
		MYPATH=$1
		PROJECTNAME=$2
		LHOME=`echo "$HOME" | sed 's/\//\\\\\\//g'`
		LPATH="echo \"$LPATH\" | sed 's/$LHOME/~/'"
		LPATH=`eval $LPATH`
		printf $C_WHITE"\n\n"
		if [ "$MYPATH" != "" ]
		then
			printf "  Current configuration:"
			(( LEN=$COLUMNS - 24 ))
			printf "%"$LEN"s" "$PROJECTNAME  "
			printf $C_CLEAR"  $LPATH\n\n"
		else
			printf "  $PROJECTNAME\n"
			printf "\n"
		fi
		printf ""$C_CLEAR
	}

	function display_footer
	{
		echo $C_WHITE""
		printf "%"$COLUMNS"s" "" | sed s/' '/"${c:=#}"/g | cut -c1-$COLUMNS
		echo $C_CLEAR""
	}

	function ft_itoa
	{
		local -i i=$1
		if [ "$1" != "1" -a "$1" != "2" -a "$1" != "3" -a "$1" != "4" -a "$1" != "5" -a "$1" != "6" -a "$1" != "7" -a "$1" != "8" -a "$1" != "9" ]
		then
			(( i=$1 + 65 - 10 ))
			printf \\$(printf '%03o' $i)
		else
			printf "$1"
		fi
	}

	function ft_atoi
	{
		local SELN
		if [ "$1" == "NULL" ]
		then
			printf "0"
		else
			if [ "$1" != "1" -a "$1" != "2" -a "$1" != "3" -a "$1" != "4" -a "$1" != "5" -a "$1" != "6" -a "$1" != "7" -a "$1" != "8" -a "$1" != "9" ]
			then
				SELN=`LC_CTYPE=C printf '%d' "'$1"`
				if (( $SELN >= 65 )) && (( $SELN <= 90 ))
				then
					(( SELN=$SELN - 65 + 10 ))
					printf "$SELN"
				else
					if (( $SELN >= 97 )) && (( $SELN <= 122 ))
					then
						(( SELN=$SELN - 97 + 10 ))
						printf "$SELN"
					else
						printf "0"
					fi
				fi
			else
				printf "$1"
			fi
		fi
	}

	function display_menu
	{
		local -a MENU FUNCS
		local TOTAL SEL LEN SELN TITLE i TESTSA TESTSI
		SEL=""
		if [ "$1" != "" ]
		then
			printf $1
		else
			printf $C_INVERT""
		fi
		shift 1
		printf "%"$COLUMNS"s" " "
		printf "\n"
		while (( $# > 0 ))
		do
			if [ "$1" == "_" ]
			then
				printf "%"$COLUMNS"s" " "
						printf "\n"
				shift 1
			else
				if [ "$1" == "TESTS" ]
				then
					i=2
					TESTSI=1
					TESTSA="$2[$i]"
					while [ "${!TESTSA}" != "" ]
					do
						(( TOTAL += 1 ))
						(( i++ ))
						TESTSA="$2[$i]"
						FUNCS[$TOTAL]="$3 $TESTSI RUN_ALONE"
						MENU[$TOTAL]="${!TESTSA}"
						(( i++ ))
						(( TESTSI++ ))
						TITLE=`echo "${!TESTSA}" | sed 's/%/%%/g'`
						if (( $TOTAL < 10 ))
						then
							SELN=$TOTAL
						else
							(( SELN=65 + $TOTAL - 10 ))
							SELN=`echo "$SELN" | awk '{printf("%c", $0)}'`
						fi
						(( LEN=$COLUMNS - ${#TITLE} - 9 ))
						printf "  "$SELN")    $TITLE "
						printf "%"$LEN"s" " "
						printf "\n"
						TESTSA="$2[$i]"
					done
					shift 3
				else
					(( TOTAL += 1 ))
					FUNCS[$TOTAL]="$1"
					MENU[$TOTAL]="$2"
					TITLE=`echo "$2" | sed 's/%/%%/g'`
					if (( $TOTAL < 10 ))
					then
						SELN=$TOTAL
					else
						(( SELN=65 + $TOTAL - 10 ))
						SELN=`echo "$SELN" | awk '{printf("%c", $0)}'`
					fi
					(( LEN=$COLUMNS - ${#TITLE} - 9 ))
					printf "  "$SELN")    $TITLE "
					printf "%"$LEN"s" " "
					printf "\n"
					shift 2
				fi
			fi
		done

		printf "%"$COLUMNS"s" " "
		printf $C_CLEAR"\n"
		read -r -s -n 1 SEL
		SEL=$(get_key $SEL)
		if [ "$SEL" == "ESC" ]
		then
			exit_checker
		fi
		SEL=`ft_atoi "$SEL"`
		while [ -z "${MENU[$SEL]}" -o "$(echo "${FUNCS[$SEL]}" | grep '^open ')" != "" ]
		do
			printf "\a"
			if [ "$(echo "${FUNCS[$SEL]}" | grep '^open ')" != "" ]
			then
				if [ -f "$(echo "${FUNCS[$SEL]}" | sed 's/^open //')" -o "$(echo "${FUNCS[$SEL]}" | grep http)" != "" ]
				then
					eval ${FUNCS[$SEL]}
				fi
			fi
			SEL=""
			read -s -n 1 SEL
			SEL=$(get_key $SEL)
			if [ "$SEL" == "ESC" ]
			then
				exit_checker
			fi
			SEL=`ft_atoi "$SEL"`
		done
		printf "\n"
		if [ "${FUNCS[$SEL]}" != "" ]
		then
			eval ${FUNCS[$SEL]}
		fi
	}

	function get_key
	{
		local ord_value old_tty_settings
		ord_value=$(printf '%d' "'$1")
		if [[ $ord_value -eq 27 ]]; then
			old_tty_settings=`stty -g`
			stty -icanon min 0 time 0
			read -s key
			if [[ ${#key} -eq 0 ]]
			then
				printf "ESC"
			else
				printf "NULL"
			fi
			stty "$old_tty_settings"
		else
			printf "%s" "$1"
		fi
	}

	function get_config
	{
		local MYFILE LPATH RET0
		MYFILE=`printf "$RETURNPATH/.my$1" | sed 's/ /\\ /g'`
		if [ ! -f "$MYFILE" ]
		then
			touch "$MYFILE"
		fi
		LPATH=`cat "$MYFILE"`
		if [ ! -d "$LPATH" ]
		then
			printf "" > "$MYFILE"
			LPATH=""
		fi
		printf "$LPATH"
	}

	function save_config
	{
		local MYFILE RET0
		MYFILE=".my$1"
		RET0=`printf "$RETURNPATH/$MYFILE" | sed 's/ /\\ /g'`
		RET0=`echo "printf \"$2\" > \"$RET0\""`
		eval $RET0
	}

	function exit_checker
	{
		printf "\n"
		display_hr
		printf "\n\n\n\n\033[0m"
		tput cnorm
		clear
		cd "${GLOBAL_ENTRYPATH}"
		exit
	}

	function check_norme
	{	if [ "$OPT_NO_NORMINETTE" == "0" ]; then
		local RET0 RET2 RET3 RET4 TOTAL TOTA2
		rm -f "$RETURNPATH"/.mynorminette
		RET0=$(find "${MYPATH}" -type f -name "*.[ch]" | awk 'BEGIN {ORS=" "} {gsub(/\ /, "\\ "); print}')
		if [ "${RET0}" != "" ]
		then
			RET2=`eval norminette $RET0 2>&1`
			echo "$RET2" > "$RETURNPATH"/.mynorminette
			RET2=`cat .mynorminette | grep Error`
			RET3=`cat .mynorminette | grep Warning`
			RET4=`cat .mynorminette | grep "command not found"`
			if [ "$RET2" == "" -a "$RET3" == "" -a "$RET4" == "" ]
			then
				printf $C_GREEN"  All files passed the tests"$C_CLEAR
			else
				if [ "$RET4" != "" ]
				then
					printf $C_RED"  Command not found"$C_CLEAR
				else
					if [ "$RET2" == "" ]
					then
						TOTAL=0
					else
						TOTAL=`echo "$RET2" | wc -l | sed 's/ //g'`
					fi
					if [ "$RET3" == "" ]
					then
						TOTA2=0
					else
						TOTA2=`echo "$RET3" | wc -l | sed 's/ //g'`
					fi
					(( TOTAL = $TOTAL + $TOTA2 ))
					printf $C_RED"  $TOTAL error(s) or warning(s)"$C_CLEAR
				fi
			fi
		else
			printf ${C_RED}"  No source file (.c) or header (.h) to check"${C_CLEAR}
		fi
		else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
	}

	function check_author
	{	if [ "$OPT_NO_AUTEUR" == "0" ]; then
		local AUTHORF AUTHORC AUTHORE AUTHORG
		AUTHORF="$MYPATH/auteur"
		if [ ! -f "$AUTHORF" ]
		then
			printf $C_RED"  File not found"$C_CLEAR
		else
			AUTHORC=`cat -e "$AUTHORF" | awk '{if (NR == 1) print}'`
			AUTHORE=`cat -e "$AUTHORF" | sed 's/\$$//' | awk '{if (NR == 1) print}'`
			AUTHORG=`cat -e "$AUTHORF" | awk '{if (NR == 1) print}'`
			if [ "$AUTHORE" == "$AUTHORG" ]
			then
				printf $C_RED"  No [Line Feed] character at the end of line"$C_CLEAR
			else
				printf $C_GREEN"  $AUTHORC"$C_CLEAR
			fi
		fi
		else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
	}

	function display_spinner
	{
		local pid=$1
		local total_delay=0
		local total_delay2=340
		local delay=0.2
		local spinstr='|/-\'
		printf $C_BLUE""
		while [ "$(ps a | awk '{print $1}' | grep $pid)" ];
		do
			if (( $total_delay2 < 1 ))
			then
				kill $pid
				wait $! 2>/dev/null
				(( total_delay2 = $total_delay / 5 ))
				printf $C_RED"  Time out ($total_delay2 sec)"$C_CLEAR > $RETURNPATH/.myret
			fi
			if [ "$OPT_NO_TIMEOUT" == "0" ]
			then
				(( total_delay += 1 ))
			fi
			local temp=${spinstr#?}
			printf "  [%c] " "$spinstr"
			local spinstr=$temp${spinstr%"$temp"}
			if (( $total_delay >= 5 ))
			then
				(( total_delay2 = ( 309 - $total_delay ) / 5 ))
				printf "[time out: %02d]" "$total_delay2"
			fi
			sleep $delay
			printf "\b\b\b\b\b\b"
			if (( $total_delay >= 5 ))
			then
				printf "\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
			fi
		done
		printf "                     \b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
		printf $C_CLEAR""
	}

	function check_fileexists
	{
		local i TOTAL RET0 VALPARAM RET1
		if [ "$1" != "" ]
		then
			i=0
			VALPARAM=`eval echo \$1[\$i]`
			while [ "${!VALPARAM}" != "" ]
			do
				RET1=`find "$MYPATH" -name "${!VALPARAM}" 2>/dev/null`
				if [ "$RET1" == "" ]
				then
					(( TOTAL += 1 ))
					RET0=$RET0"Not Found: ${!VALPARAM}\n"
				fi
				(( i += 1 ))
				VALPARAM=`eval echo \$1[\$i]`
			done
			printf "$RET0" > "$RETURNPATH"/.my$1
			if [ "$RET0" == "" ]
			then
				printf $C_GREEN"  All files were found"$C_CLEAR
			else
				if (( $TOTAL == 1 ))
				then
					printf $C_RED"  1 file is missing"$C_CLEAR
				else
					printf $C_RED"  $TOTAL files are missing"$C_CLEAR
				fi
			fi
		else
			printf $C_RED"  An error occured (Files list missing)"$C_CLEAR
		fi
	}

	function check_create_tmp_dir
	{
		if [ ! -d "$RETURNPATH"/tmp ]
		then
			mkdir "$RETURNPATH"/tmp
		else
			rm -rf "$RETURNPATH"/tmp/*
		fi
	}

	function check_kill_by_name
	{
		local PROCESSID PROCESSID0 PROGNAME PROCESSCOUNT
		PROGNAME="$1"
		if [ "$PROGNAME" != "" ]
		then
			PROCESSID=`ps | grep "$1" | grep -v "grep" | sed 's/^[ ]*//g' | cut -d" " -f1`
			if [ "$PROCESSID" != "" ]
			then
				PROCESSCOUNT=`echo "$PROCESSID" | wc -l`
				while (( $PROCESSCOUNT > 0 ))
				do
					(( PROCESSCOUNT -= 1 ))
					PROCESSID0=`echo "$PROCESSID" | awk '{print; exit}'`
					kill $PROCESSID0
					wait $! 2>/dev/null
				done
			fi
		fi
	}

        function check_cleanlog
        {
                local RET0 LOGFILENAME
                LOGFILENAME="$1"
                if [ -f "$LOGFILENAME" ]
                then
                        RET0=`cat -e "$LOGFILENAME" | awk '{gsub(/\^M.*\^M/, "");  gsub(/\^@/, "");  gsub(/\^\[\[[0-9;]*m/, "");  gsub(/[\$]$/, ""); print}'`
                        echo "$RET0" > "$LOGFILENAME"
                fi
        }
fi
