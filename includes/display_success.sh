#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  function display_success
  {
    printf "  ${C_GREEN}%s${C_CLEAR}"  "${1}"
  }

fi
