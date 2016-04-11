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
        printf ${C_GREEN}"  All files were found"${C_CLEAR}
      else
        if (( ${TOTAL} == 1 ))
        then
          printf ${C_RED}"  1 file is missing"${C_CLEAR}
        else
          printf ${C_RED}"  $TOTAL files are missing"${C_CLEAR}
        fi
      fi
    else
      printf ${C_RED}"  An error occured (Files list missing)"${C_CLEAR}
    fi
  }

fi
