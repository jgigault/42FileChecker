#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then


declare -a CHK_GNL='( "check_author" "auteur" "check_norme" "norminette" "check_gnl_macro" "BUFF_SIZE macro" "check_gnl_bonus" "bonus: static var" "check_gnl_forbidden_func" "forbidden functions" "check_gnl_basics" "basic tests" "check_gnl_multiple_fd" "bonus: multiple file descriptor" "check_gnl_leaks" "leaks" "check_gnl_moulitest" "moulitest (${MOULITEST_URL})" )'

declare -a CHK_GNL_BASICS='("gnl1_1" "1 line 8 chars with Line Feed" "" "gnl1_2" "2 lines 8 chars with Line Feed" "" "gnl1_3" "4 lines 8 chars with Line Feed" "" "gnl2_1" "STDIN: 1 line 8 chars with Line Feed" "cat ./srcs/gnl/gnl1_1.txt | SPEC0" "gnl2_2" "STDIN: 2 lines 8 chars with Line Feed" "cat ./srcs/gnl/gnl1_2.txt | SPEC0" "gnl2_3" "STDIN: 4 lines 8 chars with Line Feed" "cat ./srcs/gnl/gnl1_3.txt | SPEC0" "gnl3_1" "1 line 16 chars with Line Feed" "" "gnl3_2" "2 lines 16 chars with Line Feed" "" "gnl3_3" "4 lines 16 chars with Line Feed" "" "gnl4_1" "STDIN: 1 line 16 chars with Line Feed" "cat ./srcs/gnl/gnl3_1.txt | SPEC0" "gnl4_2" "STDIN: 2 lines 16 chars with Line Feed" "cat ./srcs/gnl/gnl3_2.txt | SPEC0" "gnl4_3" "STDIN: 4 lines 16 chars with Line Feed" "cat ./srcs/gnl/gnl3_3.txt | SPEC0" "gnl5_1" "1 line 4 chars with Line Feed" "" "gnl5_2" "2 lines 4 chars with Line Feed" "" "gnl5_3" "4 lines 4 chars with Line Feed" "" "gnl6_1" "STDIN: 1 line 4 chars with Line Feed" "cat ./srcs/gnl/gnl5_1.txt | SPEC0" "gnl6_2" "STDIN: 2 lines 4 chars with Line Feed" "cat ./srcs/gnl/gnl5_2.txt | SPEC0" "gnl6_3" "STDIN: 4 lines 4 chars with Line Feed" "cat ./srcs/gnl/gnl5_3.txt | SPEC0" "gnl7_1" "1 lines 8 chars without Line Feed" "" "gnl7_2" "2 lines 8 chars without Line Feed" "" "gnl7_3" "4 lines 8 chars without Line Feed" "" "gnl8_1" "STDIN: 1 line 8 chars without Line Feed" "cat ./srcs/gnl/gnl7_1.txt | SPEC0" "gnl8_2" "STDIN: 2 lines 8 chars without Line Feed" "cat ./srcs/gnl/gnl7_2.txt | SPEC0" "gnl8_3" "STDIN: 4 lines 8 chars without Line Feed" "cat ./srcs/gnl/gnl7_3.txt | SPEC0" "gnl9" "Bad file descriptor" "")'

declare -a CHK_GNL_AUTHORIZED_FUNCS='(read malloc free get_next_line main)'

