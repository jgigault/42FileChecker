#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  declare CONF_MINISHELL_NAME="minishell"
  declare CONF_MINISHELL_DISPLAYNAME="MINISHELL (beta)"
  declare CONF_MINISHELL_FUNCTIONMAIN="check_project_minishell"
  declare CONF_MINISHELL_FUNCTIONTESTALL="check_project_minishell_all"
  declare CONF_MINISHELL_AUTHORFILE="mandatory"
  declare CONF_MINISHELL_TESTS="CHK_MINISHELL"
  declare CONF_MINISHELL_FORBIDDENFUNCS="CHK_MINISHELL_AUTHORIZED_FUNCS"

  declare -a CHK_MINISHELL='( "check_author" "author file" "check_norme" "norminette" "check_project_minishell_makefile" "makefile" "check_project_minishell_forbidden_func" "forbidden functions" "check_project_minishell_42shelltester minishell/builtins/ builtins" "42ShellTester: implementation of built-in utilities" "check_project_minishell_42shelltester minishell/binary/ binary" "42ShellTester: execution of binaries" "check_project_minishell_42shelltester minishell/misc/ miscellaneous" "42ShellTester: miscellaneous" )'

  function check_project_minishell_main
  {
    local LOCAL_UPDATE_RETURN=""

    if [ "${OPT_NO_42SHELLTESTER}" == "0" ]
    then
      check_update_external_repository "42ShellTester" "${EXTERNAL_REPOSITORY_42SHELLTESTER_URL}" "${EXTERNAL_REPOSITORY_42SHELLTESTER_DIR}"
      case "${LOCAL_UPDATE_RETURN}" in
        "exit") main; return ;;
      esac
    fi
    if [ "${GLOBAL_IS_INTERACTIVE}" == "0" ]
    then
      ${CONF_MINISHELL_FUNCTIONTESTALL}
    else
      ${CONF_MINISHELL_FUNCTIONMAIN}
    fi
  }

  function check_project_minishell
  {
    local MYPATH="$(get_config "${CONF_MINISHELL_NAME}")"

    display_header
    display_top "${MYPATH}" "${CONF_MINISHELL_DISPLAYNAME}"
    display_center "Tests for Shell projects are provided by the script 42ShellTester:"
    display_center "${EXTERNAL_REPOSITORY_42SHELLTESTER_URL}"
    display_center "Feel free to visit and help us improving the project!"
    printf "\n"
    if [ -d "${MYPATH}" ]
    then
      display_menu\
        ""\
        "${CONF_MINISHELL_FUNCTIONTESTALL}" "check all!"\
        "_"\
        "TESTS" "${CONF_MINISHELL_TESTS}" "${CONF_MINISHELL_FUNCTIONTESTALL}"\
        "_"\
        "open ${EXTERNAL_REPOSITORY_42SHELLTESTER_URL}" "VISIT THE PROJECT 42SHELLTESTER"\
        "_"\
        "check_configure ${CONF_MINISHELL_FUNCTIONMAIN} ${CONF_MINISHELL_NAME} \"${CONF_MINISHELL_DISPLAYNAME}\" ${CONF_MINISHELL_AUTHORFILE}" "change path"\
        "main" "BACK TO MAIN MENU"
    else
      display_menu\
        ""\
        "check_configure ${CONF_MINISHELL_FUNCTIONMAIN} ${CONF_MINISHELL_NAME} \"${CONF_MINISHELL_DISPLAYNAME}\" ${CONF_MINISHELL_AUTHORFILE}" "configure"\
        "main" "BACK TO MAIN MENU"
    fi
  }

  function check_project_minishell_all
  {
    local TESTONLY="${1}" MYPATH

    MYPATH="$(get_config "${CONF_MINISHELL_NAME}")"
    display_header
    display_top "${MYPATH}" "${CONF_MINISHELL_DISPLAYNAME}"
    utils_launch_tests "${TESTONLY}" "${CONF_MINISHELL_TESTS}"
    display_menu\
      ""\
      "${CONF_MINISHELL_FUNCTIONMAIN}" "OK"\
      "open .mynorminette" "more info: norminette"\
      "open .mymakefile" "more info: makefile"\
      "open .myforbiddenfunc" "more info: forbidden functions"\
      "open .my42shelltester_minishell_builtins" "more info: implementation of built-in utilities"\
      "open .my42shelltester_minishell_binary" "more info: execution of binaries"\
      "open .my42shelltester_minishell_miscellaneous" "more info: miscellaneous"\
      "_"\
      "open ${EXTERNAL_REPOSITORY_42SHELLTESTER_URL}" "VISIT THE PROJECT 42SHELLTESTER"\
      "_"\
      "open https://github.com/jgigault/42FileChecker/issues/new" "REPORT A BUG ON 42FILECHECKER"\
      "open ${EXTERNAL_REPOSITORY_42SHELLTESTER_URL}/issues/new" "REPORT A BUG ON 42SHELLTESTER"\
      "main" "BACK TO MAIN MENU"
  }

  function check_project_minishell_makefile
  {
    if [ "${OPT_NO_MAKEFILE}" == "0" ]
    then
      check_makefile "${MYPATH}" "${CONF_MINISHELL_NAME}"
      return "${?}"
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_project_minishell_forbidden_func
  {
    if [ "${OPT_NO_FORBIDDEN}" == "0" ]
    then
      make -C "${MYPATH}" >.myforbiddenfunc 2>&1
      if [ -f "${MYPATH}/${CONF_MINISHELL_NAME}" ]
      then
        check_forbidden_func "${CONF_MINISHELL_FORBIDDENFUNCS}" "${MYPATH}/${CONF_MINISHELL_NAME}"
        return "${?}"
      else
        printf "%s" "Executable not found: '${CONF_MINISHELL_NAME}'"
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_project_minishell_42shelltester
  {
    local FILTER="${1}" LOGFILENAMESUFFIX="${2}"
    local LOGFILENAME=".my42shelltester_minishell_${LOGFILENAMESUFFIX}"

    if [ "${OPT_NO_42SHELLTESTER}" == "0" ]
    then
      ${CMD_RM} -f "${LOGFILENAME}"
      make re -C "${MYPATH}" >"${LOGFILENAME}" 2>&1
      if [ -f "${MYPATH}/${CONF_MINISHELL_NAME}" ]
      then
        check_external_repository_42shelltester "${LOGFILENAME}" "${MYPATH}/${CONF_MINISHELL_NAME}" "${FILTER}"
        return "${?}"
      else
        printf "%s" "Executable not found: '${CONF_MINISHELL_NAME}'"
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

fi
