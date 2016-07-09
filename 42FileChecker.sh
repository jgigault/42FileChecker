#!/bin/bash

####################################################################
#  _  _  ____  _____ _ _       ____ _               _              #
# | || ||___ \|  ___(_) | ___ / ___| |__   ___  ___| | _____ _ __  #
# | || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ __| |/ / _ \ '__| #
# |__   _/ __/|  _| | | |  __/ |___| | | |  __/ (__|   <  __/ |    #
#    |_||_____|_|   |_|_|\___|\____|_| |_|\___|\___|_|\_\___|_|    #
#    jgigault @ student.42.fr                    06 51 15 98 82    #
####################################################################


function check_install_dir
{
	local SOURCE="${BASH_SOURCE[0]}"
	local DIR
	while [ -h "${SOURCE}" ]
	do
		DIR="$(cd -P "$(dirname "${SOURCE}")" && pwd)"
		SOURCE="$(readlink "${SOURCE}")"
		[[ "${SOURCE}" != /* ]] && SOURCE="${DIR}/${SOURCE}"
	done
	printf "%s" "$(cd -P "$(dirname "${SOURCE}")" && pwd)"
}

GLOBAL_ENTRYPATH=$(pwd)
GLOBAL_INSTALLDIR=$(check_install_dir)
GLOBAL_LOCALBRANCH=$(git branch | awk '$0 ~ /^\*/ {print $2; exit}')
cd "${GLOBAL_INSTALLDIR}"

FILECHECKER_SH=1
if [ ! -f .myrev ]; then git shortlog -s | awk 'BEGIN {rev=0} {rev+=$1} END {printf rev}' > .myrev 2>/dev/null; fi
GLOBAL_CVERSION=$(git log --oneline 2>/dev/null | awk 'END {print NR}')
if [ "${GLOBAL_CVERSION}" == "" ]; then GLOBAL_CVERSION="???"; fi
RETURNPATH=$(pwd | sed 's/ /\ /g')
OPT_NO_UPDATE=0
OPT_NO_COLOR=0
OPT_NO_TIMEOUT=0
OPT_NO_NORMINETTE=0
OPT_NO_AUTEUR=0
OPT_NO_MOULITEST=0
OPT_NO_LIBFTUNITTEST=0
OPT_NO_FILLITCHECKER=0
OPT_NO_MAINTEST=0
OPT_NO_42SHELLTESTER=0
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
	case "${!i}" in
		"--no-update") OPT_NO_UPDATE=1 ;;
		"--no-color") OPT_NO_COLOR=1 ;;
		"--no-timeout") OPT_NO_TIMEOUT=1 ;;
		"--no-norminette") OPT_NO_NORMINETTE=1 ;;
		"--no-auteur") OPT_NO_AUTEUR=1 ;;
		"--no-moulitest") OPT_NO_MOULITEST=1 ;;
		"--no-libftunittest") OPT_NO_LIBFTUNITTEST=1 ;;
		"--no-fillitchecker") OPT_NO_FILLITCHECKER=1 ;;
		"--no-maintest") OPT_NO_MAINTEST=1 ;;
		"--no-42shelltester") OPT_NO_42SHELLTESTER=1 ;;
		"--no-speedtest") OPT_NO_SPEEDTEST=1 ;;
		"--no-leaks") OPT_NO_LEAKS=1 ;;
		"--no-basictests") OPT_NO_BASICTESTS=1 ;;
		"--no-makefile") OPT_NO_MAKEFILE=1 ;;
		"--no-forbidden") OPT_NO_FORBIDDEN=1 ;;
		"--no-staticdeclarations") OPT_NO_STATICDECLARATIONS=1 ;;
		"--no-libftfilesexists") OPT_NO_LIBFTFILESEXIST=1 ;;
		"--no-gnlmultiplefd") OPT_NO_GNLMULTIPLEFD=1 ;;
		"--no-gnlonestatic") OPT_NO_GNLONESTATIC=1 ;;
		"--no-gnlmacro") OPT_NO_GNLMACRO=1 ;;
	esac
	(( i += 1 ))
done

source includes/utils/utils_authorized_functions.sh
source includes/utils.sh
source includes/utils_fileexists.sh
source includes/auteur.sh
source includes/projects/minishell/minishell_main.sh
source includes/projects/fillit/fillit_main.sh
source includes/projects/generic_tests/generic_tests_main.sh
source includes/libft.sh
source includes/libftasm.sh
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
source includes/configure.sh
source includes/moulitest.sh
source includes/external_repositories/external_repository_fillit_checker.sh
source includes/libftunittest.sh
source includes/external_repository_maintest.sh
source includes/external_repositories/external_repository_42shelltester.sh
source includes/exit.sh
source includes/display_spinner.sh
source includes/display_menu.sh
source includes/display_header.sh
source includes/display_center.sh
source includes/display_top.sh
source includes/display_leftandright.sh
source includes/display_error.sh
source includes/display_success.sh
source includes/signals.sh

function main
{
	tput civis
	display_header
	printf "\n"
	printf "${C_INVERTRED}"
	display_center " "
	display_center "Failing tests does not necessary mean you're wrong!"
	display_center "42FileChecker does not substitute a corrector"
	display_center "and was not made for that in the first place!"
	display_center " "
	printf "\n"
	display_menu\
		""\
		check_generic_tests_main "generic tests"\
		"_"\
		check_fillit_main "project: fillit"\
		check_libft_main "project: libft"\
		check_libftasm "project: libftasm"\
		check_gnl_main "project: get_next_line"\
		check_ft_ls_main "project: ft_ls"\
		check_ft_printf_main "project: ft_printf"\
		check_project_minishell_main "project: minishell (beta)"\
		"_"\
		"check_option_set OPT_NO_TIMEOUT" "option: $(if [ "$OPT_NO_TIMEOUT" == 0 ]; then echo "disable timeout      (--no-timeout)"; else echo "enable timeout"; fi)"\
		"check_option_set OPT_NO_COLOR" "option: $(if [ "$OPT_NO_COLOR" == 0 ]; then echo "disable color        (--no-color)"; else echo "enable color"; fi)"\
		"check_option_set OPT_NO_NORMINETTE" "option: $(if [ "$OPT_NO_NORMINETTE" == 0 ]; then echo "disable norminette   (--no-norminette)"; else echo "enable norminette"; fi)"\
		"check_option_set OPT_NO_LEAKS" "option: $(if [ "$OPT_NO_LEAKS" == 0 ]; then echo "disable leaks test   (--no-leaks)"; else echo "enable leaks test"; fi)"\
		"check_option_set OPT_NO_SPEEDTEST" "option: $(if [ "$OPT_NO_SPEEDTEST" == 0 ]; then echo "disable speedtest    (--no-speedtest)"; else echo "enable speedtest"; fi)"\
		"_"\
		"open https://github.com/jgigault/42FileChecker/wiki" "MANUAL"\
		display_credits "CREDITS"\
		"open https://github.com/jgigault/42FileChecker/issues/new" "REPORT A BUG"\
		exit_checker "EXIT"
}

tput civis
tput smcup
check_set_env
check_set_colors
catch_signals
display_header_transition
check_update
exit_checker
