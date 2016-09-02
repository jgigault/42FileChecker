#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function check_leaks
  {
    local fatal PROCESSID RET0 RET1 PROGNAME NOTICE
    fatal=0
    PROGNAME="$1"
    PROGARGS="$2"
    LOGFILENAME="$3"
    NOTICE="$4"
    if [ -f "${PROGNAME}" ]
    then
      (eval "${PROGNAME} ${PROGARGS}" 1>/dev/null 2>${LOGFILENAME} &)
      sleep 1
      PROCESSID=$(ps | grep "${PROGNAME}" | grep -v "grep" | sed 's/^[ ]*//g' | cut -d" " -f1)
      if [ -z "${PROCESSID}" ]
      then
        fatal=1
      else
        sleep 4
        RET0=$(leaks ${PROCESSID} 2>&1 | tee "${LOGFILENAME}2" | grep -E 'command not found|process does not exist|cannot examine process')
        RET1=$(echo "${RET0}" | grep "command not found")
        if [ ! -z "${RET1}" ]
        then
          fatal=2
        else
          RET1=$(echo "${RET0}" | grep -E "process does not exist|cannot examine process")
          if [ ! -z "${RET1}" ]
          then
            fatal=3
          fi
        fi
        check_kill_by_name "${PROGNAME}"
      fi
      if (( ${fatal} > 0 ))
      then
        case ${fatal} in
        1)
          printf "%s" "Failed to run your project"
        ;;
        2)
          printf "%s" "Command not found"
        ;;
        3)
          RET1=$(cat ${LOGFILENAME})
          echo "Your project has failed running enough time to check memory leak. Here is what was outputted.\n\n----------------------\n\n${RET1}" >${LOGFILENAME}
          printf "%s" "Failed to detect memory leaks"
        ;;
        esac
      else
        RET1=$(cat "${LOGFILENAME}2")
        echo "${NOTICE}${RET1}" >${LOGFILENAME}
        RET0=$(echo "${RET1}" | grep "0 leaks for 0 total leaked bytes")
        if [ -z "${RET0}" ]
        then
          RET0=$(echo "${RET1}" | grep "total leaked bytes" | cut -d":" -f2 | sed 's/^[ ]*//g' | sed 's/[. ]*$//g')
          if [ ! -z "${RET0}" ]
          then
            printf "%s" "${RET0}"
          else
            printf "%s" "Failed to detect memory leaks"
          fi
        else
          printf "%s" "0 leaks for 0 total leaked bytes"
          return 0
        fi
      fi
    else
      printf "%s" "Cannot compile"
    fi
    return 1
  }

fi;
