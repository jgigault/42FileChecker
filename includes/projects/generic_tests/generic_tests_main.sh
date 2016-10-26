#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  declare CONF_GENERIC_TESTS_NAME="generic_tests"
  declare CONF_GENERIC_TESTS_DISPLAYNAME="GENERIC TESTS"
  declare CONF_GENERIC_TESTS_FUNCTIONMAIN="check_generic_tests"
  declare CONF_GENERIC_TESTS_TESTS="CHK_GENERIC_TESTS"

  declare -a CHK_GENERIC_TESTS='( "check_author" "author file" "check_norme" "norminette" "check_generic_tests_makefile" "makefile" "check_generic_tests_forbidden_func" "forbidden functions" )'

  function check_generic_tests_main
  {
    check_generic_tests
  }

  function check_generic_tests
  {
    local MYPATH="$(get_config "${CONF_GENERIC_TESTS_NAME}")"

    display_header
    display_top "${MYPATH}" "${CONF_GENERIC_TESTS_DISPLAYNAME}"
    display_center "Check author file, code standard,"
    display_center "makefile rules and forbidden functions."
    printf "\n"
    if [ -d "${MYPATH}" ]
    then
      display_menu\
        ""\
        "check_generic_tests_all fdf CHK_FDF_AUTHORIZED_FUNCS FDF" "fdf"\
        "check_generic_tests_all client CHK_FT_P_AUTHORIZED_FUNCS \"FT_P (CLIENT)\"" "ft_p (client)"\
        "check_generic_tests_all serveur CHK_FT_P_AUTHORIZED_FUNCS \"FT_P (SERVEUR)\"" "ft_p (serveur)"\
        "check_generic_tests_all push_swap CHK_PUSH_SWAP_AUTHORIZED_FUNCS \"PUSH_SWAP\"" "push_swap"\
        "check_generic_tests_all checker CHK_PUSH_SWAP_AUTHORIZED_FUNCS \"PUSH_SWAP (CHECKER)\"" "push_swap (checker)"\
        "_"\
        "check_configure check_generic_tests ${CONF_GENERIC_TESTS_NAME} \"${CONF_GENERIC_TESTS_DISPLAYNAME}\"" "change path"\
        "main" "BACK TO MAIN MENU"
    else
      display_menu\
        ""\
        "check_configure check_generic_tests ${CONF_GENERIC_TESTS_NAME} \"${CONF_GENERIC_TESTS_DISPLAYNAME}\"" "change path"\
        "main" "BACK TO MAIN MENU"
    fi
  }

  function check_generic_tests_all
  {
    local SELECTED_PROJECT="${1}" SELECTED_AUTHORIZED_FUNCS="${2}" SELECTED_PROJECT_DISPLAYNAME="${3}"

    display_header
    display_top "${MYPATH}" "${SELECTED_PROJECT_DISPLAYNAME}"
    utils_launch_tests "" "${CONF_GENERIC_TESTS_TESTS}"
    display_menu\
      ""\
      "${CONF_GENERIC_TESTS_FUNCTIONMAIN}" "OK"\
      "open .mynorminette" "more info: norminette"\
      "open .mymakefile" "more info: makefile"\
      "open .myforbiddenfunc" "more info: forbidden functions"\
      "_"\
      "open https://github.com/jgigault/42FileChecker/issues/new" "REPORT A BUG ON 42FILECHECKER"\
      "main" "BACK TO MAIN MENU"
  }

  function check_generic_tests_forbidden_func
  {
    local LOGFILENAME=".myforbiddenfunc" F

    if [ "${OPT_NO_FORBIDDEN}" == "0" ]
    then
      ${CMD_RM} -f ${LOGFILENAME}
      if [ -f "${MYPATH}/Makefile" -o -f "${MYPATH}/makefile" ]
      then
        make -C "${MYPATH}" >${LOGFILENAME} 2>&1
        if [ "${?}" == "0" -a -f "${MYPATH}/${SELECTED_PROJECT}" ]
        then
          check_forbidden_func "${SELECTED_AUTHORIZED_FUNCS}" "${MYPATH}/${SELECTED_PROJECT}"
          return "${?}"
        else
          printf "%s" "Binary not found '${SELECTED_PROJECT}'"
        fi
      else
        printf "%s" "Makefile not found"
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_generic_tests_makefile
  {
    if [ "$OPT_NO_MAKEFILE" == "0" ]
    then
      check_makefile "${MYPATH}" "${SELECTED_PROJECT}"
      return "${?}"
    fi
    printf "%s" "Not performed"
    return 255
  }

fi
