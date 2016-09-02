#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  function check_fileexists_one
  {
    if [ "`find "${2}" -name "${1}" 2>&-`" == "" ]
    then
      return 1
    fi
    return 0
  }

  function check_fileexists
  {
    local i TOTAL=0 RET0 VALPARAM RET1 LOCALPATH="${2}"
    if [ "${1}" != "" ]
    then
      i=0
      VALPARAM=`eval echo \$1[\$i]`
      while [ "${!VALPARAM}" != "" ]
      do
        check_fileexists_one "${!VALPARAM}" "${LOCALPATH}"
        if [ "${?}" != "0" ]
        then
          (( TOTAL += 1 ))
          RET0="${RET0}Not Found: ${!VALPARAM}\n"
        fi
        (( i += 1 ))
        VALPARAM=`eval echo \$1[\$i]`

      done
      printf "$RET0" >"${RETURNPATH}/.my${1}"
      if [ "$RET0" == "" ]
      then
        printf "%s" "All files were found"
        return 0
      else
        if (( ${TOTAL} == 1 ))
        then
          printf "%s" "1 file is missing"
        else
          printf "%s" "${TOTAL} files are missing"
        fi
      fi
    else
      printf "%s" "An error occured (Files list missing)"
    fi
    return 1
  }

fi
