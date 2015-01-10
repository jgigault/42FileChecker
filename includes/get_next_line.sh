#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then


declare -a CHK_GNL='( "check_libft_all" "all" "check_author" "auteur" "check_norme" "norminette" "check_gnl_macro" "BUFF_SIZE macro" "check_gnl_bonus" "bonus: static var" "check_gnl_forbidden_func" "forbidden functions" "check_gnl_basics" "basic tests" "check_gnl_multiple_fd" "bonus: multiple file descriptor" "check_gnl_leaks" "leaks" "check_gnl_moulitest" "moulitest (yyang@student.42.fr)" )'

declare -a CHK_GNL_BASICS='("gnl1_1" "1 line 8 chars with Line Feed" "" "gnl1_2" "2 lines 8 chars with Line Feed" "" "gnl1_3" "4 lines 8 chars with Line Feed" "" "gnl2_1" "STDIN: 1 line 8 chars with Line Feed" "cat gnl1_1.txt | SPEC0" "gnl2_2" "STDIN: 2 lines 8 chars with Line Feed" "cat gnl1_2.txt | SPEC0" "gnl2_3" "STDIN: 4 lines 8 chars with Line Feed" "cat gnl1_3.txt | SPEC0" "gnl3_1" "1 line 16 chars with Line Feed" "" "gnl3_2" "2 lines 16 chars with Line Feed" "" "gnl3_3" "4 lines 16 chars with Line Feed" "" "gnl4_1" "STDIN: 1 line 16 chars with Line Feed" "cat gnl3_1.txt | SPEC0" "gnl4_2" "STDIN: 2 lines 16 chars with Line Feed" "cat gnl3_2.txt | SPEC0" "gnl4_3" "STDIN: 4 lines 16 chars with Line Feed" "cat gnl3_3.txt | SPEC0" "gnl5_1" "1 line 4 chars with Line Feed" "" "gnl5_2" "2 lines 4 chars with Line Feed" "" "gnl5_3" "4 lines 4 chars with Line Feed" "" "gnl6_1" "STDIN: 1 line 4 chars with Line Feed" "cat gnl5_1.txt | SPEC0" "gnl6_2" "STDIN: 2 lines 4 chars with Line Feed" "cat gnl5_2.txt | SPEC0" "gnl6_3" "STDIN: 4 lines 4 chars with Line Feed" "cat gnl5_3.txt | SPEC0" "gnl7_1" "1 lines 8 chars without Line Feed" "" "gnl7_2" "2 lines 8 chars without Line Feed" "" "gnl7_3" "4 lines 8 chars without Line Feed" "" "gnl8_1" "STDIN: 1 line 8 chars without Line Feed" "cat gnl7_1.txt | SPEC0" "gnl8_2" "STDIN: 2 lines 8 chars without Line Feed" "cat gnl7_2.txt | SPEC0" "gnl8_3" "STDIN: 4 lines 8 chars without Line Feed" "cat gnl7_3.txt | SPEC0" "gnl9" "Bad file descriptor" "")'

declare -a CHK_GNL_AUTHORIZED_FUNCS='(read malloc free get_next_line main)'

function check_gnl_all
{
	local FUNC TITLE i j RET0 MYPATH
	MYPATH=$(get_config "gnl")
	configure_moulitest "gnl" "$MYPATH"
	i=2
	j=1;
	display_header
	display_righttitle ""
	check_gnl_top "$MYPATH"
	while [ "${CHK_GNL[$i]}" != "" ]
	do
		FUNC=${CHK_GNL[$i]}
		(( i += 1 ))
		TITLE=${CHK_GNL[$i]}
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
		"open .mymacro" "more info: BUFF_SIZE macro"\
		"open .mybonusstatic" "more info: bonus: static var"\
		"open .myforbiddenfunc" "more info: forbidden functions"\
		"open .mybasictests" "more info: basic tests"\
		"open .mymultiplefd" "more info: bonus: multiple file descriptor"\
		"open .myleaks" "more info: leaks"\
		"open .mymoulitest" "more info: moulitest"
}

