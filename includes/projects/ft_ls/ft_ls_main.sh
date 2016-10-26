#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  declare CONF_FT_LS_NAME="ft_ls"
  declare CONF_FT_LS_DISPLAYNAME="FT_LS"
  declare CONF_FT_LS_FUNCTIONMAIN="check_project_ft_ls"
  declare CONF_FT_LS_FUNCTIONTESTALL="check_project_ft_ls_all"
  declare CONF_FT_LS_AUTHORFILE="mandatory"
  declare CONF_FT_LS_TESTS="CHK_FT_LS"
  declare CONF_FT_LS_FORBIDDENFUNCS="CHK_FT_LS_AUTHORIZED_FUNCS"

  declare -a CHK_FT_LS='( "check_author" "author file" "check_norme" "norminette" "check_ft_ls_makefile" "makefile" "check_ft_ls_forbidden_func" "forbidden functions" "check_ft_ls_leaks" "leaks" "check_ft_ls_speedtest" "speed test" "check_ft_ls_moulitest" "moulitest (${MOULITEST_URL})" "check_ft_ls_extrep_maintest" "Maintest (${EXTERNAL_REPOSITORY_MAINTEST_URL})" )'

  function check_project_ft_ls_main
  {
    local LOCAL_UPDATE_RETURN=""

    if [ "${OPT_NO_MOULITEST}" == "0" ]
    then
      check_update_external_repository "moulitest" "${MOULITEST_URL}" "${MOULITEST_DIR}"
      case "${LOCAL_UPDATE_RETURN}" in
        "exit") main; return ;;
      esac
    fi
    if [ "${OPT_NO_MAINTEST}" == "0" ]
    then
      check_update_external_repository "Maintest" "${EXTERNAL_REPOSITORY_MAINTEST_URL}" "${EXTERNAL_REPOSITORY_MAINTEST_DIR}"
      case "${LOCAL_UPDATE_RETURN}" in
        "exit") main; return ;;
      esac
    fi
    if [ "${GLOBAL_IS_INTERACTIVE}" == "0" ]
    then
      ${CONF_FT_LS_FUNCTIONTESTALL}
    else
      ${CONF_FT_LS_FUNCTIONMAIN}
    fi
  }

  function check_project_ft_ls
  {
    local MYPATH

    MYPATH=$(get_config "${CONF_FT_LS_NAME}")
    display_header
    display_top "${MYPATH}" "${CONF_FT_LS_DISPLAYNAME}"
    if [ -d "${MYPATH}" ]
    then
      display_menu\
        ""\
        "${CONF_FT_LS_FUNCTIONTESTALL}" "check all!"\
        "_"\
        "TESTS" "${CONF_FT_LS_TESTS}" "${CONF_FT_LS_FUNCTIONTESTALL}"\
        "_"\
        "check_configure \"${CONF_FT_LS_FUNCTIONMAIN}\" \"${CONF_FT_LS_NAME}\" \"${CONF_FT_LS_DISPLAYNAME}\"" "change path"\
        main "BACK TO MAIN MENU"
    else
      display_menu\
        ""\
        "check_configure \"${CONF_FT_LS_FUNCTIONMAIN}\" \"${CONF_FT_LS_NAME}\" \"${CONF_FT_LS_DISPLAYNAME}\"" "configure"\
        main "BACK TO MAIN MENU"
    fi
  }

  function check_project_ft_ls_all
  {
    local TESTONLY="${1}" MYPATH

    MYPATH=$(get_config "${CONF_FT_LS_NAME}")
    configure_moulitest "${CONF_FT_LS_NAME}" "${MYPATH}"
    display_header
    display_top "${MYPATH}" "${CONF_FT_LS_DISPLAYNAME}"
    utils_launch_tests "${TESTONLY}" "${CONF_FT_LS_TESTS}"
    display_menu\
      ""\
      "${CONF_FT_LS_FUNCTIONMAIN}" "OK"\
      "open .mynorminette" "more info: norminette"\
      "open .mymakefile" "more info: makefile"\
      "open .myforbiddenfunc" "more info: forbidden functions"\
      "open .myleaks" "more info: leaks"\
      "open .myspeedtest" "more info: speed test"\
      "open .mymoulitest" "more info: moulitest"\
      "open .mymaintest_ft_ls" "more info: Maintest"\
      "_"\
      "open https://github.com/jgigault/42FileChecker/issues/new" "REPORT A BUG ON 42FILECHECKER"\
      "open ${MOULITEST_URL}/issues/new" "REPORT A BUG ON MOULITEST"\
      main "BACK TO MAIN MENU"
  }

  function check_ft_ls_speedtest
  {
    local LOGFILENAME

    if [ "${OPT_NO_SPEEDTEST}" == "0" ]
    then
      LOGFILENAME=.myspeedtest
      ${CMD_RM}  -f $LOGFILENAME
      ${CMD_TOUCH} $LOGFILENAME
      check_create_tmp_dir
      make re -C "${MYPATH}" >/dev/null 2>&1
      if [ -f "${MYPATH}/ft_ls" ]
      then
        check_speedtest "$MYPATH/ft_ls" "ls" "-1lR /" "$LOGFILENAME" "Your program is compared with the original 'ls'.\n\n"
        return "${?}"
      else
        printf "%s" "Cannot compile"
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_ft_ls_leaks
  {
    local RET0 LOGFILENAME PROGNAME

    if [ "${OPT_NO_LEAKS}" == "0" ]
    then
      LOGFILENAME=".myleaks"
      ${CMD_RM} -f ${LOGFILENAME}
      ${CMD_TOUCH} ${LOGFILENAME}
      make re -C "${MYPATH}" >${LOGFILENAME} 2>&1
      if [ -f "${MYPATH}/ft_ls" ]
      then
        check_leaks "${MYPATH}/ft_ls" "-R /" "${LOGFILENAME}" ""
        return "${?}"
      else
        printf "%s" "Cannot compile"
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_ft_ls_makefile
  {
    if [ "${OPT_NO_MAKEFILE}" == "0" ]
    then
      check_makefile "${MYPATH}" ft_ls
      return "${?}"
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_ft_ls_forbidden_func
  {
    if [ "${OPT_NO_FORBIDDEN}" == "0" ]
    then
      make -C "${MYPATH}" >.myforbiddenfunc 2>&1
      if [ -f "${MYPATH}/ft_ls" ]
      then
        check_forbidden_func "${CONF_FT_LS_FORBIDDENFUNCS}" "${MYPATH}/ft_ls"
        return "${?}"
      else
        printf "%s" "Cannot compile"
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_ft_ls_moulitest
  {
    if [ "${OPT_NO_MOULITEST}" == "0" ]
    then
      check_moulitest "ft_ls"
      return "${?}"
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_ft_ls_extrep_maintest
  {
    if [ "${OPT_NO_MAINTEST}" == "0" ]
    then
      check_maintest_ft_ls ".mymaintest_ft_ls" "${MYPATH}"
      return "${?}"
    fi
    printf "%s" "Not performed"
    return 255
  }

fi
