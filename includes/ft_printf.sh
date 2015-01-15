#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

source includes/ft_printf_list.sh

declare -a CHK_FT_PRINTF='( "check_author" "auteur" "check_norme" "norminette" "check_ft_printf_makefile" "makefile" "check_ft_printf_forbidden_func" "forbidden functions" "check_ft_printf_basictests" "basic tests (beta)" "check_ft_printf_leaks" "leaks" "check_ft_printf_moulitest" "moulitest (https://github.com/yyang42/moulitest)" )'

declare -a CHK_FT_PRINTF_AUTHORIZED_FUNCS='(write malloc free exit main)'

function check_ft_printf_all
{
	local FUNC TITLE i j j2 RET0 MYPATH
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
		TITLE=`echo "${CHK_FT_PRINTF[$i]}"  | sed 's/%/%%/g'`
		j2=`ft_itoa "$j"`
		printf "  $C_WHITE${j2} -> $TITLE$C_CLEAR\n"
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
		check_ft_printf_all "RETRY"\
		"open .mynorminette" "more info: norminette"\
		"open .mymakefile" "more info: makefile"\
		"open .myforbiddenfunc" "more info: forbidden functions"\
		"open .mybasictests" "more info: basic tests (beta)"\
		"open .myleaks" "more info: leaks"\
		"open .mymoulitest" "more info: moulitest"\
		"_"\
		"open https://github.com/jgigault/42FileChecker/issues/new" "REPORT A BUG"\
		main "BACK TO MAIN MENU"
}

