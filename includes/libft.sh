#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then


declare -a CHK_LIBFT='( "check_author" "auteur" "check_libft_required_exists" "required functions" "check_libft_bonus_exists" "bonus" "check_libft_extra" "extra functions" "check_norme" "norminette" "check_libft_static" "static declarations" "check_libft_makefile" "makefile" "check_libft_forbidden_func" "forbidden functions" "check_libft_moulitest" "moulitest (yyang@student.42.fr)" )'

declare -a LIBFT_MANDATORIES='(libft.h ft_strcat.c ft_strncat.c ft_strlcat.c ft_strchr.c ft_strnstr.c ft_strrchr.c ft_strclr.c ft_strcmp.c ft_strncmp.c ft_strcpy.c ft_strncpy.c ft_strdel.c ft_strdup.c ft_strequ.c ft_strnequ.c ft_striter.c ft_striteri.c ft_strjoin.c ft_strlen.c ft_strmap.c ft_strmapi.c ft_strnew.c ft_strstr.c ft_strsplit.c ft_strsub.c ft_strtrim.c ft_atoi.c ft_itoa.c ft_tolower.c ft_toupper.c ft_putchar.c ft_putchar_fd.c ft_putstr.c ft_putstr_fd.c ft_putnbr.c ft_putnbr_fd.c ft_putendl.c ft_putendl_fd.c ft_isalnum.c ft_isalpha.c ft_isascii.c ft_isdigit.c ft_isprint.c ft_memalloc.c ft_memchr.c ft_memcmp.c ft_memcpy.c ft_memccpy.c ft_memdel.c ft_memmove.c ft_memset.c ft_bzero.c)'

declare -a LIBFT_BONUS='(ft_lstnew.c ft_lstdelone.c ft_lstdel.c ft_lstiter.c ft_lstadd.c ft_lstmap.c)'

declare -a LIBFT_EXTRA='()'

declare -a CHK_LIBFT_AUTHORIZED_FUNCS='(free malloc write main)'

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
		RET0=`cat .myret | sed 's/%/%%/g'`
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
		"open .mymakefile" "see details: makefile"\
		"open .myforbiddenfunc" "see details: forbidden functions"\
		"open .mymoulitest" "see details: moulitest"
}

