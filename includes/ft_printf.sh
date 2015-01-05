#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then


declare -a CHK_FT_PRINTF='( "check_author" "auteur" "check_norme" "norminette" "check_ft_printf_makefile" "makefile" "check_ft_printf_forbidden_func" "forbidden functions" "check_ft_printf_moulitest" "moulitest (yyang@student.42.fr)" )'

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
		RET0=`cat .myret`
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
		"open .mymoulitest" "see details: moulitest"
}

function check_ft_printf_makefile
{
	local MYPATH
	MYPATH=$(get_config "ft_printf")
	check_makefile "$MYPATH" libftprintf.a
}

function check_ft_printf_forbidden_func
{
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
{
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