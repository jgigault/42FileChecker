#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

source includes/ft_printf_list.sh

declare -a CHK_FT_PRINTF='( "check_author" "auteur" "check_norme" "norminette" "check_ft_printf_makefile" "makefile" "check_ft_printf_forbidden_func" "forbidden functions" "check_ft_printf_basictests" "basic tests (beta)" "check_ft_printf_moulitest" "moulitest (yyang@student.42.fr)" )'

declare -a CHK_FT_PRINTF_AUTHORIZED_FUNCS='(write malloc free exit main)'

function check_ft_printf_all
{
	local FUNC TITLE i j RET0 MYPATH
	MYPATH=$(get_config "ft_printf")
	configure_moulitest "ft_printf" "$MYPATH"
	i=0
	j=1
	display_header
	display_righttitle ""
	check_ft_printf_top "$MYPATH"
	while [ "${CHK_FT_PRINTF[$i]}" != "" ]
	do
		FUNC="${CHK_FT_PRINTF[$i]}"
		(( i += 1 ))
		TITLE="${CHK_FT_PRINTF[$i]}"
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
		"open .mynorminette" "see details: norminette"\
		"open .mymakefile" "see details: makefile"\
		"open .myforbiddenfunc" "see details: forbidden functions"\
		"open .mybasictests" "see details: basic tests"\
		"open .mymoulitest" "see details: moulitest"
}

