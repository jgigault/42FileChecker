#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  function utils_exit
  {
    utils_before_exit
    cd "${GLOBAL_ENTRYPATH}"
    exit "${GLOBAL_EXIT_STATUS}"
  }

  function utils_before_exit
  {
    printf "\n\n\033[0m"
    tput cnorm
    [ "${GLOBAL_IS_INTERACTIVE}" == "1" ] && tput rmcup
  }

fi
