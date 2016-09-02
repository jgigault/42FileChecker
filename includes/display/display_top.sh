#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  function display_top
  {
    local LPATH="${1}" LHOME LEN PROJECTNAME

    PROJECTNAME="${2}"
    LHOME=`echo "${HOME}" | sed 's/\//\\\\\\//g'`
    LPATH="echo \"${LPATH}\" | sed 's/${LHOME}/~/'"
    LPATH=`eval ${LPATH}`
    printf "${C_WHITE}\n"
    if [ "${1}" != "" ]
    then
      (( LEN= ${COLUMNS} - 24 ))
      printf "  Current configuration:%"${LEN}"s\n" "${PROJECTNAME}  "
      printf "${C_CLEAR}  %s\n\n" "${LPATH}"
    else
      printf "  %s\n\n${C_CLEAR}" "${PROJECTNAME}"
    fi
  }

fi
