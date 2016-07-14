#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  function display_spinner
  {
    local PID=$1 CURRENT_DELAY=0 DISPLAY_DELAY SPINSTR='|/-\' SEL TEMP

    CURRENT_CHILD_PROCESS_PID="${PID}"
    printf "${C_BLUE}"
    while [ "$(ps a | awk -v PID="${PID}" '$1 == PID {print $1}')" ];
    do
      (( DISPLAY_DELAY = ${CONF_TIMEOUT_MAX} - ${CURRENT_DELAY} ))
      if (( ${DISPLAY_DELAY} < 1 ))
      then
        kill ${PID} 2>/dev/null
        wait $! 2>/dev/null
        printf "${C_RED}  %s%3d%s${C_CLEAR}" "Time out (" "${CURRENT_DELAY}" " sec)" > "${RETURNPATH}/.myret"
        return "1"
      fi
      if [ "${OPT_NO_TIMEOUT}" == "0" ]
      then
        (( CURRENT_DELAY += 1 ))
      fi
      TEMP=${SPINSTR#?}
      printf "  [%c] " "${SPINSTR}"
      SPINSTR=${TEMP}${SPINSTR%"${TEMP}"}
      if (( ${CURRENT_DELAY} >= 5 ))
      then
        printf "[time out: % 3d]" "${DISPLAY_DELAY}"
      fi
      SEL=""
      read -s -t 1 -n 1 SEL
      SEL=$(display_menu_get_key ${SEL})
      if [ "${SEL}" == "ESC" ]
      then
        utils_do_sigint "utils_exit"
      fi
      if (( ${CURRENT_DELAY} >= 5 ))
      then
        printf "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
      else
        printf "\b\b\b\b\b\b"
      fi
    done
    printf "                     \b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b${C_CLEAR}"
    CURRENT_CHILD_PROCESS_PID=""
    wait ${PID} 2>/dev/null
    return "${?}"
  }

fi