function check_gnl_all
{
	local FUNC TITLE i j j2 k RET0 MYPATH TESTONLY
	TESTONLY="$1"
	MYPATH=$(get_config "gnl")
	configure_moulitest "gnl" "$MYPATH"
	i=0
	j=1
	k=0
	display_header
	display_top "$MYPATH" GET_NEXT_LINE
	while [ "${CHK_GNL[$i]}" != "" ]
	do
		FUNC=${CHK_GNL[$i]}
		(( i += 1 ))
		TITLE=`echo "${CHK_GNL[$i]}"  | sed 's/%/%%/g'`
		j2=`ft_itoa "$j"`
		printf "  $C_WHITE${j2} -> $TITLE$C_CLEAR\n"
		if [ "$TESTONLY" == "" -o "$TESTONLY" == "$k" ]
		then
			(eval "$FUNC" "all" > .myret) &
			display_spinner $!
			RET0=`cat .myret | sed 's/%/%%/g'`
			printf "$RET0\n"
			printf "\n"
		else
			printf $C_GREY"  --Not performed--\n"$C_CLEAR
			printf "\n"
		fi
		(( j += 1 ))
		(( i += 1 ))
		(( k += 1 ))
	done
	display_menu\
		""\
		check_gnl "OK"\
		"open .mynorminette" "more info: norminette"\
		"open .mymacro" "more info: BUFF_SIZE macro"\
		"open .mybonusstatic" "more info: bonus: static var"\
		"open .myforbiddenfunc" "more info: forbidden functions"\
		"open .mybasictests" "more info: basic tests"\
		"open .mymultiplefd" "more info: bonus: multiple file descriptor"\
		"open .myleaks" "more info: leaks"\
		"open .mymoulitest" "more info: moulitest"\
		"_"\
		"open https://github.com/jgigault/42FileChecker/issues/new" "REPORT A BUG"\
		main "BACK TO MAIN MENU"
}

function check_gnl_forbidden_func
{	if [ "${OPT_NO_FORBIDDEN}" == "0" ]; then
	local FILEN GNL_LIBFT RET0
	FILEN=forbiddenfuncs
	GNL_LIBFT="${MYPATH}/libft"
	check_create_tmp_dir
	check_gnl_create_header
	echo "#define NULL ((void *)0)\n#include \"gnl.h\"\nint main(void) { int ret; ret = get_next_line(0, NULL); return (1); }" > ./tmp/${FILEN}.c
	${CMD_RM} -f "./tmp/${FILEN}"
	if [ -d "${GNL_LIBFT}" ]
	then
		make -C "${GNL_LIBFT}" >/dev/null 2>&1
		RET0=`${CMD_GCC} "${MYPATH}/get_next_line.c" -L"${GNL_LIBFT}" -lft -I "${GNL_LIBFT}/includes" ./tmp/${FILEN}.c -o ./tmp/${FILEN} >/dev/null 2>&1`
	else
		RET0=`${CMD_GCC} "${MYPATH}/get_next_line.c" ./tmp/${FILEN}.c -o ./tmp/${FILEN} >/dev/null 2>&1`

	fi
	check_forbidden_func CHK_GNL_AUTHORIZED_FUNCS "./tmp/${FILEN}"
	else printf ${C_GREY}"  --Not performed--"${C_CLEAR}; fi
}

function check_gnl_basics
{	if [ "${OPT_NO_BASICTESTS}" == "0" ]; then
	local GNL_LIBFT i j FILEN TITLEN RET0 errors fatal SPEC0 LOGFILENAME
	LOGFILENAME=.mybasictests
	${CMD_RM} -f ${LOGFILENAME}
	${CMD_TOUCH} ${LOGFILENAME}
	check_create_tmp_dir
	check_gnl_create_header
	GNL_LIBFT="${MYPATH}/libft"
	i=0
	j=0
	errors=0
	fatal=0
	echo "GNL BASIC TESTS:\n" > ${LOGFILENAME}
	while [ "${CHK_GNL_BASICS[i]}" != "" ]
	do
		(( j += 1 ))
		FILEN="${CHK_GNL_BASICS[i]}"
		(( i += 1 ))
		TITLEN="${CHK_GNL_BASICS[i]}"
		(( i += 1 ))
		SPEC0="${CHK_GNL_BASICS[i]}"
		(( i += 1 ))
		echo "$j -> ${TITLEN} (${FILEN}.c):" >> ${LOGFILENAME}
		${CMD_RM} -f "./tmp/${FILEN}"
		if [ -d "${GNL_LIBFT}" ]
		then
			RET0=`${CMD_GCC} -Wall -Werror -Wextra -I ./tmp "${MYPATH}/get_next_line.c" -L"${GNL_LIBFT}" -lft -I "${GNL_LIBFT}/includes" ./srcs/gnl/${FILEN}.c -o ./tmp/${FILEN} >/dev/null 2>&1`
		else
			RET0=`${CMD_GCC} -Wall -Werror -Wextra -I ./tmp "${MYPATH}/get_next_line.c" ./srcs/gnl/${FILEN}.c -o ./tmp/${FILEN} >/dev/null 2>&1`
		fi
		if [ -f "./tmp/${FILEN}" ]
		then
			if [ "${SPEC0}" != "" ]
			then
				RET0=`echo "${SPEC0}" | sed 's/SPEC0/\.\/\.\/tmp\/${FILEN}/'`
				RET0=`eval ${RET0} 2>&1`
			else
				RET0=`./tmp/${FILEN} 2>&1`
			fi
			if [ "${RET0}" != "OK" ]
			then
				(( errors += 1 ))
			fi
			echo "${RET0}" >> ${LOGFILENAME}
		else
			echo "Cannot compile" >> ${LOGFILENAME}
			echo "${RET0}" >> ${LOGFILENAME}
			(( fatal += 1 ))
		fi
		echo "" >> ${LOGFILENAME}
	done
	if (( ${fatal} > 0 ))
	then
		printf ${C_RED}"  ${fatal} fatal error(s): Cannot compile"${C_CLEAR}
	else
		if (( ${errors} == 0 ))
		then
			printf ${C_GREEN}"  All tests passed"${C_CLEAR}
		else
			printf ${C_RED}"  ${errors} failed test(s)"${C_CLEAR}
		fi
	fi
	else printf ${C_GREY}"  --Not performed--"${C_CLEAR}; fi
}

