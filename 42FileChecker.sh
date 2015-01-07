#!/bin/bash

####################################################################
#  _  _  ____  _____ _ _       ____ _               _              #
# | || ||___ \|  ___(_) | ___ / ___| |__   ___  ___| | _____ _ __  #
# | || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ __| |/ / _ \ '__| #
# |__   _/ __/|  _| | | |  __/ |___| | | |  __/ (__|   <  __/ |    #
#    |_||_____|_|   |_|_|\___|\____|_| |_|\___|\___|_|\_\___|_|    #
#    jgigault @ student.42.fr                    06 51 15 98 82    #
####################################################################

FILECHECKER_SH=1
RETURNPATH=$(pwd | sed 's/ /\ /g')
OPT_NO_UPDATE=0
OPT_NO_COLOR=0
OPT_NO_TIMEOUT=0
OPT_NO_NORMINETTE=0
OPT_NO_AUTEUR=0
OPT_NO_MOULITEST=0
OPT_NO_SPEEDTEST=0
OPT_NO_LEAKS=0
OPT_NO_BASICTESTS=0
OPT_NO_MAKEFILE=0
OPT_NO_FORBIDDEN=0
OPT_NO_STATICDECLARATIONS=0
OPT_NO_LIBFTFILESEXIST=0
OPT_NO_GNLMULTIPLEFD=0
OPT_NO_GNLONESTATIC=0
OPT_NO_GNLMACRO=0

i=1
while (( i <= $# ))
do
	if [ "${!i}" == "--no-update" ]
	then
		OPT_NO_UPDATE=1
	fi
	if [ "${!i}" == "--no-color" ]
	then
		OPT_NO_COLOR=1
	fi
	if [ "${!i}" == "--no-timeout" ]
	then
		OPT_NO_TIMEOUT=1
	fi
	if [ "${!i}" == "--no-norminette" ]
	then
		OPT_NO_NORMINETTE=1
	fi
	if [ "${!i}" == "--no-auteur" ]
	then
		OPT_NO_AUTEUR=1
	fi
	if [ "${!i}" == "--no-moulitest" ]
	then
		OPT_NO_MOULITEST=1
	fi
	if [ "${!i}" == "--no-speedtest" ]
	then
		OPT_NO_SPEEDTEST=1
	fi
	if [ "${!i}" == "--no-leaks" ]
	then
		OPT_NO_LEAKS=1
	fi
	if [ "${!i}" == "--no-basictests" ]
	then
		OPT_NO_BASICTESTS=1
	fi
	if [ "${!i}" == "--no-makefile" ]
	then
		OPT_NO_MAKEFILE=1
	fi
	if [ "${!i}" == "--no-forbidden" ]
	then
		OPT_NO_FORBIDDEN=1
	fi
	if [ "${!i}" == "--no-staticdeclarations" ]
	then
		OPT_NO_STATICDECLARATIONS=1
	fi
	if [ "${!i}" == "--no-libftfilesexists" ]
	then
		OPT_NO_LIBFTFILESEXIST=1
	fi
	if [ "${!i}" == "--no-gnlmultiplefd" ]
	then
		OPT_NO_GNLMULTIPLEFD=1
	fi
	if [ "${!i}" == "--no-gnlonestatic" ]
	then
		OPT_NO_GNLONESTATIC=1
	fi
	if [ "${!i}" == "--no-gnlmacro" ]
	then
		OPT_NO_GNLMACRO=1
	fi
	(( i += 1 ))
done

source includes/utils.sh
source includes/libft.sh
source includes/get_next_line.sh
source includes/ft_ls.sh
source includes/ft_printf.sh
source includes/transition.sh
source includes/update.sh
source includes/credits.sh
source includes/forbidden.sh
source includes/makefile.sh
source includes/leaks.sh
source includes/speedtest.sh

function main
{
	tput civis
	display_header
	display_righttitle ""
	display_menu\
		""\
		check_libft "libft"\
		check_gnl "get_next_line"\
		check_ft_ls "ft_ls"\
		check_ft_printf "ft_printf"\
		display_credits "CREDITS"\
		"open https://github.com/jgigault/42FileChecker/issues/new" "REPORT A BUG"\
		exit_checker "EXIT"
}

display_header_transition
if [ "$OPT_NO_UPDATE" == "0" ]
then
	update
fi
main