#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function check_author
  {
    local OPTIONAL="${1}"

    if [ "${OPT_NO_AUTEUR}" == "0" ]
    then
      local AUTHORFR AUTHORUS AUTHORFILE AUTHORC AUTHORE AUTHORD
      AUTHORFR="${MYPATH}/auteur"
      AUTHORUS="${MYPATH}/author"
      if [ ! -f "${AUTHORFR}" -a ! -f "${AUTHORUS}" ]
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
        [ -f "${AUTHORFR}" ] && AUTHORFILE="${AUTHORFR}" || AUTHORFILE="${AUTHORUS}"
        AUTHORC=`cat -e "${AUTHORFILE}" | awk '{if (NR == 1) print}'`
        AUTHORE=`cat -e "${AUTHORFILE}" | awk '$0 ~ /\\$\$/ {print}'`
        AUTHORD=`awk 'END {printf NR}' "${AUTHORFILE}"`
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
