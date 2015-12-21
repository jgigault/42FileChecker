#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

source includes/libftasm_list.sh

declare -a CHK_LIBFTASM='( "check_author" "auteur" "check_libftasm_required_exists" "required functions" "check_libftasm_extra" "bonus functions" "check_libftasm_makefile" "makefile" "check_libftasm_forbidden_func" "forbidden functions" "check_libftasm_basictests" "basic tests (beta)" )'

declare -a LIBFTASM_MANDATORIES='(ft_bzero.s ft_strcat.s ft_isalpha.s ft_isdigit.s ft_isalnum.s ft_isascii.s ft_isprint.s ft_toupper.s ft_tolower.s ft_puts.s ft_strlen.s ft_memset.s ft_memcpy.s ft_strdup.s ft_cat.s)'

declare -a CHK_LIBFTASM_AUTHORIZED_FUNCS='(malloc write read main)'

function check_libftasm_all
{
	local FUNC TITLE i j k j2 RET0 MYPATH TESTONLY
	TESTONLY="$1"
	MYPATH=$(get_config "libftasm")
	configure_moulitest "libftasm" "$MYPATH"
	i=0
	j=1
	k=0
	display_header
	display_top "$MYPATH" LIBFTASM
	while [ "${CHK_LIBFTASM[$i]}" != "" ]
	do
		FUNC="${CHK_LIBFTASM[$i]}"
		(( i += 1 ))
		TITLE=`echo "${CHK_LIBFTASM[$i]}"  | sed 's/%/%%/g'`
		j2=`ft_itoa "$j"`
		printf "  $C_WHITE$j -> $TITLE$C_CLEAR\n"
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
		"check_libftasm" "RETRY"\
		"open .myLIBFTASM_MANDATORIES" "more info: required functions"\
		"open .myLIBFTASM_BONUS" "more info: bonus functions"\
		"open .mymakefile" "more info: makefile"\
		"open .myforbiddenfunc" "more info: forbidden functions"\
		"open .mybasictests" "more info: basic tests (beta)"\
		"_"\
		"open https://github.com/jgigault/42FileChecker/issues/new" "REPORT A BUG"\
		main "BACK TO MAIN MENU"
}