function check_gnl_forbidden_func
{	if [ "$OPT_NO_FORBIDDEN" == "0" ]; then
	FILEN=forbiddenfuncs
	GNLC="$MYPATH/get_next_line.c"
	GNL_LIBFT="$MYPATH/libft"
	EXTRA0=
	check_create_tmp_dir
	check_gnl_create_header
	if [ -d "$GNL_LIBFT" ]
	then
		make re -C "$GNL_LIBFT" >/dev/null
		EXTRA0=" -L$GNL_LIBFT -lft -I $GNL_LIBFT/includes"
	fi
	echo "#define NULL ((void *)0)\n#include \"../srcs/gnl/gnl.h\"\nint main(void) { int ret; ret = get_next_line(0, NULL); return (1); }" > $RETURNPATH/tmp/$FILEN.c
	cd "$RETURNPATH"/tmp
	rm -f "$FILEN"
	RET0=`gcc $GNLC $EXTRA0 $FILEN.c -o $FILEN 2>&1`
	cd "$RETURNPATH"
	check_forbidden_func CHK_GNL_AUTHORIZED_FUNCS "./tmp/$FILEN"
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_gnl_basics
{	if [ "$OPT_NO_BASICTESTS" == "0" ]; then
	local GNLC GNL_LIBFT EXTRA0 i j FILEN TITLEN RET0 errors fatal SPEC0
	check_gnl_create_header
	GNLC="$MYPATH/get_next_line.c"
	GNL_LIBFT="$MYPATH/libft"
	EXTRA0=
	if [ -d "$GNL_LIBFT" ]
	then
		make re -C "$GNL_LIBFT" >/dev/null
		EXTRA0=" -L$GNL_LIBFT -lft -I $GNL_LIBFT/includes"
	fi
	cd "$RETURNPATH"/srcs/gnl
	i=0
	j=0
	errors=0
	fatal=0
	echo "GNL BASIC TESTS:\n" > "$RETURNPATH"/.mybasictests
	while [ "${CHK_GNL_BASICS[i]}" != "" ]
	do
		(( j += 1 ))
		FILEN="${CHK_GNL_BASICS[i]}"
		(( i += 1 ))
		TITLEN="${CHK_GNL_BASICS[i]}"
		(( i += 1 ))
		SPEC0="${CHK_GNL_BASICS[i]}"
		(( i += 1 ))
		echo "$j -> $TITLEN ($FILEN.c):" >> "$RETURNPATH"/.mybasictests
		rm -f "$FILEN"
		RET0=`gcc -Wall -Werror -Wextra $GNLC $EXTRA0 $FILEN.c -o $FILEN 2>&1`
		if [ -f $FILEN ]
		then
			if [ "$SPEC0" != "" ]
			then
				RET0=`echo "$SPEC0" | sed 's/SPEC0/\.\/$FILEN/'`
				RET0=`eval $RET0 2>&1`
			else
				RET0=`./$FILEN 2>&1`
			fi
			if [ "$RET0" != "OK" ]
			then
				(( errors += 1 ))
			fi
			echo "$RET0" >> "$RETURNPATH"/.mybasictests
		else
			echo "Cannot compile" >> "$RETURNPATH"/.mybasictests
			echo "$RET0" >> "$RETURNPATH"/.mybasictests
			(( fatal += 1 ))
		fi
		echo "" >> "$RETURNPATH"/.mybasictests
	done
	cd "$RETURNPATH"
	if (( $fatal > 0 ))
	then
		printf $C_RED"  $fatal fatal error(s): Cannot compile"$C_CLEAR
	else
		if (( $errors == 0 ))
		then
			printf $C_GREEN"  All tests passed"$C_CLEAR
		else
			printf $C_RED"  $errors failed test(s)"$C_CLEAR
		fi
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_gnl_multiple_fd
{	if [ "$OPT_NO_GNLMULTIPLEFD" == "0" ]; then
	local GNLC GNL_LIBFT EXTRA0 i j FILEN TITLEN RET0 errors fatal GNLID
	check_gnl_create_header
	GNLC="$MYPATH/get_next_line.c"
	GNL_LIBFT="$MYPATH/libft"
	EXTRA0=
	if [ -d "$GNL_LIBFT" ]
	then
		make re -C "$GNL_LIBFT" >/dev/null
		EXTRA0=" -L$GNL_LIBFT -lft -I $GNL_LIBFT/includes"
	fi
	i=0
	j=0
	errors=0
	fatal=0
	rm -f .mymultiplefd
	touch .mymultiplefd
	rm -f "$RETURNPATH/srcs/gnl/gnl11"
	cd "$RETURNPATH"/srcs/gnl
	RET0=`gcc -Wall -Werror -Wextra $GNLC $EXTRA0 gnl11.c -o gnl11 1>../../.mymultiplefd 2>&1`
	cd "$RETURNPATH"
	if [ -f "$RETURNPATH/srcs/gnl/gnl11" ]
	then
		RET0=`./srcs/gnl/gnl11 2>&1`
		if [ "$RET0" != "OK" ]
		then
			(( errors += 1 ))
		fi
	else
		fatal=1
	fi
	if (( $fatal > 0 ))
	then
		printf $C_RED"  Fatal error: Cannot compile"$C_CLEAR
	else
		if (( $errors == 0 ))
		then
			printf $C_GREEN"  Multiple file descriptor supported"$C_CLEAR
		else
			if [ "$RET0" != "" ]
			then
				printf $C_RED"  $RET0"$C_CLEAR
			else
				printf $C_RED"  An error occured"$C_CLEAR
			fi
		fi
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_gnl_leaks
{	if [ "$OPT_NO_LEAKS" == "0" ]; then
	local GNLC GNL_LIBFT EXTRA0 RET0 LOGFILENAME PROGNAME
	check_gnl_create_header
	GNLC="$MYPATH/get_next_line.c"
	GNL_LIBFT="$MYPATH/libft"
	EXTRA0=
	LOGFILENAME=.myleaks
	if [ -d "$GNL_LIBFT" ]
	then
		make re -C "$GNL_LIBFT" >/dev/null
		EXTRA0=" -L$GNL_LIBFT -lft -I $GNL_LIBFT/includes"
	fi
	rm -f $LOGFILENAME
	touch $LOGFILENAME
	rm -f "$RETURNPATH/srcs/gnl/gnl10"
	cd "$RETURNPATH"/srcs/gnl
	RET0=`gcc -Wall -Werror -Wextra $GNLC $EXTRA0 gnl10.c -o gnl10 1>../../.myleaks 2>&1`
	cd "$RETURNPATH"
	if [ -f "$RETURNPATH/srcs/gnl/gnl10" ]
	then
		RET0=`cat ./srcs/gnl/gnl10.c | sed 's/\\\\/\\\\\\\\/g'`
		NOTICE="If you are sure that your 'get_next_line' has no leaks, read this:\nIn my opinion, 'get_next_line' should free itself the pointer 'line' when a new line is read, like the function 'getline(3)' in linux does (man 3 getline).\nThe similar function 'getline' reallocate the pointer 'line' when a new line is read, so no leaks appear.\nDo not hesitate to contact me if you want to debate...\n\nHere is the main() test:\n-----------------------------\n$RET0\n-----------------------------\n\n\n"
		check_leaks "./srcs/gnl/gnl10" "" ".myleaks" "$NOTICE"
	else
		printf $C_RED"  Fatal error: Cannot compile"$C_CLEAR
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_gnl_create_header
{
	local GNLH
	GNLH="$MYPATH/get_next_line.h"
	echo "#include \"$GNLH\"" > "$RETURNPATH"/srcs/gnl/gnl.h
}

function check_gnl_bonus
{	if [ "$OPT_NO_GNLONESTATIC" == "0" ]; then
	local RET0 TOTAL GNLC
	GNLC="$MYPATH/get_next_line.c"
	if [ -f "$GNLC" ]
	then
		RET0=`awk 'BEGIN { OFS=""; BLOCK=0 } { if ($0 == "{") { BLOCK=1 } if ($0 == "}") { BLOCK=0 } if (BLOCK == 1) { if ($0 ~ /^[\t ]*static[\t ]/) { gsub(/^[\t ]*/, ""); print "line ", NR, ": ", $0 }}}' $GNLC`
		TOTAL=`echo "$RET0" | wc -l | sed 's/[ 	]*//g'`
		if (( TOTAL > 1 ))
		then
			printf $C_RED"  $TOTAL static variables were found"$C_CLEAR
			echo "$RET0" > "$RETURNPATH"/.mybonusstatic
		else
			if [ "$RET0" == "" ]
			then
				printf $C_GREEN"  No static variable"$C_CLEAR
				echo "No static var found" > "$RETURNPATH"/.mybonusstatic
			else
				printf $C_GREEN"  $TOTAL static variable"$C_CLEAR
				echo "$RET0" > "$RETURNPATH"/.mybonusstatic
			fi
		fi
	else
		printf $C_RED"  get_next_line.c: File Not Found"$C_CLEAR
		echo "get_next_line.c: File Not Found" > "$RETURNPATH"/.mybonusstatic
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_gnl_macro
{	if [ "$OPT_NO_GNLMACRO" == "0" ]; then
    local RET0 RET2 HEADERF GNLC VAL0
    HEADERF="$MYPATH/get_next_line.h"
	GNLC="$MYPATH/get_next_line.c"
	if [ -f "$HEADERF" -a -f "$GNLC" ]
    then
        RET0=`cat "$HEADERF" | grep define | grep BUFF_SIZE`
        if [ "$(echo "$RET0" | wc -l | sed 's/ //g')" == "0" ]
        then
            printf $C_RED"  BUFF_SIZE is not defined"$C_CLEAR | tee "$RETURNPATH"/.mymacro
        else
			RET2=`cat "$GNLC" | grep -E 'read[ 	]*\([ 	&->a-zA-Z0-1]*,[ 	&->a-zA-Z0-1]*,[ 	]*BUFF_SIZE[ 	]*)'`
			VAL0=`echo "$RET0" | sed 's/#//' | sed 's/BUFF_SIZE//' | sed 's/define//' | sed 's/ //g'`
			if [ "$RET2" == "" ]
			then
				printf $C_RED"  BUFF_SIZE is defined as: $VAL0, but seems to be used not properly"$C_CLEAR
				echo "BUFF_SIZE should be used as the third parameter of the function 'read' without any handling! read([*], [*], BUFF_SIZE)\n\nCheck the line where the function 'read' is used:\n$(cat "$GNLC" | grep -E 'read[ ]*\(' | sed 's/^[ 	]*//g')" > "$RETURNPATH"/.mymacro
			else
				printf $C_GREEN"  BUFF_SIZE is defined as: $VAL0"$C_CLEAR
				echo "BUFF_SIZE is defined with value: $VAL0" > "$RETURNPATH"/.mymacro
			fi
        fi
    else
        printf $C_RED"  get_next_line.h: File Not Found"$C_CLEAR
		echo "get_next_line.h: File Not Found" > "$RETURNPATH"/.mymacro
    fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_gnl_moulitest
{	if [ "$OPT_NO_MOULITEST" == "0" ]; then
	local RET0 TOTAL
	if [ -d moulitest ]
	then
		rm -f "$RETURNPATH"/.mymoulitest
		cd "$RETURNPATH/moulitest/"
		make gnl 1> "$RETURNPATH"/.mymoulitest 2>&1
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
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_gnl
{
	local MYPATH
	MYPATH=$(get_config "gnl")
	display_header
	display_righttitle ""
	check_gnl_top "$MYPATH"
	if [ -d "$MYPATH" ]
	then
		display_menu\
            ""\
			check_gnl_all "check it!"\
			config_gnl "change path"\
			main "BACK TO MAIN MENU"
	else
		display_menu\
			""\
			config_gnl "configure"\
			main "BACK TO MAIN MENU"
	fi
}

function config_gnl
{
	local AB0 AB2 MYPATH
	MYPATH=$(get_config "gnl")
	display_header
	display_righttitle ""
	check_gnl_top "$MYPATH"
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
		check_gnl_top
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
	save_config "gnl" "$AB2"
	printf $C_CLEAR""
	check_gnl
}

function check_gnl_top
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
        printf "%"$LEN"s" "GET_NEXT_LINE  "
        printf $C_CLEAR"  $LPATH\n\n"
    else
        printf "  GET_NEXT_LINE\n"
        printf "\n"
    fi
    printf ""$C_CLEAR
}

fi;