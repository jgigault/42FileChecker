#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  function display_leftandright
  {
    local COLORLEFT="${1}" COLORCENTER="${2}" COLORRIGHT="${3}" TEXTLEFT="${4}" TEXTRIGHT="${5}" LEN
    LEN="$(( ${COLUMNS} - ${#TEXTLEFT} - ${#TEXTRIGHT} ))"
    printf "${COLORLEFT}%s${COLORCENTER}% ${LEN}s${COLORRIGHT}%s${C_CLEAR}\n" "${TEXTLEFT}" " " "${TEXTRIGHT}"
  }

fi
