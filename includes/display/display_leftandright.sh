#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  function display_leftandright
  {
    local COLORLEFT="${1}" COLORCENTER="${2}" COLORRIGHT="${3}" TEXTLEFT="${4}" TEXTRIGHT="${5}" LEN

    LEN="$(( ${COLUMNS} - ${#TEXTLEFT} - ${#TEXTRIGHT} ))"
    if [ "${LEN}" -ge "0" ]
    then
      printf "${COLORLEFT}%s${COLORCENTER}% ${LEN}s${COLORRIGHT}%s${C_CLEAR}\n" "${TEXTLEFT}" " " "${TEXTRIGHT}"
    else
      printf "${COLORLEFT}%- ${COLUMNS}s\n${COLORRIGHT}% ${COLUMNS}s${C_CLEAR}\n" "${TEXTLEFT}" "${TEXTRIGHT}"
    fi
  }

fi
