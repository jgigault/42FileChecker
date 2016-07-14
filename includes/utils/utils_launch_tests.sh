#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function utils_launch_tests
  {
    local TESTONLY="${1}" TESTSARRAY="${2}" ELEM LOCAL_EXIT_STATUS i j k

    i=0
    j=1
    k=0
    while [ 1 ]
    do
      ELEM="${TESTSARRAY}[$i]"
      FUNC="${!ELEM}"
      [ "${FUNC}" == "" ] && break
      (( i += 1 ))
      ELEM="${TESTSARRAY}[$i]"
      TITLE="${!ELEM}"
      if [ "${TESTONLY}" == "" -o "${TESTONLY}" == "${k}" ]
      then
        [ "${GLOBAL_IS_INTERACTIVE}" == "1" ] && tput sc && printf "%s\n" "  $(ft_itoa "${j}") -> ${TITLE}"
        (eval "${FUNC}" > .myret) &
        display_spinner $!
        LOCAL_EXIT_STATUS="${?}"
        [ "${GLOBAL_IS_INTERACTIVE}" == "1" ] && tput el1 && tput rc
        case "${LOCAL_EXIT_STATUS}" in
          0)
            display_leftandright "${C_GREEN}" "" "${C_GREEN}" "  $(ft_itoa "${j}") -> ${TITLE}" "$(cat .myret)  "
            ;;
          2)
            display_leftandright "${C_GREEN}" "" "${C_GREEN}" "  $(ft_itoa "${j}") -> ${TITLE}" "$(cat .myret)  "
            ;;
          255)
            display_leftandright "${C_GREY}" "" "${C_GREY}" "  $(ft_itoa "${j}") -> ${TITLE}" "$(cat .myret)  "
            ;;
          *)
            display_leftandright "${C_RED}" "" "${C_RED}" "  $(ft_itoa "${j}") -> ${TITLE}" "$(cat .myret)  "
            GLOBAL_EXIT_STATUS="${LOCAL_EXIT_STATUS}"
            ;;
        esac
      else
        display_leftandright "${C_GREY}" "" "${C_GREY}" "  $(ft_itoa "${j}") -> ${TITLE}" "Not performed  "
      fi
      (( j += 1 ))
      (( i += 1 ))
      (( k += 1 ))
    done
    printf "\n"
    [ "${GLOBAL_IS_INTERACTIVE}" == "0" ] && utils_exit
  }

fi
