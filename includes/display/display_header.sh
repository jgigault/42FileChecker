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
    if [ "${GLOBAL_LOCALBRANCH}" != "master" ]
    then
      display_leftandright "${COLOR}" "${COLOR}" "${COLOR}" "DEVELOPMENT MODE" "${GLOBAL_LOCALBRANCH}"
    else
      if [ "${DISK_USAGE}" -gt "100" ]
      then
        display_leftandright "${C_INVERTRED}" "${COLOR}" "${COLOR}" "DISK USAGE: ${DISK_USAGE}M" "PRESS ESCAPE TO EXIT - V1.r${GLOBAL_CVERSION}"
      else
        display_leftandright "${COLOR}" "${COLOR}" "${COLOR}" "DISK USAGE: ${DISK_USAGE}M" "PRESS ESCAPE TO EXIT - V1.r${GLOBAL_CVERSION}"
      fi
    fi
    printf "${COLOR}"
    display_center "  _  _  ____  _____ _ _       ____ _               _              "
    display_center " | || ||___ \|  ___(_) | ___ / ___| |__   ___  ___| | _____ _ __  "
    display_center " | || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ __| |/ / _ \ '__| "
    display_center " |__   _/ __/|  _| | | |  __/ |___| | | |  __/ (__|   <  __/ |    "
    display_center "    |_||_____|_|   |_|_|\___|\____|_| |_|\___|\___|_|\_\___|_|    "
    display_center "                     https://github.com/jgigault/42FileChecker    "
    display_center " "
    printf "${C_CLEAR}"
  }

fi
