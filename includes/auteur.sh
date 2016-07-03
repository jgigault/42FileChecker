#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function check_author
  {
    local OPTIONAL="${1}"
    if [ "${OPT_NO_AUTEUR}" == "0" ]
    then
      local AUTHORF AUTHORC AUTHORE AUTHORD
      AUTHORF="${MYPATH}/auteur"
      if [ ! -f "${AUTHORF}" ]
      then
        if [ "${OPTIONAL}" == "optional" ]
        then
          printf "${C_GREY}  %s${C_CLEAR}" "File not found (optional)"
        else
          printf "${C_RED}  %s${C_CLEAR}" "File not found"
        fi
      else
        AUTHORC=`cat -e "${AUTHORF}" | awk '{if (NR == 1) print}'`
        AUTHORE=`cat -e "${AUTHORF}" | awk '$0 ~ /\\$\$/ {print}'`
        AUTHORD=`awk 'END {printf NR}' "${AUTHORF}"`
        if [ ${AUTHORD} -eq 1 ]
        then
          if [ "${AUTHORE}" != "${AUTHORC}" ]
          then
            if [ "${OPTIONAL}" == "optional" ]
            then
              printf "${C_GREY}  %s${C_CLEAR}"  "Missing <newline> character at the end of line (optional)"
            else
              printf "${C_RED}  %s${C_CLEAR}"  "Missing <newline> character at the end of line"
            fi
          else
            printf "${C_GREEN}  %s${C_CLEAR}" "${AUTHORC}"
          fi
        else
          if [ "${OPTIONAL}" == "optional" ]
          then
            printf "${C_GREY}  %s${C_CLEAR}"  "Empty file or too much lines in the file (optional)"
          else
            printf "${C_RED}  %s${C_CLEAR}"  "Empty file or too much lines in the file"
          fi
        fi
      fi
    else
      printf "${C_GREY}  %s${C_CLEAR}" "--Not performed--"
    fi
  }

fi
