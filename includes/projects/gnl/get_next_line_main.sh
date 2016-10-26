#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  declare CONF_GNL_NAME="gnl"
  declare CONF_GNL_DISPLAYNAME="GET_NEXT_LINE"
  declare CONF_GNL_FUNCTIONMAIN="check_project_gnl"
  declare CONF_GNL_FUNCTIONTESTALL="check_project_gnl_all"
  declare CONF_GNL_AUTHORFILE="mandatory"
  declare CONF_GNL_TESTS="CHK_GNL"
  declare CONF_GNL_FORBIDDENFUNCS="CHK_GNL_AUTHORIZED_FUNCS"

  declare -a CHK_GNL='( "check_author" "author file" "check_norme" "norminette" "check_gnl_macro" "BUFF_SIZE macro" "check_gnl_bonus" "bonus: static var" "check_gnl_forbidden_func" "forbidden functions" "check_gnl_basics" "basic tests" "check_gnl_multiple_fd" "bonus: multiple file descriptor" "check_gnl_leaks" "leaks" "check_gnl_moulitest" "moulitest (${MOULITEST_URL})" )'

  declare -a CHK_GNL_BASICS='("gnl1_1" "1 line 8 chars with Line Feed" "" "gnl1_2" "2 lines 8 chars with Line Feed" "" "gnl1_3" "4 lines 8 chars with Line Feed" "" "gnl2_1" "STDIN: 1 line 8 chars with Line Feed" "cat ./srcs/gnl/gnl1_1.txt | SPEC0" "gnl2_2" "STDIN: 2 lines 8 chars with Line Feed" "cat ./srcs/gnl/gnl1_2.txt | SPEC0" "gnl2_3" "STDIN: 4 lines 8 chars with Line Feed" "cat ./srcs/gnl/gnl1_3.txt | SPEC0" "gnl3_1" "1 line 16 chars with Line Feed" "" "gnl3_2" "2 lines 16 chars with Line Feed" "" "gnl3_3" "4 lines 16 chars with Line Feed" "" "gnl4_1" "STDIN: 1 line 16 chars with Line Feed" "cat ./srcs/gnl/gnl3_1.txt | SPEC0" "gnl4_2" "STDIN: 2 lines 16 chars with Line Feed" "cat ./srcs/gnl/gnl3_2.txt | SPEC0" "gnl4_3" "STDIN: 4 lines 16 chars with Line Feed" "cat ./srcs/gnl/gnl3_3.txt | SPEC0" "gnl5_1" "1 line 4 chars with Line Feed" "" "gnl5_2" "2 lines 4 chars with Line Feed" "" "gnl5_3" "4 lines 4 chars with Line Feed" "" "gnl6_1" "STDIN: 1 line 4 chars with Line Feed" "cat ./srcs/gnl/gnl5_1.txt | SPEC0" "gnl6_2" "STDIN: 2 lines 4 chars with Line Feed" "cat ./srcs/gnl/gnl5_2.txt | SPEC0" "gnl6_3" "STDIN: 4 lines 4 chars with Line Feed" "cat ./srcs/gnl/gnl5_3.txt | SPEC0" "gnl7_1" "1 lines 8 chars without Line Feed" "" "gnl7_2" "2 lines 8 chars without Line Feed" "" "gnl7_3" "4 lines 8 chars without Line Feed" "" "gnl8_1" "STDIN: 1 line 8 chars without Line Feed" "cat ./srcs/gnl/gnl7_1.txt | SPEC0" "gnl8_2" "STDIN: 2 lines 8 chars without Line Feed" "cat ./srcs/gnl/gnl7_2.txt | SPEC0" "gnl8_3" "STDIN: 4 lines 8 chars without Line Feed" "cat ./srcs/gnl/gnl7_3.txt | SPEC0" "gnl9_1" "Bad file descriptor #1" "" "gnl9_2" "Bad file descriptor #2" "")'

  function check_project_gnl_main
  {
    local LOCAL_UPDATE_RETURN=""

    if [ "${OPT_NO_MOULITEST}" == "0" ]
    then
      check_update_external_repository "moulitest" "${MOULITEST_URL}" "${MOULITEST_DIR}"
      case "${LOCAL_UPDATE_RETURN}" in
        "exit") main; return ;;
      esac
    fi
    if [ "${GLOBAL_IS_INTERACTIVE}" == "0" ]
    then
      ${CONF_GNL_FUNCTIONTESTALL}
    else
      ${CONF_GNL_FUNCTIONMAIN}
    fi
  }

  function check_project_gnl
  {
    local MYPATH

    MYPATH=$(get_config "gnl")
    display_header
    display_top "$MYPATH" GET_NEXT_LINE
    if [ -d "$MYPATH" ]
    then
      display_menu\
        ""\
        "${CONF_GNL_FUNCTIONTESTALL}" "check all!"\
        "_"\
        "TESTS" "CHK_GNL" "${CONF_GNL_FUNCTIONTESTALL}"\
        "_"\
        "check_configure \"${CONF_GNL_FUNCTIONMAIN}\" \"${CONF_GNL_NAME}\" \"${CONF_GNL_DISPLAYNAME}\"" "change path"\
        main "BACK TO MAIN MENU"
    else
      display_menu\
        ""\
        "check_configure \"${CONF_GNL_FUNCTIONMAIN}\" \"${CONF_GNL_NAME}\" \"${CONF_GNL_DISPLAYNAME}\"" "configure"\
        main "BACK TO MAIN MENU"
    fi
  }

  function check_project_get_next_line_all
  {
    ${CONF_GNL_FUNCTIONTESTALL}
  }

  function check_project_gnl_all
  {
    local TESTONLY="${1}" MYPATH

    MYPATH=$(get_config "${CONF_GNL_NAME}")
    configure_moulitest "${CONF_GNL_NAME}" "${MYPATH}"
    display_header
    display_top "${MYPATH}" "${CONF_GNL_DISPLAYNAME}"
    utils_launch_tests "${TESTONLY}" "${CONF_GNL_TESTS}"
    display_menu\
      ""\
      "${CONF_GNL_FUNCTIONMAIN}" "OK"\
      "open .mynorminette" "more info: norminette"\
      "open .mymacro" "more info: BUFF_SIZE macro"\
      "open .mybonusstatic" "more info: bonus: static var"\
      "open .myforbiddenfunc" "more info: forbidden functions"\
      "open .mybasictests" "more info: basic tests"\
      "open .mymultiplefd" "more info: bonus: multiple file descriptor"\
      "open .myleaks" "more info: leaks"\
      "open .mymoulitest" "more info: moulitest"\
      "_"\
      "open https://github.com/jgigault/42FileChecker/issues/new" "REPORT A BUG ON 42FILECHECKER"\
      "open ${MOULITEST_URL}/issues/new" "REPORT A BUG ON MOULITEST"\
      main "BACK TO MAIN MENU"
  }

  function check_gnl_forbidden_func
  {
    local FILEN GNL_LIBFT RET0 SOURCEF

    if [ "${OPT_NO_FORBIDDEN}" == "0" ]
    then
      FILEN=forbiddenfuncs
      GNL_LIBFT="${MYPATH}/libft"
      SOURCEF="./tmp/${FILEN}.c"
      check_create_tmp_dir
      check_gnl_create_header
      echo "#define NULL ((void *)0)" > ${SOURCEF}
      echo "#include \"gnl.h\"" >> ${SOURCEF}
      echo "int main(void) { int ret; ret = get_next_line(0, NULL); return (1); }" >> ${SOURCEF}
      ${CMD_RM} -f "./tmp/${FILEN}"
      if [ -d "${GNL_LIBFT}" ]
      then
        make -C "${GNL_LIBFT}" >/dev/null 2>&1
        RET0=`${CMD_GCC} "${MYPATH}/get_next_line.c" -L"${GNL_LIBFT}" -lft -I "${GNL_LIBFT}/includes" ./tmp/${FILEN}.c -o ./tmp/${FILEN} >/dev/null 2>&1`
      else
        RET0=`${CMD_GCC} "${MYPATH}/get_next_line.c" ./tmp/${FILEN}.c -o ./tmp/${FILEN} >/dev/null 2>&1`
      fi
      if [ -f "./tmp/${FILEN}" ]
      then
        check_forbidden_func "${CONF_GNL_FORBIDDENFUNCS}" "./tmp/${FILEN}"
        return "${?}"
      else
        printf "%s" "Cannot compile"
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_gnl_basics
  {
    local GNL_LIBFT i j FILEN TITLEN RET0 errors fatal SPEC0 LOGFILENAME

    if [ "${OPT_NO_BASICTESTS}" == "0" ]
    then
      LOGFILENAME=.mybasictests
      ${CMD_RM} -f ${LOGFILENAME}
      ${CMD_TOUCH} ${LOGFILENAME}
      check_create_tmp_dir
      check_gnl_create_header
      GNL_LIBFT="${MYPATH}/libft"
      i=0
      j=0
      errors=0
      fatal=0
      echo "GNL BASIC TESTS:\n" > ${LOGFILENAME}
      while [ "${CHK_GNL_BASICS[i]}" != "" ]
      do
        (( j += 1 ))
        FILEN="${CHK_GNL_BASICS[i]}"
        (( i += 1 ))
        TITLEN="${CHK_GNL_BASICS[i]}"
        (( i += 1 ))
        SPEC0="${CHK_GNL_BASICS[i]}"
        (( i += 1 ))
        echo "---------------------" >> ${LOGFILENAME}
        echo "TEST #$j: ${TITLEN} (${FILEN}.c):" >> ${LOGFILENAME}
        ${CMD_RM} -f "./tmp/${FILEN}"
        if [ -d "${GNL_LIBFT}" ]
        then
          RET0=`${CMD_GCC} -Wall -Werror -Wextra -I ./tmp "${MYPATH}/get_next_line.c" -L"${GNL_LIBFT}" -lft -I "${GNL_LIBFT}/includes" ./srcs/gnl/${FILEN}.c -o ./tmp/${FILEN} 2>&1`
        else
          RET0=`${CMD_GCC} -Wall -Werror -Wextra -I ./tmp "${MYPATH}/get_next_line.c" ./srcs/gnl/${FILEN}.c -o ./tmp/${FILEN} 2>&1`
        fi
        if [ -f "./tmp/${FILEN}" ]
        then
          if [ "${SPEC0}" != "" ]
          then
            RET0=`echo "${SPEC0}" | sed 's/SPEC0/\.\/\.\/tmp\/${FILEN}/'`
            RET0=`eval ${RET0} 2>&1`
          else
            if [ -f "./srcs/gnl/${FILEN}.txt" ]
            then
              cp "./srcs/gnl/${FILEN}.txt" "./tmp/${FILEN}.txt"
            fi
            cd "./tmp"
            RET0=`./${FILEN} 2>&1`
            cd ".."
          fi
          if [ "${RET0}" != "OK" ]
          then
            (( errors += 1 ))
          fi
          echo "${RET0}" >> ${LOGFILENAME}
        else
          echo "Cannot compile" >> ${LOGFILENAME}
          echo "${RET0}" >> ${LOGFILENAME}
          (( fatal += 1 ))
        fi
        echo "" >> ${LOGFILENAME}
      done
      if (( ${fatal} > 0 ))
      then
        printf "%s" "Cannot compile"
      else
        if (( ${errors} == 0 ))
        then
          printf "%s" "All tests passed"
          return 0
        else
          printf "%s" "${errors} failed test(s)"
        fi
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_gnl_multiple_fd
  {
    local GNL_LIBFT i j FILEN TITLEN RET0 errors fatal GNLID LOGFILENAME

    if [ "${OPT_NO_GNLMULTIPLEFD}" == "0" ]
    then
      LOGFILENAME=".mymultiplefd"
      ${CMD_RM} -f ${LOGFILENAME}
      ${CMD_TOUCH} ${LOGFILENAME}
      check_create_tmp_dir
      check_gnl_create_header
      GNL_LIBFT="${MYPATH}/libft"
      i=0
      j=0
      errors=0
      fatal=0
      ${CMD_RM} -f "./tmp/gnl11"
      if [ -d "${GNL_LIBFT}" ]
      then
        make -C "${GNL_LIBFT}" >/dev/null 2>&1
        RET0=`${CMD_GCC} -Wall -Werror -Wextra -I ./tmp "${MYPATH}/get_next_line.c" -L"${GNL_LIBFT}" -lft -I "${GNL_LIBFT}/includes" ./srcs/gnl/gnl11.c -o ./tmp/gnl11 2>&1`
      else
        RET0=`${CMD_GCC} -Wall -Werror -Wextra -I ./tmp "${MYPATH}/get_next_line.c" ./srcs/gnl/gnl11.c -o ./tmp/gnl11 2>&1`
      fi
      if [ -f "./tmp/gnl11" ]
      then
        RET0=`./tmp/gnl11 2>&1`
        echo "${RET0}" >> ${LOGFILENAME}
        if [ "${RET0}" == "OK" ]
        then
          printf "%s" "Multiple file descriptor supported"
          return 0
        else
          if [ "${RET0}" != "" ]
          then
            printf "%s" "Not supported"
            echo "\n-----------------------------------" >> ${LOGFILENAME}
            echo "Here is the main test ($(pwd)/srcs/gnl/gnl11.c):\n" >> ${LOGFILENAME}
            cat "./srcs/gnl/gnl11.c" >> ${LOGFILENAME}
          else
            printf "%s" "An error occured"
          fi
        fi
      else
        printf "%s" "Cannot compile"
        echo "${RET0}" >> ${LOGFILENAME}
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_gnl_leaks
  {
    local GNL_LIBFT RET0 LOGFILENAME PROGNAME HEADERF VAL0 MACRONAME

    if [ "${OPT_NO_LEAKS}" == "0" ]
    then
      LOGFILENAME=".myleaks"
      ${CMD_RM} -f ${LOGFILENAME}
      ${CMD_TOUCH} ${LOGFILENAME}
      check_create_tmp_dir
      check_gnl_create_header
      HEADERF="${MYPATH}/get_next_line.h"
      if [ -f "${HEADERF}" ]
      then
        GNL_LIBFT="${MYPATH}/libft"
        MACRONAME=$(check_gnl_get_macro_name "${HEADERF}")
        RET0=`cat "${HEADERF}" | grep define | grep "${MACRONAME}"`
        VAL0=`printf "%s" "${RET0}" | sed 's/[^0-9]*//g'`
        if [ $(printf "%d" "${VAL0}") -gt 11000 ]
        then
          echo "Please use a smaller ${MACRONAME}!\nMaximum is 11000." > ${LOGFILENAME}
          printf "%s" "${MACRONAME} too big"
        else
          ${CMD_RM} -f "./tmp/gnl10"
          if [ -d "${GNL_LIBFT}" ]
          then
            make -C "${GNL_LIBFT}" >${LOGFILENAME} 2>&1
            RET0=`${CMD_GCC} -Wall -Werror -Wextra -I ./tmp "${MYPATH}/get_next_line.c" -L"${GNL_LIBFT}" -lft -I "${GNL_LIBFT}/includes" ./srcs/gnl/gnl10.c -o ./tmp/gnl10 2>&1`
          else
            RET0=`${CMD_GCC} -Wall -Werror -Wextra -I ./tmp "${MYPATH}/get_next_line.c" ./srcs/gnl/gnl10.c -o ./tmp/gnl10 2>&1`
          fi
          if [ -f "./tmp/gnl10" ]
          then
            RET0=`cat ./srcs/gnl/gnl10.c | sed 's/\\\\/\\\\\\\\/g'`
            NOTICE="Here is the main() test:\n-----------------------------\n${RET0}\n-----------------------------\n\n\n"
            check_leaks "./tmp/gnl10" "" "${LOGFILENAME}" "${NOTICE}"
            return "${?}"
          else
            echo "${RET0}" >> ${LOGFILENAME}
            printf "%s" "Cannot compile"
          fi
        fi
      else
        printf "%s" "'get_next_line.h' not found"
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_gnl_create_header
  {
    local GNLH

    GNLH="$MYPATH/get_next_line.h"
    echo "#include \"$GNLH\"" > ./tmp/gnl.h
  }

  function check_gnl_bonus
  {
    local RET0 TOTAL GNLC LOGFILENAME

    if [ "${OPT_NO_GNLONESTATIC}" == "0" ]
    then
      LOGFILENAME=.mystatic
      $CMD_RM -f $LOGFILENAME
      $CMD_TOUCH $LOGFILENAME
      GNLC="$MYPATH/get_next_line.c"
      if [ -f "$GNLC" ]
      then
        RET0=`awk 'BEGIN { OFS=""; BLOCK=0 } { if ($0 == "{") { BLOCK=1 } if ($0 == "}") { BLOCK=0 } if (BLOCK == 1) { if ($0 ~ /^[\t ]*static[\t ]/) { gsub(/^[\t ]*/, ""); print "line ", NR, ": ", $0 }}}' "$GNLC"`
        TOTAL=`echo "$RET0" | awk 'END {print NR}'`
        if (( TOTAL > 1 ))
        then
          printf "%s" "${TOTAL} static variables found"
          echo "$RET0" > $LOGFILENAME
        else
          if [ "$RET0" == "" ]
          then
            printf "%s" "No static variable"
            echo "No static var found" > $LOGFILENAME
          else
            printf "%s" "${TOTAL} static variable"
            echo "$RET0" > $LOGFILENAME
          fi
          return 0
        fi
      else
        printf "%s" "get_next_line.c not found"
        echo "get_next_line.c: File Not Found" > $LOGFILENAME
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_gnl_macro
  {
    local RET0 RET2 HEADERF VAL0 LOGFILENAME MACRONAME

    if [ "${OPT_NO_GNLMACRO}" == "0" ]
    then
      LOGFILENAME=".mymacro"
      ${CMD_RM} -f ${LOGFILENAME}
      ${CMD_TOUCH} ${LOGFILENAME}
      HEADERF="${MYPATH}/get_next_line.h"
      if [ -f "${HEADERF}" -a -f "${MYPATH}/get_next_line.c" ]
      then
        MACRONAME=$(check_gnl_get_macro_name "${HEADERF}")
        if [ "${MACRONAME}" == "" ]
        then
          printf "%s" "BUFF_SIZE is not defined"
          echo "BUFF_SIZE is not defined" > ${LOGFILENAME}
        else
          RET2=`cat "${MYPATH}/get_next_line.c" | grep -E "[^*]{2}.*read[ \t]*\([^,]*,[^,]*,[ \t]*${MACRONAME}[ \t]*)"`
          RET0=`cat "${HEADERF}" | grep 'define' | grep "${MACRONAME}"`
          VAL0=`echo "${RET0}" | sed 's/[^0-9]*//g'`
          if [ "${RET2}" == "" ]
          then
            printf "%s" "${MACRONAME} is defined with value: ${VAL0}, but seems to be used not properly"
            echo "${MACRONAME} should be used as the third parameter of the function 'read' without any handling! read([*], [*], ${MACRONAME})\n\nCheck the line(s) where the function 'read' is used:\n$(cat "${MYPATH}/get_next_line.c" | grep -E '[^*]{2}.*read[ \t]*\(' | sed 's/^[ 	]*//g')\n\nNote: When multiple lines are used for calling 'read', this test fails!" > ${LOGFILENAME}
          else
            printf "%s" "${MACRONAME} is defined with value: ${VAL0}"
            echo "${MACRONAME} is defined with value: ${VAL0}" > ${LOGFILENAME}
            return 0
          fi
        fi
      else
        printf "%s" "get_next_line.[ch] not found"
        echo "get_next_line.[ch]: File Not Found" > ${LOGFILENAME}
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_gnl_moulitest
  {
    if [ "${OPT_NO_MOULITEST}" == "0" ]
    then
      check_moulitest "${CONF_GNL_NAME}"
      return "${?}"
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_gnl_get_macro_name
  {
    local RET0 RET0 LPATH

    LPATH="${1}"
    RET0=$(cat "${LPATH}" | grep -E '#[ ]*define')
    if [ "$(echo "${RET0}" | grep 'BUFF_SIZE')" != "" ]
    then
      printf "BUFF_SIZE"
      return 0
    fi
    if [ "$(echo "${RET0}" | grep 'BUF_SIZE')" != "" ]
    then
      printf "BUF_SIZE"
      return 0
    fi
    if [ "$(echo "${RET0}" | grep 'BUFFER_SIZE')" != "" ]
    then
      printf "BUFFER_SIZE"
      return 0
    fi
    if [ "$(echo "${RET0}" | grep 'BUFFSIZE')" != "" ]
    then
      printf "BUFFSIZE"
      return 0
    fi
    if [ "$(echo "${RET0}" | grep 'BUFSIZE')" != "" ]
    then
      printf "BUFSIZE"
      return 0
    fi
    if [ "$(echo "${RET0}" | grep 'BUFFERSIZE')" != "" ]
    then
      printf "BUFFERSIZE"
      return 0
    fi
    return 1
  }

fi