function check_ft_printf_basictests
{	if [ "$OPT_NO_BASICTESTS" == "0" ]; then
	local errors fatal success i TTYPE TVAL TARGS FILEN RET1 RET2 RET0
	i=0
	index=0
	errors=0
	success=0
	fatal=0
	rm -f .mybasictests .mybasictestssuccess
	touch .mybasictests .mybasictestssuccess
	check_create_tmp_dir
	check_ft_printf_create_header
	echo "FT_PRINTF TESTS:\n" >> .mybasictestssuccess
	while [ "${CHK_FT_PRINTF_LIST[$i]}" != "" -a $fatal -eq 0 ]
	do
		(( index += 1 ))
		TTYPE="${CHK_FT_PRINTF_LIST[$i]}"
		(( i += 1 ))
		TVAL="${CHK_FT_PRINTF_LIST[$i]}"
		(( i += 1 ))
		RET0=`check_ft_printf_basictests_gcc "$TTYPE"`
		if [ "$RET0" != "" ]
		then
			(( fatal += 1 ));
		else
			TARGS=`echo "\"$TVAL\"" | sed 's/|/\" \"/g'`
			if [ "$TTYPE" == "d" ]
			then
				TARGSV=`echo "\"$TVAL" | sed 's/|/, /g' | sed 's/,/\",/'`
			else
				TARGSV=`echo "\"$TVAL\"" | sed 's/|/\", \"/g'`
			fi
			FILEN1="./tmp/ft_printf_$TTYPE"
			FILEN2="./tmp/printf_$TTYPE"
			RET1=`eval "$FILEN1 $TARGS" 2>&1`
			RET2=`eval "$FILEN2 $TARGS" 2>&1`
			if [ "$RET1" != "$RET2" ]
			then
				if (( $errors == 0 ))
				then
					echo "see the entire list of tests by opening file:\n$RETURNPATH/.mybasictestssuccess" >> .mybasictests
					echo "\n--------------\n" >> .mybasictests
					echo "FAILED TESTS:\n" >> .mybasictests
					echo "# TEST NUMBER (TYPE OF ARG)" >> .mybasictests
					echo "  INSTRUCTION();" >> .mybasictests
					echo "  1. your function ft_printf" >> .mybasictests
					echo "  2. unix function printf" >> .mybasictests
					echo "     (returned value) -->written on stdout<--" >> .mybasictests
				fi
				(( errors += 1 ))
				case "$TTYPE" in
					"s") TTYPEV="(char *)" ;;
					"d") TTYPEV="(int)" ;;
					"h") TTYPEV="(short)" ;;
					"l") TTYPEV="(long)" ;;
					"m") TTYPEV="(long long)" ;;
					"0") TTYPEV="" ;;
				esac
				printf "\n# %04d %s\n" "$index" "$TTYPEV" >> .mybasictests
				echo "  ft_printf($TARGSV);" >> .mybasictests
				RET0=`echo "$RET1" | cut -d"|" -f2`
				printf "  1. (%5d) -->" "$RET0" >> .mybasictests 2>&1
				RET0=`echo "$RET1" | cut -d"|" -f1`
				printf "%s<--\n" "$RET0" >> .mybasictests
				RET0=`echo "$RET2" | cut -d"|" -f2`
				printf "  2. (%5d) -->" "$RET0" >> .mybasictests 2>&1
				RET0=`echo "$RET2" | cut -d"|" -f1`
				printf "%s<--\n" "$RET0" >> .mybasictests
				printf "%4d. FAIL ft_printf(%s);\n" "$index" "$TARGSV" >> .mybasictestssuccess
			else
				(( success += 1 ))
				RET0=`echo "$RET1" | cut -d"|" -f1`
				printf "%4d.      ft_printf(%s);\n" "$index" "$TARGSV" >> .mybasictestssuccess
			fi
		fi
	done
	if (( $fatal == 0 ))
	then
		if (( $errors == 0 ))
		then
			cat .mybasictestssuccess > .mybasictests
			printf $C_GREEN"  All tests passed ($index tests)"$C_CLEAR
		else
			printf $C_RED"  $errors failed test(s) out of $index tests"$C_CLEAR
		fi
	else
		printf $C_RED"  Fatal error : Cannot compile"$C_CLEAR
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_ft_printf_basictests_gcc
{
	local FILEN RET0
	FILEN="printf_$1"
	if [ ! -f "./tmp/ft_$FILEN" -o ! -f "./tmp/$FILEN" ]
	then
		if [ -d "$MYPATH/libft" ]
		then
			RET0=`make re -C "$MYPATH/libft" 2>&1 1>/dev/null`
			if [ "$RET0" != "" ]; then echo "$RET0" > .mybasictests; printf "error"; return; fi
			RET0=`make re -C "$MYPATH" 2>&1 1>/dev/null`
			if [ "$RET0" != "" ]; then echo "$RET0" > .mybasictests; printf "error"; return; fi
			RET0=`gcc "./srcs/printf/ft_$FILEN.c" -L"$MYPATH" -lftprintf -L"$MYPATH/libft" -lft -o "./tmp/ft_$FILEN" 2>&1 1>/dev/null`
			if [ "$RET0" != "" ]; then echo "$RET0" > .mybasictests; printf "error"; return; fi
		else
			RET0=`make re -C "$MYPATH" 2>&1 1>/dev/null`
			if [ "$RET0" != "" ]; then echo "$RET0" > .mybasictests; printf "error"; return; fi
			RET0=`gcc "./srcs/printf/ft_$FILEN.c" -L"$MYPATH" -lftprintf -o "./tmp/ft_$FILEN" 2>&1 1>/dev/null`
			if [ "$RET0" != "" ]; then echo "$RET0" > .mybasictests; printf "error"; return; fi
		fi
		RET0=`gcc "./srcs/printf/$FILEN.c" -o "./tmp/$FILEN" 2>&1 1>/dev/null`
		if [ "$RET0" != "" ]; then echo "$RET0" > .mybasictests; printf "error"; return; fi
	fi
	return 1
}

function check_ft_printf_create_header
{
	local FTPRINTFH
	FTPRINTFH=`find "$MYPATH" -name \*printf\*.h`
	echo "#include \"$FTPRINTFH\"" > "$RETURNPATH"/tmp/printf.h
}

