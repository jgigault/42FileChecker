#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  declare -a CHK_FILLIT='( "check_author optional" "auteur" "check_norme" "norminette" "check_fillit_makefile" "makefile" "check_fillit_forbidden_func" "forbidden functions" "check_fillit_extern_file" "extern file" "check_fillit_fillitchecker" "fillit_checker (${EXTERNAL_REPOSITORY_FILLITCHECKER_URL})" )'

  function check_fillit_main
  {
    local LOCAL_UPDATE_RETURN=""
    if [ "${OPT_NO_FILLITCHECKER}" == "0" ]
    then
      check_update_external_repository "fillit_checker" "${EXTERNAL_REPOSITORY_FILLITCHECKER_URL}" "${EXTERNAL_REPOSITORY_FILLITCHECKER_DIR}"
      case "${LOCAL_UPDATE_RETURN}" in
        "exit") main; return ;;
      esac
    fi
    check_fillit
  }

  function check_fillit
  {
    local MYPATH="$(get_config "fillit")"
    display_header
    display_top "${MYPATH}" "FILLIT"
    if [ -d "${MYPATH}" ]
    then
      display_menu\
        ""\
        "check_fillit_all" "check all!"\
        "_"\
        "TESTS" "CHK_FILLIT" "check_fillit_all"\
        "_"\
        "check_configure check_fillit fillit FILLIT optional" "change path"\
        "main" "BACK TO MAIN MENU"
    else
      display_menu\
        ""\
        "check_configure check_fillit fillit FILLIT optional" "configure"\
        "main" "BACK TO MAIN MENU"
    fi
  }

  function check_fillit_all
  {
    local FUNC TITLE i="0" j="1" j2 k="0" RET0 MYPATH="$(get_config "fillit")" TESTONLY="$1"
    display_header
    display_top "${MYPATH}" "FILLIT"
    while [ "${CHK_FILLIT[$i]}" != "" ]
    do
      FUNC="${CHK_FILLIT[$i]}"
      (( i += 1 ))
      TITLE=`echo "${CHK_FILLIT[$i]}"  | sed 's/%/%%/g'`
      j2=`ft_itoa "${j}"`
      printf "  ${C_WHITE}%s -> %s${C_CLEAR}\n" "${j2}" "${TITLE}"
      if [ "${TESTONLY}" == "" -o "${TESTONLY}" == "${k}" ]
      then
        (eval "${FUNC}" "all" > .myret) &
        display_spinner $!
        RET0=`cat .myret | sed 's/%/%%/g'`
        printf "${RET0}\n\n"
      else
        printf "${C_GREY}  --Not performed--\n${C_CLEAR}\n"
      fi
      (( j += 1 ))
      (( i += 1 ))
      (( k += 1 ))
    done
    display_menu\
      ""\
      "check_fillit" "OK"\
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
      check_makefile "$(get_config "fillit")" "fillit"
    else
      printf "${C_GREY}  --Not performed--${C_CLEAR}"
    fi
  }

  function check_fillit_forbidden_func
  {
    if [ "${OPT_NO_FORBIDDEN}" == "0" ]
    then
      make -C "${MYPATH}" >.myforbiddenfunc 2>&1
      if [ -f "${MYPATH}/fillit" ]
      then
        check_forbidden_func "CHK_FILLIT_AUTHORIZED_FUNCS" "${MYPATH}/fillit"
      else
        printf "${C_RED}  Executable not found: 'fillit'${C_CLEAR}"
      fi
    else
      printf "${C_GREY}  --Not performed--${C_CLEAR}"
    fi
  }

  function check_fillit_extern_file
  {
    local LOGFILENAME=".myexternfile" F AF HAS_AF TOTAL=0 EXTERNFILEFOUND="0" ALLOWED_FILESERRORS="" I
    local -a ALLOWED_FILES='( "extern_file.txt" "auteur" )'
    ${CMD_RM} -f "${LOGFILENAME}"
    make fclean -C "${MYPATH}" &>/dev/null
    for F in $(find "${MYPATH}" -type f ! -name '*.[ch]' ! -name 'Makefile' ! -regex "${MYPATH}/\.git.*")
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
          printf "${C_GREEN}  %s${C_CLEAR}" "No extra file found except '${ALLOWED_FILES[@]}'"
      else
          printf "${C_GREEN}  %s${C_CLEAR}" "No extra file found"
      fi
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
        printf "${C_RED}  %s${C_CLEAR}" "'${ALLOWED_FILES}' must be placed at root folder"
      else
        if [ "${ALLOWED_FILESERRORS}" != "" ]
        then
          printf "${C_RED}  %s${C_CLEAR}" "${TOTAL} extra file(s) found + 1 error"
        else
          printf "${C_RED}  %s${C_CLEAR}" "${TOTAL} extra file(s) found"
        fi
      fi
    fi
  }

  function check_fillit_fillitchecker
  {
    if [ "${OPT_NO_FILLITCHECKER}" == "0" ]
    then
      local LOGFILENAME=".myfillitchecker"
      ${CMD_RM} -f "${LOGFILENAME}"
      make re -C "${MYPATH}" &>/dev/null
      if [ ! -f "${MYPATH}/fillit" ]
      then
        printf "${C_RED}  Executable not found: 'fillit'${C_CLEAR}"
      else
        check_fillit_checker "${LOGFILENAME}" "${MYPATH}"
       fi
    else
      printf "${C_GREY}  --Not performed--${C_CLEAR}"
    fi
  }

fi
