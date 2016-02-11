#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  function exit_checker
  {
    utils_before_exit
    cd "${GLOBAL_ENTRYPATH}"
    exit
  }

  function utils_before_exit
  {
    printf "\n\n\n\n\033[0m"
    tput cnorm
    tput rmcup
  }

fi