function check_gnl_multiple_fd
{	if [ "${OPT_NO_GNLMULTIPLEFD}" == "0" ]; then
	local GNL_LIBFT i j FILEN TITLEN RET0 errors fatal GNLID LOGFILENAME
	LOGFILENAME=".mymultiplefd"
	${CMD_RM} -f ${LOGFILENAME}
	${CMD_TOUCH} ${LOGFILENAME}
	check_create_tmp_dir
	check_gnl_create_header
	GNL_LIBFT="${MYPATH}/libft"
	i=0
	j=0
	errors=0
	fatal=0
	${CMD_RM} -f "./tmp/gnl11"
	if [ -d "${GNL_LIBFT}" ]
	then
		make -C "${GNL_LIBFT}" >/dev/null 2>&1
		RET0=`${CMD_GCC} -Wall -Werror -Wextra -I ./tmp "${MYPATH}/get_next_line.c" -L"${GNL_LIBFT}" -lft -I "${GNL_LIBFT}/includes" ./srcs/gnl/gnl11.c -o ./tmp/gnl11 >${LOGFILENAME} 2>&1`
	else
		RET0=`${CMD_GCC} -Wall -Werror -Wextra -I ./tmp "${MYPATH}/get_next_line.c" ./srcs/gnl/gnl11.c -o ./tmp/gnl11 >${LOGFILENAME} 2>&1`
	fi
	if [ -f "./tmp/gnl11" ]
	then
		RET0=`./tmp/gnl11 2>&1`
		if [ "${RET0}" != "OK" ]
		then
			(( errors += 1 ))
		fi
	else
		fatal=1
	fi
	if (( ${fatal} > 0 ))
	then
		printf ${C_RED}"  Fatal error: Cannot compile"${C_CLEAR}
	else
		if (( ${errors} == 0 ))
		then
			printf ${C_GREEN}"  Multiple file descriptor supported"${C_CLEAR}
		else
			if [ "${RET0}" != "" ]
			then
				printf ${C_RED}"  ${RET0}"${C_CLEAR}
			else
				printf ${C_RED}"  An error occured"${C_CLEAR}
			fi
		fi
	fi
	else printf ${C_GREY}"  --Not performed--"${C_CLEAR}; fi
}

