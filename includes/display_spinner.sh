#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  function display_spinner
  {
    local pid=$1 total_delay=0 total_delay2=65 delay=0.2 spinstr='|/-\' SEL
    CURRENT_CHILD_PROCESS_PID="${pid}"
    printf "${C_BLUE}"
    while [ "$(ps a | awk -v pid="${pid}" '$1 == pid {print $1}')" ];
    do
      if (( $total_delay2 < 1 ))
      then
        kill $pid 2>/dev/null
        wait $! 2>/dev/null
        (( total_delay2 = $total_delay ))
        printf $C_RED"  Time out ($total_delay2 sec)"$C_CLEAR > $RETURNPATH/.myret
      fi
      if [ "$OPT_NO_TIMEOUT" == "0" ]
      then
        (( total_delay += 1 ))
      fi
      local temp=${spinstr#?}
      printf "  [%c] " "$spinstr"
      local spinstr=$temp${spinstr%"$temp"}
      if (( $total_delay >= 5 ))
      then
        (( total_delay2 = 100 - $total_delay ))
        printf "[time out: %02d]" "$total_delay2"
      fi
      SEL=""
      read -s -t 1 -n 1 SEL
      SEL=$(display_menu_get_key $SEL)
      if [ "$SEL" == "ESC" ]
      then
        utils_do_sigint "exit_checker"
      fi
      printf "\b\b\b\b\b\b"
      if (( $total_delay >= 5 ))
      then
        printf "\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
      fi
    done
    printf "                     \b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b${C_CLEAR}"
    CURRENT_CHILD_PROCESS_PID=""
  }

fi
