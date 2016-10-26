#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  declare CONF_FILLIT_NAME="fillit"
  declare CONF_FILLIT_DISPLAYNAME="FILLIT"
  declare CONF_FILLIT_FUNCTIONMAIN="check_project_fillit"
  declare CONF_FILLIT_FUNCTIONTESTALL="check_project_fillit_all"
  declare CONF_FILLIT_AUTHORFILE="optional"
  declare CONF_FILLIT_TESTS="CHK_FILLIT"
  declare CONF_FILLIT_FORBIDDENFUNCS="CHK_FILLIT_AUTHORIZED_FUNCS"

  declare -a CHK_FILLIT='( "check_author optional" "author file" "check_norme" "norminette" "check_fillit_makefile" "makefile" "check_fillit_forbidden_func" "forbidden functions" "check_fillit_extern_file" "extern file" "check_fillit_fillitchecker" "fillit_checker (${EXTERNAL_REPOSITORY_FILLITCHECKER_URL})" )'

  function check_project_fillit_main
  {
    local LOCAL_UPDATE_RETURN=""

    if [ "${OPT_NO_FILLITCHECKER}" == "0" ]
    then
      check_update_external_repository "fillit_checker" "${EXTERNAL_REPOSITORY_FILLITCHECKER_URL}" "${EXTERNAL_REPOSITORY_FILLITCHECKER_DIR}"
      case "${LOCAL_UPDATE_RETURN}" in
        "exit") main; return ;;
      esac
    fi
    if [ "${GLOBAL_IS_INTERACTIVE}" == "0" ]
    then
      ${CONF_FILLIT_FUNCTIONTESTALL}
    else
      ${CONF_FILLIT_FUNCTIONMAIN}
    fi
  }

  function check_project_fillit
  {
    local MYPATH

    MYPATH=$(get_config "${CONF_FILLIT_NAME}")
    display_header
    display_top "${MYPATH}" "${CONF_FILLIT_DISPLAYNAME}"
    if [ -d "${MYPATH}" ]
    then
      display_menu\
        ""\
        "${CONF_FILLIT_FUNCTIONTESTALL}" "check all!"\
        "_"\
        "TESTS" "${CONF_FILLIT_TESTS}" "${CONF_FILLIT_FUNCTIONTESTALL}"\
        "_"\
        "check_configure \"${CONF_FILLIT_FUNCTIONMAIN}\" \"${CONF_FILLIT_NAME}\" \"${CONF_FILLIT_DISPLAYNAME}\" \"${CONF_FILLIT_AUTHORFILE}\"" "change path"\
        "main" "BACK TO MAIN MENU"
    else
      display_menu\
        ""\
        "check_configure \"${CONF_FILLIT_FUNCTIONMAIN}\" \"${CONF_FILLIT_NAME}\" \"${CONF_FILLIT_DISPLAYNAME}\" \"${CONF_FILLIT_AUTHORFILE}\"" "configure"\
        "main" "BACK TO MAIN MENU"
    fi
  }

  function check_project_fillit_all
  {
    local TESTONLY="${1}" MYPATH

    MYPATH=$(get_config "${CONF_FILLIT_NAME}")
    display_header
    display_top "${MYPATH}" "${CONF_FILLIT_DISPLAYNAME}"
    utils_launch_tests "${TESTONLY}" "${CONF_FILLIT_TESTS}"
    display_menu\
      ""\
      "${CONF_FILLIT_FUNCTIONMAIN}" "OK"\
      "open .mynorminette" "more info: norminette"\
      "open .mymakefile" "more info: makefile"\
      "open .myforbiddenfunc" "more info: forbidden functions"\
      "open .myexternfile" "more info: extern file"\
      "open .myfillitchecker" "more info: fillit_checker"\
      "_"\
      "open https://github.com/jgigault/42FileChecker/issues/new" "REPORT A BUG ON 42FILECHECKER"\
      "open ${EXTERNAL_REPOSITORY_FILLITCHECKER_URL}/issues/new" "REPORT A BUG ON FILLIT_CHECKER"\
      "main" "BACK TO MAIN MENU"
  }

  function check_fillit_makefile
  {
    if [ "${OPT_NO_MAKEFILE}" == "0" ]
    then
      check_makefile "${MYPATH}" "fillit"
      return "${?}"
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_fillit_forbidden_func
  {
    if [ "${OPT_NO_FORBIDDEN}" == "0" ]
    then
      make -C "${MYPATH}" >.myforbiddenfunc 2>&1
      if [ -f "${MYPATH}/fillit" ]
      then
        check_forbidden_func "${CONF_FILLIT_FORBIDDENFUNCS}" "${MYPATH}/fillit"
        return "${?}"
      else
        printf "%s" "Executable not found: 'fillit'"
        return 1
      fi
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_fillit_extern_file
  {
    local LOGFILENAME=".myexternfile" F AF HAS_AF TOTAL=0 EXTERNFILEFOUND="0" ALLOWED_FILESERRORS="" I
    local -a ALLOWED_FILES='( "extern_file.txt" "auteur" "author" )'

    ${CMD_RM} -f "${LOGFILENAME}"
    make fclean -C "${MYPATH}" &>/dev/null
    for F in $(find "${MYPATH}" -type f ! -name '*.[ch]' ! -name 'Makefile' ! -name 'makefile' ! -regex "${MYPATH}/\.git.*")
    do
      I=0
      HAS_AF="0"
      while [ "${ALLOWED_FILES[I]}" != "" ]
      do
        if [ "$(basename "${F}")" == "${ALLOWED_FILES[I]}" ]
        then
          HAS_AF="1"
          EXTERNFILEFOUND="1"
          if [ "${F}" != "${MYPATH}/${ALLOWED_FILES[I]}" ]
          then
            ALLOWED_FILESERRORS="${ALLOWED_FILESERRORS} ${F}"
          fi
        fi
        (( I += 1 ))
      done
      if [[ "${HAS_AF}" == "0" ]]
      then
        if [ "${TOTAL}" == "0" ]
        then
          echo "These extra files were found in your project directory but don't seem to be necessary to compile your project:" >"${LOGFILENAME}"
        fi
        echo "-> ${F}" >>"${LOGFILENAME}"
        (( TOTAL+=1 ))
      fi
    done
    if [ "${TOTAL}" == "0" -a "${ALLOWED_FILESERRORS}" == "" ]
    then
      if [ "${EXTERNFILEFOUND}" == "1" ]
      then
          printf "%s" "No extra file found except '${ALLOWED_FILES[@]}'"
      else
          printf "%s" "No extra file found"
      fi
      return 0
    else
      if [ "${ALLOWED_FILESERRORS}" != "" ]
      then
        if [ "${TOTAL}" != "0" ]
        then
          echo "" >>"${LOGFILENAME}"
        fi
        echo "'${ALLOWED_FILES}' must be placed at root folder but was found here:" >>"${LOGFILENAME}"
        echo "-> ${ALLOWED_FILESERRORS#${MYPATH}}" >>"${LOGFILENAME}"
      fi
      if [ "${TOTAL}" == "0" -a "${ALLOWED_FILESERRORS}" != "" ]
      then
        printf "%s" "'${ALLOWED_FILES}' must be placed at root folder"
      else
        if [ "${ALLOWED_FILESERRORS}" != "" ]
        then
          printf "%s" "${TOTAL} extra file(s) found + 1 error"
        else
          printf "%s" "${TOTAL} extra file(s) found"
        fi
      fi
      return 1
    fi
  }

  function check_fillit_fillitchecker
  {
    local LOGFILENAME=".myfillitchecker"

    if [ "${OPT_NO_FILLITCHECKER}" == "0" ]
    then
      ${CMD_RM} -f "${LOGFILENAME}"
      make re -C "${MYPATH}" &>/dev/null
      if [ ! -f "${MYPATH}/fillit" ]
      then
        printf "%s" "Executable not found: 'fillit'"
        return 1
      else
        check_fillit_checker "${LOGFILENAME}" "${MYPATH}"
        return "${?}"
       fi
    fi
    printf "%s" "Not performed"
    return 255
  }

fi
