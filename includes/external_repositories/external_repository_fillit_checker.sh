#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  function check_fillit_checker
  {
    local LOGFILENAME="${1}" PROJECTPATH="${2}" SUCCESS TOTAL FAILED

    ${CMD_RM} -f "${LOGFILENAME}"
    if [ -d "${EXTERNAL_REPOSITORY_FILLITCHECKER_DIR}" ]
    then
      (sh "${EXTERNAL_REPOSITORY_FILLITCHECKER_DIR}/test.sh" "${PROJECTPATH}" 1>"${LOGFILENAME}" 2>&1)
      check_cleanlog "${LOGFILENAME}"
      RET="$(awk '$0 ~ /^NOTE: [0-9]{1,2}[ ]?\/[ ]?[0-9]{1,2}$/ {gsub(/\//, " / "); printf $2 " " $4}' "${LOGFILENAME}")"
      if [ "${RET}" == "" ]
      then
        printf "%s" "An error occured"
      else
        SUCCESS="${RET% *}"
        TOTAL="${RET#* }"
        (( FAILED= "${TOTAL}" - "${SUCCESS}" ))
        if [ "${FAILED}" == "0" ]
        then
          printf "%s" "All tests passed (${TOTAL} tests)"
          return 0
        else
          printf "%s" "${FAILED} failed test(s) out of ${TOTAL} tests"
        fi
      fi
      return 1
    else
      printf "%s" "'fillit_checker' is not installed"
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

fi
