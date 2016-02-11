#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  declare CURRENT_CHILD_PROCESS_PID=""

  function catch_signals
  {
    trap "utils_do_sigint" SIGINT
  }

  function utils_do_sigint
  {
    if [ "${CURRENT_CHILD_PROCESS_PID}" != "" ]
    then
      kill -0 "${CURRENT_CHILD_PROCESS_PID}" 2>/dev/null && kill "${CURRENT_CHILD_PROCESS_PID}" 2>/dev/null
      wait $! 2>/dev/null
      display_error "killed pid: ${CURRENT_CHILD_PROCESS_PID}"
      if [ "${1}" != "" ]
      then
        eval "${1}"
      fi
    fi
  }

fi