function check_ft_printf_makefile
{	if [ "$OPT_NO_MAKEFILE" == "0" ]; then
	local MYPATH
	MYPATH=$(get_config "ft_printf")
	check_makefile "$MYPATH" libftprintf.a
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_ft_printf_forbidden_func
{	if [ "$OPT_NO_FORBIDDEN" == "0" ]; then
	local F
	if [ -f "$MYPATH/Makefile" ]
	then
		FILEN=forbiddenfuncs
		F=$RETURNPATH/tmp/$FILEN.c
		FTPRINTFH=`find "$MYPATH" -name \*printf\*.h`
		check_create_tmp_dir
		echo "#include \"$FTPRINTFH\"\nint main(void) {" > $F
		echo "ft_printf(\"\");" >> $F
		echo "return (1); }" >> $F
		cd "$RETURNPATH"/tmp
		make re -C "$MYPATH" >/dev/null
		rm -f "$FILEN"
		if [ -d "$MYPATH/libft" ]
		then
			make re -C "$MYPATH/libft" >/dev/null
			RET0=`gcc "$F" -L"$MYPATH" -lftprintf -L"$MYPATH/libft" -lft -o "$FILEN"`
		else
			RET0=`gcc "$F" -L"$MYPATH" -lftprintf -o "$FILEN"`
		fi
		cd "$RETURNPATH"
		check_forbidden_func CHK_FT_PRINTF_AUTHORIZED_FUNCS "./tmp/$FILEN"
	else
		printf $C_RED"  Makefile not found"$C_CLEAR
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_ft_printf
{
	local MYPATH
	MYPATH=$(get_config "ft_printf")
	display_header
	display_righttitle ""
	check_ft_printf_top "$MYPATH"
	if [ -d "$MYPATH" ]
	then
		display_menu\
            ""\
			check_ft_printf_all "check it!"\
			config_ft_printf "change path"\
			main "BACK TO MAIN MENU"
	else
		display_menu\
			""\
			config_ft_printf "configure"\
			main "BACK TO MAIN MENU"
	fi
}

function check_ft_printf_moulitest
{	if [ "$OPT_NO_MOULITEST" == "0" ]; then
    local RET0 TOTAL
    if [ -d moulitest ]
    then
        rm -f "$RETURNPATH"/.mymoulitest
        cd "$RETURNPATH/moulitest/"
        make ft_printf 1> "$RETURNPATH"/.mymoulitest 2>&1
        cd "$RETURNPATH"
        RET0=`cat .mymoulitest | sed 's/\^\[\[[0-9;]*m//g' | sed 's/\^\[\[0m//g' | sed 's/\$$//' | grep "STARTING ALL UNIT TESTS"`
        if [ "$RET0" == "" ]
        then
            printf $C_RED"  Fatal error: moulitest cannot compile (see details)"$C_CLEAR
        else
            RET0=`cat .mymoulitest | sed 's/\^\[\[[0-9;]*m//g' | sed 's/\^\[\[0m//g' | sed's/\$$//' | grep "END OF UNIT TESTS"`
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
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
 }

function config_ft_printf
{
	local AB0 AB2 MYPATH
	MYPATH=$(get_config "ft_printf")
	display_header
	display_righttitle ""
	check_ft_printf_top "$MYPATH"
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
		check_ft_printf_top
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
	save_config "ft_printf" "$AB2"
	printf $C_CLEAR""
	check_ft_printf
}

function check_ft_printf_top
{
	local LPATH=$1
	local LHOME
	LHOME=`echo "$HOME" | sed 's/\//\\\\\\//g'`
	LPATH="echo \"$LPATH\" | sed 's/$LHOME/~/'"
	LPATH=`eval $LPATH`
	printf "$C_GREY"
    display_center "FT_PRINTF"
    printf "\n"$C_CLEAR
	if [ "$1" != "" ]
	then
		printf "  "$C_WHITE"Current configuration:$C_CLEAR\n  $LPATH\n\n"
	fi
}

fi;