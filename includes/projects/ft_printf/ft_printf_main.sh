#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  source includes/projects/ft_printf/ft_printf_list.sh

  declare CONF_FT_PRINTF_NAME="ft_printf"
  declare CONF_FT_PRINTF_DISPLAYNAME="FT_PRINTF"
  declare CONF_FT_PRINTF_FUNCTIONMAIN="check_project_ft_printf"
  declare CONF_FT_PRINTF_FUNCTIONTESTALL="check_project_ft_printf_all"
  declare CONF_FT_PRINTF_AUTHORFILE="mandatory"
  declare CONF_FT_PRINTF_TESTS="CHK_FT_PRINTF"
  declare CONF_FT_PRINTF_FORBIDDENFUNCS="CHK_FT_PRINTF_AUTHORIZED_FUNCS"

  declare -a CHK_FT_PRINTF='( "check_author" "author file" "check_norme" "norminette" "check_ft_printf_makefile" "makefile" "check_ft_printf_forbidden_func" "forbidden functions" "check_ft_printf_basictests" "basic tests" "check_ft_printf_bastardtests" "undefined behavior tests" "check_ft_printf_leaks" "leaks" "check_ft_printf_speedtest" "speed test" "check_ft_printf_moulitest" "moulitest (${MOULITEST_URL})" )'

  function check_project_ft_printf_main
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
      ${CONF_FT_PRINTF_FUNCTIONTESTALL}
    else
      ${CONF_FT_PRINTF_FUNCTIONMAIN}
    fi
  }

  function check_project_ft_printf
  {
    local MYPATH

    MYPATH=$(get_config "ft_printf")
    display_header
    display_top "$MYPATH" FT_PRINTF
    if [ -d "$MYPATH" ]
    then
      display_menu\
        ""\
        "${CONF_FT_PRINTF_FUNCTIONTESTALL}" "check all!"\
        "_"\
        "TESTS" "${CONF_FT_PRINTF_TESTS}" "${CONF_FT_PRINTF_FUNCTIONTESTALL}"\
        "_"\
        "check_configure \"${CONF_FT_PRINTF_FUNCTIONMAIN}\" \"${CONF_FT_PRINTF_NAME}\" \"${CONF_FT_PRINTF_DISPLAYNAME}\"" "change path"\
        main "BACK TO MAIN MENU"
    else
      display_menu\
        ""\
        "check_configure \"${CONF_FT_PRINTF_FUNCTIONMAIN}\" \"${CONF_FT_PRINTF_NAME}\" \"${CONF_FT_PRINTF_DISPLAYNAME}\"" "configure"\
        main "BACK TO MAIN MENU"
    fi
  }

  function check_project_ft_printf_all
  {
    local TESTONLY="${1}" MYPATH

    MYPATH=$(get_config "${CONF_FT_PRINTF_NAME}")
    configure_moulitest "${CONF_FT_PRINTF_NAME}" "${MYPATH}"
    display_header
    display_top "${MYPATH}" "${CONF_FT_PRINTF_DISPLAYNAME}"
    utils_launch_tests "${TESTONLY}" "${CONF_FT_PRINTF_TESTS}"
    display_menu\
      ""\
      "${CONF_FT_PRINTF_FUNCTIONMAIN}" "OK"\
      "open .mynorminette" "more info: norminette"\
      "open .mymakefile" "more info: makefile"\
      "open .myforbiddenfunc" "more info: forbidden functions"\
      "open .mybasictests" "more info: basic tests"\
      "open .mybasictests2" "more info: undefined behavior tests"\
      "open .myleaks" "more info: leaks"\
      "open .myspeedtest" "more info: speed test"\
      "open .mymoulitest" "more info: moulitest"\
      "_"\
      "open https://github.com/jgigault/42FileChecker/issues/new" "REPORT A BUG ON 42FILECHECKER"\
      "open ${MOULITEST_URL}/issues/new" "REPORT A BUG ON MOULITEST"\
      main "BACK TO MAIN MENU"
  }

  function check_ft_printf_basictests
  {
    check_ft_printf_compiltests ""
    return "${?}"
  }

  function check_ft_printf_bastardtests
  {
    check_ft_printf_compiltests "2"
    return "${?}"
  }

  function check_ft_printf_compiltests
  {
    local total errors fatal success i TTYPE TVAL TARGS FILEN RET1 RET2 RET0 TYPE TVAL0 TABTESTS

    if [ "${OPT_NO_BASICTESTS}" == "0" ]
    then
      i=0
      index=0
      total=0
      errors=0
      success=0
      fatal=0
      TYPE="$1"
      if [ "${TYPE}" == "" ]
      then
        TABTESTS=("${CHK_FT_PRINTF_LIST[@]}")
      else
        TABTESTS=("${CHK_FT_PRINTF_LIST2[@]}")
      fi
      LOGFILENAME=".mybasictests${TYPE}"
      ${CMD_RM} -f ${LOGFILENAME} "${LOGFILENAME}success"
      ${CMD_TOUCH} ${LOGFILENAME} "${LOGFILENAME}success"
      check_create_tmp_dir
      check_ft_printf_create_header
      make re -C "${MYPATH}" >${LOGFILENAME} 2>&1
      if [ -f "${MYPATH}/libftprintf.a" ]
      then
        echo "SUCCESS TESTS:\n" >> "${LOGFILENAME}success"
        while [ "${TABTESTS[$i]}" != "" -a $fatal -eq 0 ]
        do
          (( index += 1 ))
          TTYPE="${TABTESTS[$i]}"
          (( i += 1 ))
          TVAL0="${TABTESTS[$i]}"
          TVAL=`printf "%s" "${TABTESTS[$i]}" | sed 's/\\\\/\\\\\\\\/g'`
          (( i += 1 ))
          (( total += 1 ))
          RET0=`check_ft_printf_basictests_gcc "${TTYPE:0:1}" "${LOGFILENAME}"`
          if [ "$RET0" != "" ]
          then
            (( fatal += 1 ));
          else
            TARGS=`echo "$TTYPE" "\"$TVAL0\"" | sed 's/|/\" \"/g'`
            if [ "${TTYPE:0:1}" == "d" -o "$TTYPE" == "0p" -o "$TTYPE" == "sN" -o "${TTYPE:0:1}" == "x" -o "${TTYPE:0:1}" == "u" ]
            then
              TARGSV=`echo "\"$TVAL" | sed 's/|/, /g' | sed 's/,/\",/'`
            else
              TARGSV=`echo "\"$TVAL\"" | sed 's/|/\", \"/g'`
            fi
            FILEN1="./tmp/ft_printf_${TTYPE:0:1}"
            FILEN2="./tmp/printf_${TTYPE:0:1}"
            RET1=`eval "$FILEN1 $TARGS" 2>&1 | cat -e`
            RET2=`eval "$FILEN2 $TARGS" 2>&1 | cat -e`
            RET1=`printf "%s" "$RET1" | awk 'BEGIN{ORS="[BR]"}{print}' | sed 's/\[BR\]$//'`
            RET2=`printf "%s" "$RET2" | awk 'BEGIN{ORS="[BR]"}{print}' | sed 's/\[BR\]$//'`
            if [ "$RET1" != "$RET2" ]
            then
              if (( $errors == 0 ))
              then
                echo "FAILED TESTS:\n" >> $LOGFILENAME
                echo "# TEST NUMBER (TYPE OF ARG)" >> $LOGFILENAME
                echo "  INSTRUCTION();" >> $LOGFILENAME
                echo "  1. your function ft_printf" >> $LOGFILENAME
                echo "  2. unix function printf" >> $LOGFILENAME
                echo "     (returned value) -->written on stdout<--" >> $LOGFILENAME
              fi
              (( errors += 1 ))
              case "$TTYPE" in
                "s") TTYPEV="(char *)" ;;
                "sN") TTYPEV="(NULL)" ;;
                "dc") TTYPEV="(char)" ;;
                "d") TTYPEV="(int)" ;;
                "dj") TTYPEV="(intmax_t)" ;;
                "dz") TTYPEV="(ssize_t)" ;;
                "dh") TTYPEV="(short)" ;;
                "dH") TTYPEV="(signed char)" ;;
                "dl") TTYPEV="(long)" ;;
                "dL") TTYPEV="(long long)" ;;
                "0") TTYPEV="" ;;
                "0p") TTYPEV="(void *)" ;;
                "x") TTYPEV="(int)" ;;
                "xh") TTYPEV="(unsigned short)" ;;
                "xH") TTYPEV="(unsigned char)" ;;
                "xl") TTYPEV="(unsigned long)" ;;
                "xL") TTYPEV="(unsigned long long)" ;;
                "xj") TTYPEV="(uintmax_t)" ;;
                "u") TTYPEV="(unsigned int)" ;;
                "uh") TTYPEV="(unsigned char)" ;;
                "uj") TTYPEV="(intmax_t)" ;;
                "uz") TTYPEV="(size_t)" ;;
                "uH") TTYPEV="(unsigned short)" ;;
                "ul") TTYPEV="(unsigned long)" ;;
                "uL") TTYPEV="(unsigned long long)" ;;
                "uU") TTYPEV="(unsigned long)" ;;
              esac
              printf "\n# %04d %s\n" "$index" "$TTYPEV" >> $LOGFILENAME
              printf "  ft_printf(%s);\n" "$TARGSV" >> $LOGFILENAME
              RET0=`printf "%s" "$RET1" | sed 's/\\\\/\\\\\\\\/g' | cut -d"|" -f2 | sed 's/NULL//g'`
              printf "  1. (%5d) -->" "$RET0" >> $LOGFILENAME 2>&1
              RET0=`printf "%s" "$RET1" | sed 's/\\\\/\\\\\\\\/g' | cut -d"|" -f1 | sed 's/\[BR\]/\\\\n/g'`
              printf "%s<--\n" "$RET0" >> $LOGFILENAME
              RET0=`printf "%s" "$RET2" | sed 's/\\\\/\\\\\\\\/g' | cut -d"|" -f2 | sed 's/NULL//g'`
              printf "  2. (%5d) -->" "$RET0" >> $LOGFILENAME 2>&1
              RET0=`printf "%s" "$RET2" | sed 's/\\\\/\\\\\\\\/g' | cut -d"|" -f1 | sed 's/\[BR\]/\\\\n/g'`
              printf "%s<--\n" "$RET0" >> $LOGFILENAME
              RET0=`echo "$RET2" | cut -d"|" -f1 | sed 's/\\\\/\\\\\\\\/g' | sed 's/NULL//g' | sed 's/\[BR\]/\\\\n/g'`
              printf "%4d. FAIL %-45s -> \"%s\"\n" "$index" "ft_printf($TARGSV);" "$RET0" >> $LOGFILENAME"success"
            else
              (( success += 1 ))
              RET0=`echo "$RET2" | cut -d"|" -f1 | sed 's/\\\\/\\\\\\\\/g' | sed 's/NULL//g' | sed 's/\[BR\]/\\\\n/g'`
              printf "%4d.      %-45s -> \"%s\"\n" "$index" "ft_printf($TARGSV);" "$RET0" >> $LOGFILENAME"success"
            fi
          fi
        done
      else
        fatal=1
      fi
      if (( $fatal == 0 ))
      then
        if (( $errors == 0 ))
        then
          cat $LOGFILENAME"success" > $LOGFILENAME
          printf "%s" "All tests passed (${total} tests)"
          return 0
        else
          echo "\n--------------\n" >> $LOGFILENAME
          cat $LOGFILENAME"success" >> $LOGFILENAME
          printf "%s" "${errors} failed test(s) out of ${total} tests"
        fi
      else
        printf "%s" "Cannot compile"
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_ft_printf_speedtest
  {
    local LOGFILENAME CSRC1 CSRC2 BSRC1 BSRC2

    if [ "$OPT_NO_SPEEDTEST" == "0" ]
    then
      LOGFILENAME=".myspeedtest"
      CSRC1="./srcs/printf/speedtest_ft_printf.c"
      CSRC2="./srcs/printf/speedtest_printf.c"
      BSRC1="./tmp/ft_printf_speedtest"
      BSRC2="./tmp/printf_speedtest"
      ${CMD_RM} -f ${LOGFILENAME}
      ${CMD_TOUCH} ${LOGFILENAME}
      check_create_tmp_dir
      make re -C "${MYPATH}" >${LOGFILENAME} 2>&1
      if [ -f "${MYPATH}/libftprintf.a" ]
      then
        RET0=`gcc -Wall -Werror -Wextra "${CSRC1}" -L "${MYPATH}" -lftprintf -o "${BSRC1}" >${LOGFILENAME} 2>&1`
        if [ -f "${BSRC1}" ]
        then
          RET0=`gcc -Wall -Werror -Wextra "${CSRC2}" -o "${BSRC2}" >${LOGFILENAME} 2>&1`
          if [ -f "$BSRC2" ]
          then
            check_speedtest "${BSRC1}" "${BSRC2}" "null" "${LOGFILENAME}" "Your program is compared with the original 'printf'.\n\n"
            return "${?}"
          fi
        fi
      fi
      printf "%s" "Cannot compile"
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_ft_printf_leaks
  {
    local LOGFILENAME RET0 CSRC BSRC

    if [ "${OPT_NO_LEAKS}" == "0" ]
    then
      CSRC="./srcs/printf/ft_printf_leaks.c"
      BSRC="./tmp/ft_printf_leaks"
      LOGFILENAME=".myleaks"
      ${CMD_RM} -f ${LOGFILENAME}
      ${CMD_TOUCH} ${LOGFILENAME}
      check_create_tmp_dir
      make re -C "${MYPATH}" >${LOGFILENAME} 2>&1
      if [ -f "${MYPATH}/libftprintf.a" ]
      then
        RET0=`gcc -Wall -Werror -Wextra "${CSRC}" -L "${MYPATH}" -lftprintf -o "${BSRC}" 2>&1`
        if [ -f "$BSRC" ]
        then
          RET0=`cat "${CSRC}" | sed 's/\\\\/\\\\\\\\/g'`
          NOTICE="Here is the main() test:\n-----------------------------\n${RET0}\n-----------------------------\n\n\n"
          check_leaks "${BSRC}" "" "${LOGFILENAME}" "${NOTICE}"
          return "${?}"
        else
          echo "${RET0}" >>${LOGFILENAME}
        fi
      fi
      printf "%s" "Cannot compile"
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_ft_printf_basictests_gcc
  {
    local FILEN RET0 LOGFILENAME

    FILEN="printf_$1"
    LOGFILENAME="$2"
    if [ ! -f "./tmp/ft_${FILEN}" -o ! -f "./tmp/${FILEN}" ]
    then
      if [ -f "${MYPATH}/libftprintf.a" ]
      then
        RET0=`${CMD_GCC} -Wall -Werror -Wextra "./srcs/printf/ft_${FILEN}.c" -L"${MYPATH}" -lftprintf -o "./tmp/ft_${FILEN}" 2>&1`
        if [ "${RET0}" != "" ]; then echo "${RET0}" > ${LOGFILENAME}; printf "error"; return; fi
        RET0=`${CMD_GCC} "./srcs/printf/${FILEN}.c" -o "./tmp/${FILEN}" 2>&1`
        if [ "${RET0}" != "" ]; then echo "${RET0}" > ${LOGFILENAME}; printf "error"; return; fi
      else
        echo "${MYPATH}/libftprintf.a was not found" > ${LOGFILENAME}; printf "error"; return;
      fi
    fi
    return 1
  }

  function check_ft_printf_create_header
  {
    echo "#include <stdarg.h>" > "${RETURNPATH}/tmp/printf.h"
    echo "int ft_printf(char const *format, ...);" >> "${RETURNPATH}/tmp/printf.h"
  }

  function check_ft_printf_makefile
  {
    if [ "${OPT_NO_MAKEFILE}" == "0" ]
    then
      check_makefile "${MYPATH}" libftprintf.a
      return "${?}"
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_ft_printf_forbidden_func
  {
    local F FILEN

    if [ "${OPT_NO_FORBIDDEN}" == "0" ]
    then
      if [ -f "${MYPATH}/Makefile" -o -f "${MYPATH}/makefile" ]
      then
        FILEN="forbiddenfuncs"
        F="${RETURNPATH}/tmp/${FILEN}.c"
        check_create_tmp_dir
        echo "int ft_printf(char const *format, ...);" > "${F}"
        echo "int main(void) {" >> "${F}"
        echo "ft_printf(\"\");" >> "${F}"
        echo "return (1); }" >> "${F}"
        make re -C "${MYPATH}" >.myforbiddenfunc 2>&1
        rm -f "${RETURNPATH}/tmp/${FILEN}"
        if [ -f "${MYPATH}/libftprintf.a" ]
        then
          RET0=`gcc "${F}" -L"${MYPATH}" -lftprintf -o "${RETURNPATH}/tmp/${FILEN}" 2>&1`
          if [ -f "./tmp/${FILEN}" ]
          then
            check_forbidden_func "${CONF_FT_PRINTF_FORBIDDENFUNCS}" "./tmp/${FILEN}"
            return "${?}"
          else
            echo "${RET0}" >.myforbiddenfunc
            printf "%s" "Cannot compile"
          fi
        else
          printf "%s" "Cannot compile"
        fi
      else
        printf "%s" "Makefile not found"
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_ft_printf_moulitest
  {
    if [ "$OPT_NO_MOULITEST" == "0" ]
    then
      check_moulitest "ft_printf"
      return "${?}"
    fi
    printf "%s" "Not performed"
    return 255
  }

fi