function check_gnl_leaks
{	if [ "${OPT_NO_LEAKS}" == "0" ]; then
	local GNL_LIBFT RET0 LOGFILENAME PROGNAME HEADERF VAL0 MACRONAME
	LOGFILENAME=".myleaks"
	${CMD_RM} -f ${LOGFILENAME}
	${CMD_TOUCH} ${LOGFILENAME}
	check_create_tmp_dir
	check_gnl_create_header
	HEADERF="${MYPATH}/get_next_line.h"
	GNL_LIBFT="${MYPATH}/libft"
	MACRONAME=$(check_gnl_get_macro_name "${HEADERF}")
	RET0=`cat "${HEADERF}" | grep define | grep "${MACRONAME}"`
	VAL0=`printf "%s" "${RET0}" | sed 's/[^0-9]*//g'`
	if [ $(printf "%d" "${VAL0}") -gt 11000 ]
	then
		echo "Please use a smaller ${MACRONAME}!\nMaximum is 11000." > ${LOGFILENAME}
		printf ${C_RED}"  Unable to perform the test (read more info)"${C_CLEAR}
	else
		${CMD_RM} -f "./tmp/gnl10"
		if [ -d "${GNL_LIBFT}" ]
		then
			make -C "${GNL_LIBFT}" >${LOGFILENAME} 2>&1
			RET0=`${CMD_GCC} -Wall -Werror -Wextra -I ./tmp "${MYPATH}/get_next_line.c" -L"${GNL_LIBFT}" -lft -I "${GNL_LIBFT}/includes" ./srcs/gnl/gnl10.c -o ./tmp/gnl10 2>&1`
		else
			RET0=`${CMD_GCC} -Wall -Werror -Wextra -I ./tmp "${MYPATH}/get_next_line.c" ./srcs/gnl/gnl10.c -o ./tmp/gnl10 2>&1`
		fi

		if [ -f "./tmp/gnl10" ]
		then
			RET0=`cat ./srcs/gnl/gnl10.c | sed 's/\\\\/\\\\\\\\/g'`
			NOTICE="Here is the main() test:\n-----------------------------\n${RET0}\n-----------------------------\n\n\n"
			check_leaks "./tmp/gnl10" "" "${LOGFILENAME}" "${NOTICE}"
		else
			echo "${RET0}" >> ${LOGFILENAME}
			printf ${C_RED}"  Fatal error: Cannot compile"${C_CLEAR}
		fi
	fi
	else printf ${C_GREY}"  --Not performed--"${C_CLEAR}; fi
}

function check_gnl_create_header
{
	local GNLH
	GNLH="$MYPATH/get_next_line.h"
	echo "#include \"$GNLH\"" > ./tmp/gnl.h
}

