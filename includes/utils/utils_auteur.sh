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
          printf "%s" "File not found (optional)"
          return 2
        else
          printf "%s" "File not found"
          return 1
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
              printf "%s" "Missing <newline> character at the end of line (optional)"
              return 2
            else
              printf "%s" "Missing <newline> character at the end of line"
              return 1
            fi
          else
            printf "%s" "${AUTHORC}"
            return 0
          fi
        else
          if [ "${OPTIONAL}" == "optional" ]
          then
            printf "%s" "Empty file or too much lines in the file (optional)"
            return 2
          else
            printf "%s" "Empty file or too much lines in the file"
            return 1
          fi
        fi
      fi
    fi
    return 255
  }

fi
