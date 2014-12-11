#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then


declare -a CHK_LIBFT='( "check_author" "auteur" "check_fileexists LIBFT_MANDATORIES" "required functions" "check_fileexists LIBFT_BONUS" "bonus" "check_libft_extra" "extra functions" "check_norme" "norminette" "check_libft_static" "static declarations" "check_libft_moulitest" "moulitest (yyang@student.42.fr)" )'

declare -a LIBFT_MANDATORIES='(libft.h ft_strcat.c ft_strncat.c ft_strlcat.c ft_strchr.c ft_strnstr.c ft_strrchr.c ft_strclr.c ft_strcmp.c ft_strncmp.c ft_strcpy.c ft_strncpy.c ft_strdel.c ft_strdup.c ft_strequ.c ft_strnequ.c ft_striter.c ft_striteri.c ft_strjoin.c ft_strlen.c ft_strmap.c ft_strmapi.c ft_strnew.c ft_strstr.c ft_strsplit.c ft_strsub.c ft_strtrim.c ft_atoi.c ft_itoa.c ft_tolower.c ft_toupper.c ft_putchar.c ft_putchar_fd.c ft_putstr.c ft_putstr_fd.c ft_putnbr.c ft_putnbr_fd.c ft_putendl.c ft_putendl_fd.c ft_isalnum.c ft_isalpha.c ft_isascii.c ft_isdigit.c ft_isprint.c ft_isspace.c ft_memalloc.c ft_memnew.c ft_memchr.c ft_memcmp.c ft_memcpy.c ft_memccpy.c ft_memdup.c ft_memdel.c ft_memmove.c ft_memset.c ft_bzero.c)'

declare -a LIBFT_BONUS='(ft_lstnew.c ft_lstdelone.c ft_lstdel.c ft_lstiter.c ft_lstadd.c ft_lstmap.c)'

declare -a LIBFT_EXTRA='()'

function check_libft_all
{
	local FUNC TITLE i j RET0 MYPATH
	MYPATH=$(get_config "libft")
	configure_moulitest "libft" "$MYPATH"
	i=0
	j=1
	display_header
	display_righttitle ""
	check_libft_top "$MYPATH"
	while [ "${CHK_LIBFT[$i]}" != "" ]
	do
		FUNC="${CHK_LIBFT[$i]}"
		(( i += 1 ))
		TITLE="${CHK_LIBFT[$i]}"
		printf "  $C_WHITE$j -> $TITLE$C_CLEAR\n"
		(eval "$FUNC" > .myret) &
		display_spinner $!
		RET0=`cat .myret`
		printf "$RET0\n"
		printf "\n"
		(( j += 1 ))
		(( i += 1 ))
	done
	display_menu\
		""\
		main "OK"\
		"open .myLIBFT_MANDATORIES" "see details: required functions"\
		"open .myLIBFT_BONUS" "see details: bonus functions"\
		"open .myextra" "see details: extra functions"\
		"open .mynorminette" "see details: norminette"\
		"open .mystatic" "see details: static declarations"\
		"open .mymoulitest" "see details: moulitest"
}