function check_gnl_bonus
{	if [ "$OPT_NO_GNLONESTATIC" == "0" ]; then
	local RET0 TOTAL GNLC LOGFILENAME
	LOGFILENAME=.mystatic
	$CMD_RM -f $LOGFILENAME
	$CMD_TOUCH $LOGFILENAME
	GNLC="$MYPATH/get_next_line.c"
	if [ -f "$GNLC" ]
	then
		RET0=`awk 'BEGIN { OFS=""; BLOCK=0 } { if ($0 == "{") { BLOCK=1 } if ($0 == "}") { BLOCK=0 } if (BLOCK == 1) { if ($0 ~ /^[\t ]*static[\t ]/) { gsub(/^[\t ]*/, ""); print "line ", NR, ": ", $0 }}}' "$GNLC"`
		TOTAL=`echo "$RET0" | wc -l | sed 's/[ 	]*//g'`
		if (( TOTAL > 1 ))
		then
			printf $C_RED"  $TOTAL static variables were found"$C_CLEAR
			echo "$RET0" > $LOGFILENAME
		else
			if [ "$RET0" == "" ]
			then
				printf $C_GREEN"  No static variable"$C_CLEAR
				echo "No static var found" > $LOGFILENAME
			else
				printf $C_GREEN"  $TOTAL static variable"$C_CLEAR
				echo "$RET0" > $LOGFILENAME
			fi
		fi
	else
		printf $C_RED"  get_next_line.c: File Not Found"$C_CLEAR
		echo "get_next_line.c: File Not Found" > $LOGFILENAME
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_gnl_macro
{	if [ "${OPT_NO_GNLMACRO}" == "0" ]; then
	local RET0 RET2 HEADERF VAL0 LOGFILENAME MACRONAME
	LOGFILENAME=".mymacro"
	${CMD_RM} -f ${LOGFILENAME}
	${CMD_TOUCH} ${LOGFILENAME}
	HEADERF="${MYPATH}/get_next_line.h"
	if [ -f "${HEADERF}" -a -f "${MYPATH}/get_next_line.c" ]
	then
		MACRONAME=$(check_gnl_get_macro_name "${HEADERF}")
	        if [ "${MACRONAME}" == "" ]
        	then
	        	printf ${C_RED}"  BUFF_SIZE is not defined"${C_CLEAR}
			echo "BUFF_SIZE is not defined" > ${LOGFILENAME}
	        else
			RET2=`cat "${MYPATH}/get_next_line.c" | grep -E "[^*]{2}.*read[ \t]*\([^,]*,[^,]*,[ \t]*${MACRONAME}[ \t]*)"`
			RET0=`cat "${HEADERF}" | grep 'define' | grep "${MACRONAME}"`
			VAL0=`echo "${RET0}" | sed 's/[^0-9]*//g'`
			if [ "${RET2}" == "" ]
			then
				printf ${C_RED}"  ${MACRONAME} is defined with value: ${VAL0}, but seems to be used not properly"${C_CLEAR}
				echo "${MACRONAME} should be used as the third parameter of the function 'read' without any handling! read([*], [*], ${MACRONAME})\n\nCheck the line(s) where the function 'read' is used:\n$(cat "${MYPATH}/get_next_line.c" | grep -E '[^*]{2}.*read[ \t]*\(' | sed 's/^[ 	]*//g')\n\nNote: When multiple lines are used for calling 'read', this test fails!" > ${LOGFILENAME}
			else
				printf ${C_GREEN}"  ${MACRONAME} is defined with value: ${VAL0}"${C_CLEAR}
				echo "${MACRONAME} is defined with value: ${VAL0}" > ${LOGFILENAME}
			fi
        	fi
	else
		printf ${C_RED}"  get_next_line.[ch]: File Not Found"${C_CLEAR}
		echo "get_next_line.[ch]: File Not Found" > ${LOGFILENAME}
	fi
	else printf ${C_GREY}"  --Not performed--"${C_CLEAR}; fi
}

function check_gnl_moulitest
{	if [ "$OPT_NO_MOULITEST" == "0" ]; then
	check_moulitest "gnl"
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_gnl
{
	local MYPATH
	MYPATH=$(get_config "gnl")
	display_header
	display_top "$MYPATH" GET_NEXT_LINE
	if [ -d "$MYPATH" ]
	then
		display_menu\
			""\
			check_gnl_all "check all!"\
			"_"\
			"TESTS" "CHK_GNL" "check_gnl_all"\
			"_"\
			"check_configure check_gnl gnl GET_NEXT_LINE" "change path"\
			main "BACK TO MAIN MENU"
	else
		display_menu\
			""\
			"check_configure check_gnl gnl GET_NEXT_LINE" "configure"\
			main "BACK TO MAIN MENU"
	fi
}

function check_gnl_get_macro_name
{
	local RET0 RET0 LPATH
	LPATH="$1"
	RET0=$(cat "${LPATH}" | grep -E '#[ ]*define')
	if [ "$(echo "${RET0}" | grep 'BUFF_SIZE')" != "" ]
	then
		printf "BUFF_SIZE"
		return
	fi
	if [ "$(echo "${RET0}" | grep 'BUF_SIZE')" != "" ]
	then
		printf "BUF_SIZE"
		return
	fi
	if [ "$(echo "${RET0}" | grep 'BUFFER_SIZE')" != "" ]
	then
		printf "BUFFER_SIZE"
		return
	fi
	if [ "$(echo "${RET0}" | grep 'BUFFSIZE')" != "" ]
	then
		printf "BUFFSIZE"
		return
	fi
	if [ "$(echo "${RET0}" | grep 'BUFSIZE')" != "" ]
	then
		printf "BUFSIZE"
		return
	fi
	if [ "$(echo "${RET0}" | grep 'BUFFERSIZE')" != "" ]
	then
		printf "BUFFERSIZE"
		return
	fi
}

fi;