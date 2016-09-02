#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  function check_external_repository_42shelltester
  {
    local LOGFILENAME="${1}" BINARY="${2}" FILTER="${3}" TOTAL FAILED SUCCESS

    ${CMD_RM} -f "${LOGFILENAME}"
    if [ -d "${EXTERNAL_REPOSITORY_42SHELLTESTER_DIR}" ]
    then
      printf "%s\n%s\n\n%s\n\n%s\n%s\n\n%s\n\n\n\n\n" \
        "These tests are provided by the script 42ShellTester:" \
        "https://github.com/42shTests/42ShellTester" \
        "Feel free to make an issue on this repository if something goes wrong with your Shell implementation." \
        "Here is the log file obtained with the following command:" \
        "-> bash ./42ShellTester.sh \"${BINARY}\" --all --filter \"${FILTER}\"" \
        "----------------------------------------------------------------" \
        >"${LOGFILENAME}"
      (bash "${EXTERNAL_REPOSITORY_42SHELLTESTER_DIR}/42ShellTester.sh" "${BINARY}" --all --filter "${FILTER}" 1>>"${LOGFILENAME}" 2>&1)
      check_cleanlog "${LOGFILENAME}"
      TOTAL="$(awk '$0 ~ /^Total tests:/ {printf $3}' "${LOGFILENAME}")"
      if [ "${TOTAL}" == "" ]
      then
        printf "%s" "An error occured"
      else
        FAILED="$(awk '$0 ~ /^Total failed tests:/ {printf $4}' "${LOGFILENAME}")"
        (( SUCCESS= "${TOTAL}" - "${FAILED}" ))
        if [ "${FAILED}" == "0" ]
        then
          printf "%s" "All tests passed (${TOTAL} test(s))"
          return 0
        else
          printf "%s" "${FAILED} failed test(s) (${TOTAL} test(s))"
        fi
      fi
      return 1
    else
      printf "%s" "'42ShellTester' is not installed"
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

fi