function check_libft_extra
{
	local i j exists TOTAL TOTAL2 RET0
	TOTAL=0
	TOTAL2=0
	for i in $(ls -1 "$MYPATH" | sed '/^\.\/\./d' | grep -E \\.\[c\]$)
	do
		j=0
		exists=0
		while [ "$exists" == "0" -a "${LIBFT_MANDATORIES[$j]}" != "" ]
		do
			if [ "${LIBFT_MANDATORIES[$j]}" == "$i" ]
			then
				exists=1
				(( TOTAL += 1 ))
			fi
			(( j += 1 ))
		done
		j=0
		while [ "$exists" == "0" -a "${LIBFT_BONUS[$j]}" != "" ]
		do
			if [ "${LIBFT_BONUS[$j]}" == "$i" ]
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
	printf "$RET0" > "$RETURNPATH"/.myextra
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

function check_libft_moulitest
{
	local RET0 TOTAL
	rm -f "$RETURNPATH"/.mymoulitest
	cd "$RETURNPATH"/moulitest/libft_tests/
	RET0=`check_fileexists LIBFT_BONUS | grep 'All files were found'`
	if [ "$RET0" == "" ]
	then
		make part2 1> "$RETURNPATH"/.mymoulitest 2>&1
	else
		make bonus 1> "$RETURNPATH"/.mymoulitest 2>&1
	fi
	cd "$RETURNPATH"
	RET0=`cat .mymoulitest | sed 's/\^\[\[[0-9;]*m//g' | sed 's/\^\[\[0m//g' | sed 's/\$$//' | grep "END OF UNIT TESTS"`
	if [ "$RET0" == "" ]
	then
		printf $C_RED"  Fatal error: moulitest cannot compile (see details)"$C_CLEAR
	else
		RET0=`cat -e .mymoulitest | grep FAIL`
		if [ "$RET0" != "" ]
		then
			TOTAL=`echo "$RET0" | wc -l | sed 's/ //g'`
			printf $C_RED"  $TOTAL failed test(s)"$C_CLEAR
		else
			printf $C_GREEN"  All Unit Tests passed"$C_CLEAR
		fi
		RET0=`cat -e .mymoulitest | sed 's/\^\[\[[0-9;]*m//g' | sed 's/\^\[\[0m//g' | sed 's/\$$//'`
		echo "$RET0" > "$RETURNPATH"/.mymoulitest
	fi
}

function check_libft_static
{
	local RET0 TOTAL
	RET0=`check_statics "$MYPATH" | tee .mystatic`
	TOTAL=`echo "$RET0" | wc -l | sed 's/ //g'`
	if [ "$RET0" == "" ]
	then
		printf $C_GREEN"  All auxiliary functions are declared as static"$C_CLEAR
	else
		if [ "$RET0" == "Files not found" ]
		then
			printf $C_RED"  Files not found"$C_CLEAR
		else
			printf $C_RED"  $TOTAL warning(s)"$C_CLEAR
		fi
	fi
}

function check_statics
{
	local TOTAL
	TOTAL=$(ls -1 $1 | sed '/^\.\/\./d' | grep -E \\.\[c\]$ | grep -E ^ft_)
	if [ "$TOTAL" == "" ]
	then
		printf "Files not found"
	else
		for i in $(ls -1 $1 | sed '/^\.\/\./d' | grep -E \\.\[c\]$)
		do
			FILEN=$i
			FILEPATH=$1"/"$i
			awk -v FILEN="$FILEN" 'BEGIN \
    	{ \
        	OFS = ""
	        sub(/\.c/, "", FILEN)
	    } \
    	$0 ~ /^[a-z_]+[	 ]+\**[a-z_]*\(.*/ \
	    { \
    	    gsub (/^[a-z_]*[	 ]+\**/, "")
        	gsub (/ *\(.*$/, "")
	        if ($1 != FILEN) \
    	    { \
        	    print FILENAME, " (ligne ", NR, ") : ", $0, "() should be declared as static" \
	        } \
    	}' $FILEPATH
		done
	fi
}

function check_norme_recursively
{
	check_norme_dir "$1" "$2"
    for i in $(ls -1F $1 | grep '/$')
    do
		DIRPATH=$1"/"$i
#		check_norme_dir "$DIRPATH" "$2"
		check_norme_recursively "$DIRPATH" "$2"
	done
}

function check_norme_dir
{
	ERRORS=""
	for i in $(ls -1 "$1" | grep '\.[ch]$')
	do
		FILEN=$i
		FILEPATH=$1"/"$i
		RESULT=$(check_norme "$FILEPATH")
		if [ "$RESULT" != "" ]
		then
			ERRORS=1
			printf "$RESULT" | sed -e 's/^[ ]*//'
		fi
	done
	if [ "$ERRORS" == "" ]
	then
		if [ "$2" != "" ]
		then
			echo "$2: \033[0;32mOK\033[m";
		else
			echo "$1: \033[0;32mOK\033[m";
		fi
	fi
}

function check_norme_file
{
    RESULT=$(check_norme "$1")
    if [ "$RESULT" != "" ]
    then
        printf "$RESULT" | sed -e 's/^[ ]*//'
	else
        if [ "$2" != "" ]
        then
            echo "$2: \033[0;32mOK\033[m";
        else
            echo "\033[0;32mOK\033[m";
        fi
    fi
}

function check_norme0
{
	norminette $1 | \
		sed "/Norme:/d" | \
		sed "/Norminette can't check this file/d" | \
		awk -v FILEPATH="$1" 'BEGIN \
		{ \
		OFS = "" \
		} \
		{ \
			if ( $0 != "" )
				print FILEPATH, " : \033[31m", $0, "\033[0m " \
		}'
}

function check_libft
{
	local MYPATH
	MYPATH=$(get_config "libft")
	display_header
	display_righttitle ""
	check_libft_top "$MYPATH"
	if [ -d "$MYPATH" ]
	then
		display_menu\
            ""\
			check_libft_all "check it!"\
			config_libft "change path"\
			main "BACK TO MAIN MENU"
	else
		display_menu\
			""\
			config_libft "configure"\
			main "BACK TO MAIN MENU"
	fi
}

function config_libft
{
	local AB0 AB2 MYPATH
	MYPATH=$(get_config "libft")
	display_header
	display_righttitle ""
	check_libft_top "$MYPATH"
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
		check_libft_top
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
	save_config "libft" "$AB2"
	printf $C_CLEAR
	check_libft
}

function check_libft_sum
{
	local MYPATH MYMENU i
	MYPATH=$(get_config "libft")
	configure_moulitest "libft" "$MYPATH"
	display_header
	display_righttitle "LIBFT"
	check_libft_top "$MYPATH"
	i=0
	while [ "${CHK_LIBFT[$i]}" != "" ]
    do
		MYMENU="${MYMENU} \""${CHK_LIBFT[$i]}"\""
        (( i += 1 ))
		MYMENU="${MYMENU} \""${CHK_LIBFT[$i]}"\""
        (( i += 1 ))
	done
    display_menu "" "${CHK_LIBFT[@]}" "check_libft" "BACK TO CONFIG" "main" "BACK TO MAIN MENU"

}

function check_libft_top
{
	printf "$C_GREY"
    display_center "LIBFT"
    printf "\n"$C_CLEAR
	if [ "$1" != "" ]
	then
		printf "  "$C_WHITE"Current configuration:$C_CLEAR\n  $1\n\n"
	fi
}

fi;