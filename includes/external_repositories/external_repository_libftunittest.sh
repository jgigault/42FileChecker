#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function check_libftunittest
  {
    local RET0 RET1 TOTAL MYPATH
    local RUNNING_MODE=$1
    local LOGFILENAME=".mylibftunittest"

    if [ "${OPT_NO_LIBFTUNITTEST}" == "0" ]
    then
      ${CMD_RM} -f ${LOGFILENAME}
      if [ -d "${LIBFTUNITTEST_DIR}" ]
      then
        MYPATH=$(get_config "libft")
        if [ "${OPT_NO_MAKEFILE}" == "0" -o "${RUNNING_MODE}" == "RUN_ALONE" ]
        then
          make re -C "${MYPATH}" 1>/dev/null 2>&1
        fi
        make re f -C "${LIBFTUNITTEST_DIR}" LIBFTDIR="${MYPATH}" >${LOGFILENAME} 2>&1
        check_cleanlog ${LOGFILENAME}
        RET0=`cat ${LOGFILENAME}`
        RET1=`echo "${RET0}" | grep 'RUNING TESTS:'`
        if [ "${RET1}" == "" ]
        then
          printf "%s" "Fatal error: libft-unit-test cannot compile (see more info)"
        else
          RET1=`echo "${RET0}" | grep 'See result.log for more informations'`
          if [ "${RET1}" == "" ]
          then
            printf "%s" "Fatal error: libft-unit-test has aborted (see more info)"
          else
            RET1=`echo "${RET0}" | grep -o -E "\[FAILED\]|\[CRASH\]|\[NO CRASH\]"`
            echo "42FILECHECKER INFO:\n\nHere is the full standard output of the libft-unit-test running with your libft.\nSee also the clean logfile provided by the library at the following path:\n${RETURNPATH}/${LIBFTUNITTEST_DIR}/result.log\n\n\n\n------------------------------------------------\n\n\n\n${RET0}" >${LOGFILENAME}
            if [ "${RET1}" != "" ]
            then
              TOTAL=`printf "%s\n" "${RET1}" | awk 'END {print NR}'`
              printf "%s" "${TOTAL} failed test(s)"
            else
              printf "%s" "All Unit Tests passed"
              return 0
            fi
          fi
        fi
      else
        printf "%s" "'libft-unit-test' is not installed"
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

fi
