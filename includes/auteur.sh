#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function check_author
  {
    if [ "${OPT_NO_AUTEUR}" == "0" -a "${1}" != "optional" ]
    then
      local AUTHORF AUTHORC AUTHORE AUTHORD
      AUTHORF="${MYPATH}/auteur"
      if [ ! -f "${AUTHORF}" ]
      then
        printf "${C_RED}  %s${C_CLEAR}" "File not found"
      else
        AUTHORC=`cat -e "${AUTHORF}" | awk '{if (NR == 1) print}'`
        AUTHORE=`cat -e "${AUTHORF}" | awk '$0 ~ /\\$\$/ {print}'`
        AUTHORD=`awk 'END {printf NR}' "${AUTHORF}"`
        if [ ${AUTHORD} -eq 1 ]
        then
          if [ "${AUTHORE}" != "${AUTHORC}" ]
          then
            printf "${C_RED}  %s${C_CLEAR}"  "No [Line Feed] character at the end of line"
          else
            printf "${C_GREEN}  %s${C_CLEAR}" "${AUTHORC}"
          fi
        else
          printf "${C_RED}  %s${C_CLEAR}"  "Empty file or too much lines in the file"
        fi
      fi
    else
      printf "${C_GREY}  %s${C_CLEAR}" "--Not performed--"
    fi
  }

fi