function check_libft_makefile
{	if [ "$OPT_NO_MAKEFILE" == "0" ]; then
	local MYPATH
	MYPATH=$(get_config "libft")
	check_makefile "$MYPATH" libft.a
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_libft_bonus_exists
{	if [ "$OPT_NO_LIBFTFILESEXIST" == "0" ]; then
	check_fileexists LIBFT_BONUS
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_libft_required_exists
{	if [ "$OPT_NO_LIBFTFILESEXIST" == "0" ]; then
	check_fileexists LIBFT_MANDATORIES
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_libft_forbidden_func
{	if [ "$OPT_NO_FORBIDDEN" == "0" ]; then
	local F
	if [ -f "$MYPATH/Makefile" ]
	then
		FILEN=forbiddenfuncs
		F=$RETURNPATH/tmp/$FILEN.c
		LIBFTH=`find $MYPATH -name libft.h`
		check_create_tmp_dir
		echo "#define NULL ((void *)0)\n#include \"$LIBFTH\"\nint main(void) {" > $F
		echo "ft_putstr(NULL);" >> $F
		echo "ft_memset(NULL, 0, 0);" >> $F
		echo "ft_bzero(NULL, 0);" >> $F
		echo "ft_memcpy(NULL, NULL, 0);" >> $F
		echo "ft_memccpy(NULL, NULL, 0, 0);" >> $F
		echo "ft_memmove(NULL, NULL, 0);" >> $F
		echo "ft_memchr(NULL, 0, 0);" >> $F
		echo "ft_memcmp(NULL, NULL, 0);" >> $F
		echo "ft_strlen(NULL);" >> $F
		echo "ft_strdup(NULL);" >> $F
		echo "ft_strcpy(NULL, NULL);" >> $F
		echo "ft_strncpy(NULL, NULL, 0);" >> $F
		echo "ft_strcat(NULL, NULL);" >> $F
		echo "ft_strncat(NULL, NULL, 0);" >> $F
		echo "ft_strlcat(NULL, NULL, 0);" >> $F
		echo "ft_strchr(NULL, 0);" >> $F
		echo "ft_strrchr(NULL, 0);" >> $F
		echo "ft_strstr(NULL, NULL);" >> $F
		echo "ft_strnstr(NULL, NULL, 0);" >> $F
		echo "ft_strcmp(NULL, NULL);" >> $F
		echo "ft_strncmp(NULL, NULL, 0);" >> $F
		echo "ft_atoi(NULL);" >> $F
		echo "ft_isalpha(0);" >> $F
		echo "ft_isdigit(0);" >> $F
		echo "ft_isalnum(0);" >> $F
		echo "ft_isascii(0);" >> $F
		echo "ft_isprint(0);" >> $F
		echo "ft_toupper(0);" >> $F
		echo "ft_tolower(0);" >> $F
		echo "ft_memalloc(0);" >> $F
		echo "ft_memdel(NULL);" >> $F
		echo "ft_strnew(0);" >> $F
		echo "ft_strdel(NULL);" >> $F
		echo "ft_strclr(NULL);" >> $F
		echo "ft_striter(NULL, NULL);" >> $F
		echo "ft_striteri(NULL, NULL);" >> $F
		echo "ft_strmap(NULL, NULL);" >> $F
		echo "ft_strmapi(NULL, NULL);" >> $F
		echo "ft_strequ(NULL, NULL);" >> $F
		echo "ft_strnequ(NULL, NULL, 0);" >> $F
		echo "ft_strsub(NULL, 0, 0);" >> $F
		echo "ft_strjoin(NULL, NULL);" >> $F
		echo "ft_strtrim(NULL);" >> $F
		echo "ft_strsplit(NULL, 0);" >> $F
		echo "ft_itoa(0);" >> $F
		echo "ft_putchar(0);" >> $F
		echo "ft_putchar_fd(0, 0);" >> $F
		echo "ft_putstr(NULL);" >> $F
		echo "ft_putstr_fd(NULL, 0);" >> $F
		echo "ft_putendl(NULL);" >> $F
		echo "ft_putendl_fd(NULL, 0);" >> $F
		echo "ft_putnbr(0);" >> $F
		echo "ft_putnbr_fd(0, 0);" >> $F
		RET0=`check_fileexists LIBFT_BONUS | grep 'All files were found'`
		if [ "$RET0" != "" ]
		then
			echo "ft_lstnew(NULL, 0);" >> $F
			echo "ft_lstdelone(NULL, NULL);" >> $F
			echo "ft_lstdel(NULL, NULL);" >> $F
			echo "ft_lstadd(NULL, NULL);" >> $F
			echo "ft_lstiter(NULL, NULL);" >> $F
			echo "ft_lstmap(NULL, NULL);" >> $F
		fi
		echo "return (1); }" >> $F
		cd "$RETURNPATH"/tmp
		make re -C "$MYPATH" >/dev/null
		rm -f "$FILEN"
		RET0=`gcc "$F" -L"$MYPATH" -lft -o "$FILEN"`
		cd "$RETURNPATH"
		check_forbidden_func CHK_LIBFT_AUTHORIZED_FUNCS "./tmp/$FILEN"
	else
		printf $C_RED"  Makefile not found"$C_CLEAR
	fi
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_libft_extra
{	if [ "$OPT_NO_LIBFTFILESEXIST" == "0" ]; then
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
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
}

function check_libft_moulitest
{	if [ "$OPT_NO_MOULITEST" == "0" ]; then
	local RET0 TOTAL
	rm -f "$RETURNPATH"/.mymoulitest
	if [ -d moulitest ]
	then
		cd "$RETURNPATH"/moulitest/
		RET0=`check_fileexists LIBFT_BONUS | grep 'All files were found'`
		if [ "$RET0" == "" ]
		then
			make libft_part2 1> "$RETURNPATH"/.mymoulitest 2>&1
		else
			make libft_bonus 1> "$RETURNPATH"/.mymoulitest 2>&1
		fi
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
				RET0=`cat -e .mymoulitest | grep FAIL`
				if [ "$RET0" != "" ]
				then
					TOTAL=`echo "$RET0" | wc -l | sed 's/ //g'`
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

function check_libft_static
{
	if [ "$OPT_NO_STATICDECLARATIONS" == "0" ]; then
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
	else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
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
			awk -v FILEN="$FILEN" -v FILEN2="$FILEN" 'BEGIN \
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
        	    print FILEN2, " (ligne ", NR, ") : ", $0, "() should be declared as static" \
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
			printf $C_WHITE""
		fi
		tput cnorm
		read -p "  $HOME/" -e AB0
		tput civis
		AB0=`echo "$AB0" | sed 's/\/$//'`
		AB2="$HOME/$AB0"
	done
	cd "$RETURNPATH"
	save_config "libft" "$AB2"
	printf $C_CLEAR""
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
	local LPATH=$1
	local LHOME
	LHOME=`echo "$HOME" | sed 's/\//\\\\\\//g'`
	LPATH="echo \"$LPATH\" | sed 's/$LHOME/~/'"
	LPATH=`eval $LPATH`
	printf "$C_GREY"
    display_center "LIBFT"
    printf "\n"$C_CLEAR
	if [ "$1" != "" ]
	then
		printf "  "$C_WHITE"Current configuration:$C_CLEAR\n  $LPATH\n\n"
	fi
}

fi;