function check_libftasm_basictests
{	if [ "$OPT_NO_BASICTESTS" == "0" ]; then
	local total errors fatal success i TTYPE TINDEX TVAL TARGS FILEN RET1 RET2 RET0 TYPE TVAL0 TNAME DIR TPART
	i=0
	index=0
	total=0
	errors=0
	success=0
	fatal=0
	TYPE="$1"
	LOGFILENAME=".mybasictests"
	DIR=$( cd "$( dirname "$0" )" && pwd )
	$CMD_RM -f $LOGFILENAME $LOGFILENAME"success"
	touch $LOGFILENAME $LOGFILENAME"success"
	check_create_tmp_dir
	make re -C "$MYPATH" >$LOGFILENAME 2>&1
	if [ -f "$MYPATH"/libfts.a ]
	then
		$CMD_RM -f $LOGFILENAME $LOGFILENAME
		echo "SUCCESS TESTS:\n" >> $LOGFILENAME"success"
		while [ "${CHK_LIBFTASM_LIST[$i]}" != "" -a $fatal -eq 0 ]
		do
			(( index += 1 ))
			TPART="${CHK_LIBFTASM_LIST[$i]}"
			(( i += 1 ))
			TTYPE="${CHK_LIBFTASM_LIST[$i]}"
			(( i += 1 ))
			TINDEX="${CHK_LIBFTASM_LIST[$i]}"
			(( i += 1 ))
			TNAME="${CHK_LIBFTASM_LIST[$i]}"
			(( i += 1 ))
			TVAL0="${CHK_LIBFTASM_LIST[$i]}"
			(( i += 1 ))
			if [ "$TPART" != "bonus" -o "$(find "$MYPATH" -name "ft_${TTYPE}.s")" != "" ]
			then
				TVAL=`printf "%s" "$TVAL0" | sed 's/\\\\/\\\\\\\\/g'`
				(( total += 1 ))
				RET0=`check_libftasm_basictests_gcc "${TTYPE}" "$LOGFILENAME"`
				if [ "$RET0" != "" ]
				then
					(( fatal += 1 ));
				else
					TARGS=`echo "\"$TVAL0\"" | sed 's/|/\" \"/g'`
					TARGSV=`echo "\"$TVAL\"" | sed 's/|/\" \"/g'`
					FILEN1="./tmp/ft_${TTYPE}"
					FILEN2="./tmp/${TTYPE}"
					RET1=`eval "$FILEN1 $TINDEX $TARGS" 2>/dev/null`
					RET2=`eval "$FILEN2 $TINDEX $TARGS" 2>/dev/null`
					RET1=`printf "%s" "$RET1" | awk 'BEGIN{ORS="[EOL]"}{print}' | sed 's/\[EOL\]$//'`
					RET2=`printf "%s" "$RET2" | awk 'BEGIN{ORS="[EOL]"}{print}' | sed 's/\[EOL\]$//'`
					if [ "$RET1" != "$RET2" ]
					then
						if (( $errors == 0 ))
						then
							echo "FAILED TESTS:\n" >> $LOGFILENAME
							echo "# TEST NUMBER" >> $LOGFILENAME
							echo "  PART / FUNCTION() / DESCRIPTION" >> $LOGFILENAME
							echo "  1. your function returned value" >> $LOGFILENAME
							echo "  2. unix function returned value" >> $LOGFILENAME
						fi
						(( errors += 1 ))
						printf "\n# %04d %s\n" "$index" "$TTYPEV" >> $LOGFILENAME
						printf "  %s / ft_%s() / %s\n" "$TPART" "$TTYPE" "$TNAME" >> $LOGFILENAME
						printf "  (source: %s)\n" "$DIR/srcs/libftasm/ft_${TTYPE}.c" >> $LOGFILENAME
						printf "  (arguments: %s)\n" "\"$TINDEX\" $TARGSV" >> $LOGFILENAME
						RET0=`printf "%s" "$RET1" | sed 's/\\\\/\\\\\\\\/g'`
						printf "  1. %s\n" "$RET0" >> $LOGFILENAME 2>&1
						RET0=`printf "%s" "$RET2" | sed 's/\\\\/\\\\\\\\/g'`
						printf "  2. %s\n\n" "$RET0" >> $LOGFILENAME 2>&1
						printf "%4d. FAIL %s\n" "$index" "ft_"$TTYPE"(); $TNAME" >> $LOGFILENAME"success"
					else
						(( success += 1 ))
						printf "%4d.      %s\n" "$index" "ft_"$TTYPE"(); $TNAME" >> $LOGFILENAME"success"
					fi
				fi
			fi
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
	else
		printf $C_RED"  Makefile does not compile"$C_CLEAR
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_libftasm_basictests_gcc
{
	local FILEN RET0 LOGFILENAME
	FILEN="$1"
	LOGFILENAME="$2"
	if [ ! -f "./tmp/ft_$FILEN" -o ! -f "./tmp/$FILEN" ]
	then
		if [ -f "$MYPATH/libfts.a" ]
		then
			RET0=`gcc -Wall -Werror -Wextra "./srcs/libftasm/ft_$FILEN.c" -L"$MYPATH" -lfts -o "./tmp/ft_$FILEN" >/dev/null 2>&1`
			if [ "$RET0" != "" ]; then echo "$RET0" > $LOGFILENAME; printf "error"; return; fi
			RET0=`gcc "./srcs/libftasm/$FILEN.c" -o "./tmp/$FILEN" >/dev/null 2>&1`
			if [ "$RET0" != "" ]; then echo "$RET0" > $LOGFILENAME; printf "error"; return; fi
		else
			echo "$MYPATH/libfts.a was not found" > $LOGFILENAME; printf "error"; return;
		fi
	fi
	return 1
}

function check_libftasm_makefile
{
	local MYPATH
	MYPATH=$(get_config "libftasm")
	check_makefile "$MYPATH" libfts.a
}

function check_libftasm_required_exists
{
	check_fileexists LIBFTASM_MANDATORIES
}

function check_libftasm_forbidden_func
{
	local F LOG_FILENAME
	LOG_FILENAME=.myforbiddenfunc
	if [ -f "$MYPATH/Makefile" ]
	then
		FILEN=forbiddenfuncs
		F=$RETURNPATH/tmp/$FILEN.c
		check_create_tmp_dir
		echo "#include <sys/types.h>" > $F
		echo "#define NULL ((void *)0)" >> $F
		echo "void *ft_memset(void *b, int c, size_t len);" >> $F
		echo "void *ft_memcpy(void *restrict dst, const void *restrict src, size_t n);" >> $F
		echo "void ft_bzero(void *s, size_t n);" >> $F
		echo "size_t ft_strlen(const char *s);" >> $F
		echo "char *ft_strdup(const char *s1);" >> $F
		echo "char *ft_strcat(char *restrict s1, const char *restrict s2);" >> $F
		echo "int ft_isalpha(int c);" >> $F
		echo "int ft_isdigit(int c);" >> $F
		echo "int ft_isalnum(int c);" >> $F
		echo "int ft_isascii(int c);" >> $F
		echo "int ft_isprint(int c);" >> $F
		echo "int ft_toupper(int c);" >> $F
		echo "int ft_tolower(int c);" >> $F
		echo "void ft_puts(char *str);" >> $F
		echo "void ft_cat(int fd);" >> $F
		echo "int main(void) {" >> $F
		echo "ft_memset(NULL, 0, 0);" >> $F
		echo "ft_memcpy(NULL, NULL, 0);" >> $F
		echo "ft_bzero(NULL, 0);" >> $F
		echo "ft_strlen(NULL);" >> $F
		echo "ft_strdup(NULL);" >> $F
		echo "ft_strcat(NULL, NULL);" >> $F
		echo "ft_isalpha(0);" >> $F
		echo "ft_isdigit(0);" >> $F
		echo "ft_isalnum(0);" >> $F
		echo "ft_isascii(0);" >> $F
		echo "ft_isprint(0);" >> $F
		echo "ft_toupper(0);" >> $F
		echo "ft_tolower(0);" >> $F
		echo "ft_puts(NULL);" >> $F
		echo "ft_cat(0);" >> $F
		echo "return (1); }" >> $F
		cd "$RETURNPATH"/tmp
		make re -C "$MYPATH" 1>../$LOG_FILENAME 2>&1
		if [ -f "$MYPATH"/libfts.a ]
		then
			$CMD_RM -f "$FILEN"
			$CMD_GCC "$F" -L"$MYPATH" -lfts -o "$FILEN" >../$LOG_FILENAME 2>/dev/null
			cd "$RETURNPATH"
			if [ -f "./tmp/$FILEN" ]
			then
				check_forbidden_func CHK_LIBFTASM_AUTHORIZED_FUNCS "./tmp/$FILEN" s
			else
				printf $C_RED"  An error occured"$C_CLEAR
			fi
		else
			printf $C_RED"  lifts.a was not found"$C_CLEAR
		fi
	else
		printf $C_RED"  Makefile not found"$C_CLEAR
	fi
}

function check_libftasm_extra
{
	local i j exists TOTAL TOTAL2 RET0 LOGFILENAME
	LOGFILENAME=.myLIBFTASM_BONUS
	$CMD_RM -f $LOGFILENAME $LOGFILENAME
	$CMD_TOUCH $LOGFILENAME $LOGFILENAME
	TOTAL=0
	TOTAL2=0
	for i in $(ls -R1 "$MYPATH" | sed '/^\.\/\./d' | grep -E \\.\[s\]$)
	do
		j=0
		exists=0
		while [ "$exists" == "0" -a "${LIBFTASM_MANDATORIES[$j]}" != "" ]
		do
			if [ "${LIBFTASM_MANDATORIES[$j]}" == "$i" ]
			then
				exists=1
				(( TOTAL += 1 ))
			fi
			(( j += 1 ))
		done
		j=0
		while [ "$exists" == "0" -a "${LIBFTASM_BONUS[$j]}" != "" ]
		do
			if [ "${LIBFTASM_BONUS[$j]}" == "$i" ]
			then
				exists=1
				(( TOTAL += 1 ))
			fi
			(( j += 1 ))
		done
		if [ "$exists" == "0" ]
		then
			(( TOTAL2 += 1 ))
			RET0=$RET0"Extra function: $i\n"
		fi
	done
	echo "$RET0" > $LOGFILENAME
	if [ "$TOTAL2" == "0" ]
	then
		printf $C_RED"  No extra functions were found"$C_CLEAR
	else
		if [ "$TOTAL2" == "1" ]
		then
			printf $C_GREEN"  1 extra function was found"$C_CLEAR
		else
			printf $C_GREEN"  $TOTAL2 extra functions were found"$C_CLEAR
		fi
	fi
}

function check_libftasm
{
	local MYPATH
	MYPATH=$(get_config "libftasm")
	display_header
	display_top "$MYPATH" LIBFTASM
	if [ -d "$MYPATH" ]
	then
		display_menu\
            ""\
			check_libftasm_all "check all!"\
			"_"\
			"TESTS" "CHK_LIBFTASM" "check_libftasm_all"\
			"_"\
			"check_configure check_libftasm libftasm LIBFTASM" "change path"\
			main "BACK TO MAIN MENU"
	else
		display_menu\
			""\
			"check_configure check_libftasm libftasm LIBFTASM" "configure"\
			main "BACK TO MAIN MENU"
	fi
}

fi;