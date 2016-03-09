#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function check_author
  {
    if [ "${OPT_NO_AUTEUR}" == "0" -a "${1}" != "optional" ]
    then
      local AUTHORF AUTHORC AUTHORE
      AUTHORF="${MYPATH}/auteur"
      if [ ! -f "${AUTHORF}" ]
      then
        printf "${C_RED}  %s${C_CLEAR}" "File not found"
      else
        AUTHORC=`cat -e "${AUTHORF}" | awk '{if (NR == 1) print}'`
        AUTHORE=`cat -e "${AUTHORF}" | awk '$0 ~ /\\$\$/ {print}'`
        if [ "${AUTHORE}" != "${AUTHORC}" ]
        then
          printf "${C_RED}  %s${C_CLEAR}"  "No [Line Feed] character at the end of line"
        else
          printf "${C_GREEN}  %s${C_CLEAR}" "${AUTHORC}"
        fi
      fi
    else
      printf "${C_GREY}  %s${C_CLEAR}" "--Not performed--"
    fi
  }

fi
