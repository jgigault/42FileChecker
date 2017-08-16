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
GLOBAL_CONF_PATH=
GLOBAL_CONF_PROJECT=
GLOBAL_IS_INTERACTIVE="1"
GLOBAL_EXIT_STATUS="0"
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
OPT_NO_DISCLAIMER=0

i=1
while (( i <= $# ))
do
  case "${!i}" in
    "--path")
      (( i += 1 ))
      GLOBAL_CONF_PATH="${!i}"
      ;;
    "--project")
      (( i += 1 ))
      GLOBAL_CONF_PROJECT="${!i}"
      ;;
    "--no-update") OPT_NO_UPDATE=1 ;;
    "--no-color") OPT_NO_COLOR=1 ;;
    "--no-timeout") OPT_NO_TIMEOUT=1 ;;
    "--no-norminette") OPT_NO_NORMINETTE=1 ;;
    "--no-auteur") OPT_NO_AUTEUR=1 ;;
    "--no-author") OPT_NO_AUTEUR=1 ;;
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
    "--no-disclaimer") OPT_NO_DISCLAIMER=1 ;;
  esac
  (( i += 1 ))
done

[ "${GLOBAL_CONF_PATH}" != "" -a "${GLOBAL_CONF_PROJECT}" != "" ] && GLOBAL_IS_INTERACTIVE="0"

source includes/utils/utils.sh
source includes/utils/utils_auteur.sh
source includes/utils/utils_authorized_functions.sh
source includes/utils/utils_configure.sh
source includes/utils/utils_exit.sh
source includes/utils/utils_fileexists.sh
source includes/utils/utils_forbidden_functions.sh
source includes/utils/utils_launch_tests.sh
source includes/utils/utils_leaks.sh
source includes/utils/utils_makefile.sh
source includes/utils/utils_norme.sh
source includes/utils/utils_signals.sh
source includes/utils/utils_speedtest.sh
source includes/utils/utils_update.sh
source includes/display/display_center.sh
source includes/display/display_credits.sh
source includes/display/display_error.sh
source includes/display/display_header.sh
source includes/display/display_leftandright.sh
source includes/display/display_menu.sh
source includes/display/display_spinner.sh
source includes/display/display_splash_screen.sh
source includes/display/display_success.sh
source includes/display/display_top.sh
source includes/external_repositories/external_repository_42shelltester.sh
source includes/external_repositories/external_repository_fillit_checker.sh
source includes/external_repositories/external_repository_libftunittest.sh
source includes/external_repositories/external_repository_maintest.sh
source includes/external_repositories/external_repository_moulitest.sh
source includes/projects/fillit/fillit_main.sh
source includes/projects/ft_ls/ft_ls_main.sh
source includes/projects/ft_printf/ft_printf_main.sh
source includes/projects/generic_tests/generic_tests_main.sh
source includes/projects/gnl/get_next_line_main.sh
source includes/projects/libft/libft_main.sh
source includes/projects/libftasm/libftasm_main.sh
source includes/projects/minishell/minishell_main.sh
source includes/main.sh

tput civis
[ "${GLOBAL_IS_INTERACTIVE}" == "1" ] && tput smcup
check_set_env
check_set_colors
catch_signals
display_splash_screen
utils_update
[ "${?}" == "0" ] && main
utils_exit