function check_ft_printf_basictests
{	if [ "$OPT_NO_BASICTESTS" == "0" ]; then
	local total errors fatal success i TTYPE TVAL TARGS FILEN RET1 RET2 RET0 TYPE TVAL0
	i=0
	index=0
	total=0
	errors=0
	success=0
	fatal=0
	TYPE="$1"
	LOGFILENAME=".mybasictests"
	rm -f $LOGFILENAME $LOGFILENAME"success"
	touch $LOGFILENAME $LOGFILENAME"success"
	check_create_tmp_dir
	check_ft_printf_create_header
	make re -C "$MYPATH" &>/dev/null
	echo "SUCCESS TESTS:\n" >> $LOGFILENAME"success"
	while [ "${CHK_FT_PRINTF_LIST[$i]}" != "" -a $fatal -eq 0 ]
	do
		(( index += 1 ))
		TTYPE="${CHK_FT_PRINTF_LIST[$i]}"
		(( i += 1 ))
		TVAL0="${CHK_FT_PRINTF_LIST[$i]}"
		TVAL=`printf "%s" "${CHK_FT_PRINTF_LIST[$i]}" | sed 's/\\\\/\\\\\\\\/g'`
		(( i += 1 ))
		#if [ "$TYPE" == "${TTYPE:0:1}" ]
		#then
			(( total += 1 ))
			RET0=`check_ft_printf_basictests_gcc "${TTYPE:0:1}" "$LOGFILENAME"`
			if [ "$RET0" != "" ]
			then
				(( fatal += 1 ));
			else
				TARGS=`echo "$TTYPE" "\"$TVAL0\"" | sed 's/|/\" \"/g'`
				if [ "${TTYPE:0:1}" == "d" -o "$TTYPE" == "0p" -o "$TTYPE" == "sN" -o "${TTYPE:0:1}" == "x" ]
				then
					TARGSV=`echo "\"$TVAL" | sed 's/|/, /g' | sed 's/,/\",/'`
				else
					TARGSV=`echo "\"$TVAL\"" | sed 's/|/\", \"/g'`
				fi
				FILEN1="./tmp/ft_printf_${TTYPE:0:1}"
				FILEN2="./tmp/printf_${TTYPE:0:1}"
				RET1=`eval "$FILEN1 $TARGS" 2>&1`
				RET2=`eval "$FILEN2 $TARGS" 2>&1`
				RET1=`printf "%s" "$RET1" | awk 'BEGIN{ORS="[BR]"}{print}' | sed 's/\[BR\]$//'`
				RET2=`printf "%s" "$RET2" | awk 'BEGIN{ORS="[BR]"}{print}' | sed 's/\[BR\]$//'`
				if [ "$RET1" != "$RET2" ]
				then
					if (( $errors == 0 ))
					then
						echo "FAILED TESTS:\n" >> $LOGFILENAME
						echo "# TEST NUMBER (TYPE OF ARG)" >> $LOGFILENAME
						echo "  INSTRUCTION();" >> $LOGFILENAME
						echo "  1. your function ft_printf" >> $LOGFILENAME
						echo "  2. unix function printf" >> $LOGFILENAME
						echo "     (returned value) -->written on stdout<--" >> $LOGFILENAME
					fi
					(( errors += 1 ))
					case "$TTYPE" in
						"s") TTYPEV="(char *)" ;;
						"sN") TTYPEV="(NULL)" ;;
						"dc") TTYPEV="(char)" ;;
						"d") TTYPEV="(int)" ;;
						"dj") TTYPEV="(intmax_t)" ;;
						"dz") TTYPEV="(ssize_t)" ;;
						"dh") TTYPEV="(short)" ;;
						"dH") TTYPEV="(signed char)" ;;
						"dl") TTYPEV="(long)" ;;
						"dL") TTYPEV="(long long)" ;;
						"0") TTYPEV="" ;;
						"0p") TTYPEV="(void *)" ;;
						"x") TTYPEV="(int)" ;;
						"xh") TTYPEV="(unsigned short)" ;;
						"xH") TTYPEV="(unsigned char)" ;;
						"xl") TTYPEV="(unsigned long)" ;;
						"xL") TTYPEV="(unsigned long long)" ;;
						"xj") TTYPEV="(uintmax_t)" ;;
						"u") TTYPEV="(unsigned int)" ;;
						"uh") TTYPEV="(unsigned char)" ;;
						"uj") TTYPEV="(intmax_t)" ;;
						"uz") TTYPEV="(size_t)" ;;
						"uH") TTYPEV="(unsigned short)" ;;
						"ul") TTYPEV="(unsigned long)" ;;
						"uL") TTYPEV="(unsigned long long)" ;;
						"uU") TTYPEV="(unsigned long)" ;;
					esac
					printf "\n# %04d %s\n" "$index" "$TTYPEV" >> $LOGFILENAME
					printf "  ft_printf(%s);\n" "$TARGSV" >> $LOGFILENAME
					RET0=`printf "%s" "$RET1" | sed 's/\\\\/\\\\\\\\/g' | cut -d"|" -f2 | sed 's/NULL//g'`
					printf "  1. (%5d) -->" "$RET0" >> $LOGFILENAME 2>&1
					RET0=`printf "%s" "$RET1" | sed 's/\\\\/\\\\\\\\/g' | cut -d"|" -f1 | sed 's/\[BR\]/\\\\n/g'`
					printf "%s<--\n" "$RET0" >> $LOGFILENAME
					RET0=`printf "%s" "$RET2" | sed 's/\\\\/\\\\\\\\/g' | cut -d"|" -f2 | sed 's/NULL//g'`
					printf "  2. (%5d) -->" "$RET0" >> $LOGFILENAME 2>&1
					RET0=`printf "%s" "$RET2" | sed 's/\\\\/\\\\\\\\/g' | cut -d"|" -f1 | sed 's/\[BR\]/\\\\n/g'`
					printf "%s<--\n" "$RET0" >> $LOGFILENAME
					RET0=`echo "$RET2" | cut -d"|" -f1 | sed 's/\\\\/\\\\\\\\/g' | sed 's/NULL//g' | sed 's/\[BR\]/\\\\n/g'`
					printf "%4d. FAIL %-45s -> \"%s\"\n" "$index" "ft_printf($TARGSV);" "$RET0" >> $LOGFILENAME"success"
				else
					(( success += 1 ))
					RET0=`echo "$RET2" | cut -d"|" -f1 | sed 's/\\\\/\\\\\\\\/g' | sed 's/NULL//g' | sed 's/\[BR\]/\\\\n/g'`
					printf "%4d.      %-45s -> \"%s\"\n" "$index" "ft_printf($TARGSV);" "$RET0" >> $LOGFILENAME"success"
				fi
			fi
		#fi
	done
	if (( $fatal == 0 ))
	then
		if (( $errors == 0 ))
		then
			cat $LOGFILENAME"success" > $LOGFILENAME
			printf $C_GREEN"  All tests passed ($total tests)"$C_CLEAR
		else
			echo "\n--------------\n" >> $LOGFILENAME
			cat $LOGFILENAME"success" >> $LOGFILENAME
			printf $C_RED"  $errors failed test(s) out of $total tests"$C_CLEAR
		fi
	else
		printf $C_RED"  Fatal error : Cannot compile"$C_CLEAR
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_ft_printf_leaks
{	if [ "$OPT_NO_LEAKS" == "0" ]; then
	local LOGFILENAME RET0 CSRC BSRC
	CSRC=./srcs/printf/ft_printf_leaks.c
	BSRC=./tmp/ft_printf_leaks
	LOGFILENAME=.myleaks
	rm -f $LOGFILENAME
	touch $LOGFILENAME
	check_create_tmp_dir
	make re -C "$MYPATH" &>$LOGFILENAME
	if [ -f "$MYPATH/libftprintf.a" ]
	then
		check_ft_printf_create_header
		RET0=`gcc -Wall -Werror -Wextra "$CSRC" -L "$MYPATH" -lftprintf -o "$BSRC" &>$LOGFILENAME`
		if [ -f "$BSRC" ]
		then
			RET0=`cat "$CSRC" | sed 's/\\\\/\\\\\\\\/g'`
			NOTICE="Here is the main() test:\n-----------------------------\n$RET0\n-----------------------------\n\n\n"
			check_leaks "$BSRC" "" "$LOGFILENAME" "$NOTICE"
		else
			printf $C_RED"  Fatal error : Cannot compile"$C_CLEAR
		fi
	else
		printf $C_RED"  Fatal error : Cannot compile"$C_CLEAR
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_ft_printf_basictests_gcc
{
	local FILEN RET0 LOGFILENAME
	FILEN="printf_$1"
	LOGFILENAME="$2"
	if [ ! -f "./tmp/ft_$FILEN" -o ! -f "./tmp/$FILEN" ]
	then
		make re -C "$MYPATH" &>/dev/null
		if [ -f "$MYPATH/libftprintf.a" ]
		then
			RET0=`gcc -Wall -Werror -Wextra "./srcs/printf/ft_$FILEN.c" -L"$MYPATH" -lftprintf -o "./tmp/ft_$FILEN" 2>&1 1>/dev/null`
			if [ "$RET0" != "" ]; then echo "$RET0" > $LOGFILENAME; printf "error"; return; fi
			RET0=`gcc "./srcs/printf/$FILEN.c" -o "./tmp/$FILEN" 2>&1 1>/dev/null`
			if [ "$RET0" != "" ]; then echo "$RET0" > $LOGFILENAME; printf "error"; return; fi
		else
			echo "$MYPATH/libftprintf.a was not found" > $LOGFILENAME; printf "error"; return;
		fi
	fi
	return 1
}

function check_ft_printf_create_header
{
	local FTPRINTFH
	FTPRINTFH=`find "$MYPATH" -name \*printf\*.h`
	echo "#include <stdarg.h>\nint ft_printf(char const *format, ...);" > "$RETURNPATH"/tmp/printf.h
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
		check_create_tmp_dir
		echo "int ft_printf(char const *format, ...);\nint main(void) {" > $F
		echo "ft_printf(\"\");" >> $F
		echo "return (1); }" >> $F
		make re -C "$MYPATH" 1>.myforbiddenfunc 2>&1
		rm -f "$RETURNPATH/tmp/$FILEN"
		if [ -f "$MYPATH/libftprintf.a" ]
		then
			RET0=`gcc "$F" -L"$MYPATH" -lftprintf -o "$RETURNPATH/tmp/$FILEN" 2>&1`
			check_forbidden_func CHK_FT_PRINTF_AUTHORIZED_FUNCS "./tmp/$FILEN"
		else
			printf $C_RED"  Fatal error: Cannot compile"$C_CLEAR
		fi
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
	check_moulitest "ft_printf"
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
	printf $C_WHITE"\n"
    if [ "$1" != "" ]
    then
        printf "  Current configuration:"
        (( LEN=$COLUMNS - 24 ))
        printf "%"$LEN"s" "FT_PRINTF  "
        printf $C_CLEAR"  $LPATH\n\n"
    else
        printf "  FT_PRINTF\n"
        printf "\n"
    fi
    printf ""$C_CLEAR
}

fi;