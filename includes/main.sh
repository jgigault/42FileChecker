#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function main_disclaimer
  {
    if [ "${GLOBAL_IS_INTERACTIVE}" == "0" ]
    then
      echo
      display_leftandright "${C_WHITE}" "" "${C_WHITE}" "  42FILECHECKER" "NON-INTERACTIVE MODE  "
      save_config "${GLOBAL_CONF_PROJECT}" "${GLOBAL_CONF_PATH}"
      eval "check_project_${GLOBAL_CONF_PROJECT}_main"
      return
    fi
    if [ "${GLOBAL_CONF_PROJECT}" != "" ]
    then
      local SELECTED_PROJECT="${GLOBAL_CONF_PROJECT}"
      GLOBAL_CONF_PROJECT=""
      eval "check_project_${SELECTED_PROJECT}_main"
      return
    fi
    [ "${OPT_NO_DISCLAIMER}" != "0" ] && main && return
    display_header "${C_INVERTRED}"
    printf "${C_INVERTRED}\n"
    display_center " "
    display_center "DISCLAIMER"
    display_center "I am looking for serious and motivated volunteers"
    display_center "to take over the maintenance of the FileChecker."
    display_center "I am planning to leave 42 on january 2017 and wish"
    display_center "someone to take the opportunity being the maintainer"
    display_center "and to keep the script alive. Please contact me."
    display_center "If you don't have great skills in Shell scripting,"
    display_center "I will spend time to train you."
    display_center " "
    printf "\n"
    display_menu\
      "${C_INVERTRED}"\
      main "OK"
  }

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
      check_project_fillit_main "project: fillit"\
      check_project_libft_main "project: libft"\
      check_project_libftasm_main "project: libftasm"\
      check_project_gnl_main "project: get_next_line"\
      check_project_ft_ls_main "project: ft_ls"\
      check_project_ft_printf_main "project: ft_printf"\
      check_project_minishell_main "project: minishell (beta)"\
      "_"\
      "check_option_set OPT_NO_TIMEOUT" "option: $(if [ "$OPT_NO_TIMEOUT" == 0 ]; then echo "disable timeout      (--no-timeout)"; else echo "enable timeout"; fi)"\
      "check_option_set OPT_NO_COLOR" "option: $(if [ "$OPT_NO_COLOR" == 0 ]; then echo "disable color        (--no-color)"; else echo "enable color"; fi)"\
      "check_option_set OPT_NO_NORMINETTE" "option: $(if [ "$OPT_NO_NORMINETTE" == 0 ]; then echo "disable norminette   (--no-norminette)"; else echo "enable norminette"; fi)"\
      "check_option_set OPT_NO_LEAKS" "option: $(if [ "$OPT_NO_LEAKS" == 0 ]; then echo "disable leaks test   (--no-leaks)"; else echo "enable leaks test"; fi)"\
      "check_option_set OPT_NO_SPEEDTEST" "option: $(if [ "$OPT_NO_SPEEDTEST" == 0 ]; then echo "disable speedtest    (--no-speedtest)"; else echo "enable speedtest"; fi)"\
      "_"\
      display_credits "CREDITS"\
      "open https://github.com/jgigault/42FileChecker/issues/new" "REPORT A BUG"\
      utils_exit "EXIT"
  }

fi
