#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

source includes/ft_printf_list.sh

declare -a CHK_FT_PRINTF='( "check_author" "auteur" "check_norme" "norminette" "check_ft_printf_makefile" "makefile" "check_ft_printf_forbidden_func" "forbidden functions" "check_ft_printf_basictests" "basic tests (beta)" "check_ft_printf_leaks" "leaks" "check_ft_printf_speedtest" "speed test" "check_ft_printf_moulitest" "moulitest (${MOULITEST_URL})" )'

declare -a CHK_FT_PRINTF_AUTHORIZED_FUNCS='(write malloc free exit main)'

function check_ft_printf_all
{
	local FUNC TITLE i j k j2 RET0 MYPATH TESTONLY
	TESTONLY="$1"
	MYPATH=$(get_config "ft_printf")
	configure_moulitest "ft_printf" "$MYPATH"
	i=0
	j=1
	k=0
	display_header
	display_top "$MYPATH" FT_PRINTF
	while [ "${CHK_FT_PRINTF[$i]}" != "" ]
	do
		FUNC="${CHK_FT_PRINTF[$i]}"
		(( i += 1 ))
		TITLE=`echo "${CHK_FT_PRINTF[$i]}"  | sed 's/%/%%/g'`
		j2=`ft_itoa "$j"`
		printf "  $C_WHITE${j2} -> $TITLE$C_CLEAR\n"
		if [ "$TESTONLY" == "" -o "$TESTONLY" == "$k" ]
		then
			(eval "$FUNC" > .myret) &
			display_spinner $!
			RET0=`cat .myret | sed 's/%/%%/g'`
			printf "$RET0\n"
			printf "\n"
		else
			printf $C_GREY"  --Not performed--\n"$C_CLEAR;
			printf "\n"
		fi
		(( j += 1 ))
		(( i += 1 ))
		(( k += 1 ))
	done
	display_menu\
		""\
		"check_ft_printf" "OK"\
		"open .mynorminette" "more info: norminette"\
		"open .mymakefile" "more info: makefile"\
		"open .myforbiddenfunc" "more info: forbidden functions"\
		"open .mybasictests" "more info: basic tests (beta)"\
		"open .myleaks" "more info: leaks"\
		"open .myspeedtest" "more info: speed test"\
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
	make re -C "$MYPATH" >/dev/null 2>&1
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

function check_ft_printf_speedtest
{	if [ "$OPT_NO_SPEEDTEST" == "0" ]; then
	local LOGFILENAME
	LOGFILENAME=.myspeedtest
	CSRC1=./srcs/printf/speedtest_ft_printf.c
	CSRC2=./srcs/printf/speedtest_printf.c
	BSRC1=./tmp/ft_printf_speedtest
	BSRC2=./tmp/printf_speedtest
	rm -f $LOGFILENAME
	touch $LOGFILENAME
	check_create_tmp_dir
	make re -C "$MYPATH" >$LOGFILENAME 2>&1
	if [ -f "$MYPATH/libftprintf.a" ]
	then
		RET0=`gcc -Wall -Werror -Wextra "$CSRC1" -L "$MYPATH" -lftprintf -o "$BSRC1" >$LOGFILENAME 2>&1`
		if [ -f "$BSRC1" ]
		then
			RET0=`gcc -Wall -Werror -Wextra "$CSRC2" -o "$BSRC2" >$LOGFILENAME 2>&1`
			if [ -f "$BSRC2" ]
			then
				check_speedtest "$BSRC1" "$BSRC2" "null" "$LOGFILENAME" "Your program is compared with the original 'printf'.\n\n"
			else
				printf $C_RED"  Fatal error : Cannot compile"$C_CLEAR
			fi
		else
			printf $C_RED"  Fatal error : Cannot compile"$C_CLEAR
		fi
	else
		printf $C_RED"  Fatal error: Cannot compile"$C_CLEAR
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_ft_printf_leaks
{	if [ "${OPT_NO_LEAKS}" == "0" ]; then
	local LOGFILENAME RET0 CSRC BSRC
	CSRC="./srcs/printf/ft_printf_leaks.c"
	BSRC="./tmp/ft_printf_leaks"
	LOGFILENAME=".myleaks"
	$CMD_RM} -f ${LOGFILENAME}
	${CMD_TOUCH} ${LOGFILENAME}
	check_create_tmp_dir
	make re -C "${MYPATH}" >${LOGFILENAME} 2>&1
	if [ -f "${MYPATH}/libftprintf.a" ]
	then
		RET0=`gcc -Wall -Werror -Wextra "${CSRC}" -L "${MYPATH}" -lftprintf -o "${BSRC}" 2>&1`
		if [ -f "$BSRC" ]
		then
			RET0=`cat "${CSRC}" | sed 's/\\\\/\\\\\\\\/g'`
			NOTICE="Here is the main() test:\n-----------------------------\n${RET0}\n-----------------------------\n\n\n"
			check_leaks "${BSRC}" "" "${LOGFILENAME}" "${NOTICE}"
		else
			echo "${RET0}" >>${LOGFILENAME}
			printf ${C_RED}"  Fatal error : Cannot compile"${C_CLEAR}
		fi
	else
		printf ${C_RED}"  Fatal error : Cannot compile"${C_CLEAR}
	fi
	else printf ${C_GREY}"  --Not performed--"${C_CLEAR}; fi
}

function check_ft_printf_basictests_gcc
{
	local FILEN RET0 LOGFILENAME
	FILEN="printf_$1"
	LOGFILENAME="$2"
	if [ ! -f "./tmp/ft_$FILEN" -o ! -f "./tmp/$FILEN" ]
	then
		if [ -f "$MYPATH/libftprintf.a" ]
		then
			RET0=`gcc -Wall -Werror -Wextra "./srcs/printf/ft_$FILEN.c" -L"$MYPATH" -lftprintf -o "./tmp/ft_$FILEN" >/dev/null 2>&1`
			if [ "$RET0" != "" ]; then echo "$RET0" > $LOGFILENAME; printf "error"; return; fi
			RET0=`gcc "./srcs/printf/$FILEN.c" -o "./tmp/$FILEN" >/dev/null 2>&1`
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
		make re -C "$MYPATH" >.myforbiddenfunc 2>&1
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
	display_top "$MYPATH" FT_PRINTF
	if [ -d "$MYPATH" ]
	then
		display_menu\
			""\
			check_ft_printf_all "check all!"\
			"_"\
			"TESTS" "CHK_FT_PRINTF" "check_ft_printf_all"\
			"_"\
			"check_configure check_ft_printf ft_printf FT_PRINTF" "change path"\
			main "BACK TO MAIN MENU"
	else
		display_menu\
			""\
			"check_configure check_ft_printf ft_printf FT_PRINTF" "configure"\
			main "BACK TO MAIN MENU"
	fi
}

function check_ft_printf_moulitest
{	if [ "$OPT_NO_MOULITEST" == "0" ]; then
	check_moulitest "ft_printf"
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

fi;