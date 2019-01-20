#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  function display_header
  {
    local MARGIN COLOR

    check_set_env
    [ "${GLOBAL_IS_INTERACTIVE}" == "0" ] && return
    utils_clear
    if [ "${1}" != "" ]
    then
      COLOR="${1}"
    else
      COLOR="${C_INVERT}"
    fi
    printf "${COLOR}"
    display_center " "
    printf "${C_CLEAR}"
    if [ "${GLOBAL_LOCALBRANCH}" != "master" ]
    then
      display_leftandright "${COLOR}" "${COLOR}" "${COLOR}" "  42FILECHECKER - DEVELOPMENT MODE" "${GLOBAL_LOCALBRANCH}  "
    else
      if [ "${DISK_USAGE}" -gt "100" ]
      then
        display_leftandright "${COLOR}" "${COLOR}" "${C_INVERTRED}" "  42FILECHECKER - V1.r${GLOBAL_CVERSION}" "  PRESS ESCAPE TO EXIT - DISK USAGE: ${DISK_USAGE}M  "
      else
        display_leftandright "${COLOR}" "${COLOR}" "${COLOR}" "  42FILECHECKER - V1.r${GLOBAL_CVERSION}" "PRESS ESCAPE TO EXIT - DISK USAGE: ${DISK_USAGE}M  "
      fi
    fi
    printf "${COLOR}"
    display_center " "
    printf "${C_CLEAR}"
  }

fi
