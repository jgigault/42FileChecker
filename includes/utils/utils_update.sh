#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function utils_update
  {
    local RET0
    tput civis
    ${CMD_RM} -f .myret
    check_update_42filechecker
    RET0=`cat .myret`
    case "$RET0" in
      "exit") utils_exit; return 1 ;;
      "nothing") utils_before_exit; return 1 ;;
    esac
    return 0
  }

  function check_update_42filechecker
  {
    [ "${OPT_NO_UPDATE}" != "0" -o "${GLOBAL_LOCALBRANCH}" != "master" ] && printf "continue" > .myret && return
    local UPTODATE MOULIDATE VERSION RET0 RET1 LOCALHASH REMOTEHASH
    display_header
    printf "\n"
    printf "  Checking for updates (42FileChecker)...\n"
    (check_for_updates_42filechecker > .myret) &
    display_spinner $!
    UPTODATE=`cat .myret`
    case "${UPTODATE}" in
    "1")
      printf "continue" > .myret
    ;;
    "3")
      display_header "$C_INVERTRED"
      printf "\n  Cannot check for updates: Your Internet connection is probably down...\n\n"$C_CLEAR
      display_menu\
        "$C_INVERTRED"\
        "check_update_set_return continue" "SKIP UPDATE"\
        "check_update_set_return exit" "EXIT"
    ;;
    "0")
      LOCALHASH=`git show-ref | grep "refs/heads/${GLOBAL_LOCALBRANCH}" | cut -d" " -f1`
      REMOTEHASH=`git ls-remote 2>/dev/null | grep refs/heads/${GLOBAL_LOCALBRANCH} | cut -f1`
      VERSION=$(git log --oneline "refs/remotes/origin/${GLOBAL_LOCALBRANCH}" | awk 'END {print NR}')
      display_header "$C_INVERTRED"
      printf "\n"
      printf $C_RED""
      if [ "${REMOTEHASH}" != "${LOCALHASH}" -a "${REMOTEHASH}" != "" -a "${GLOBAL_CVERSION}" -lt "${VERSION}" ]
      then
        display_center "Your version of '42FileChecker' is out-of-date."
        display_center "REMOTE: r$VERSION       LOCAL: r${GLOBAL_CVERSION}"
        RET1=`git log --pretty=oneline "refs/remotes/origin/${GLOBAL_LOCALBRANCH}" 2>/dev/null | awk -v lhash=${LOCALHASH} '{if ($1 == lhash) {exit} print}' | cut -d" " -f2- | awk 'BEGIN {LIMIT=0} {print "  -> "$0; LIMIT+=1; if(LIMIT==10) {print "  -> (limited to 10 last commits...)"; exit}}'`
        if [ "$RET1" != "" ]
        then
          printf "\n\n  Most recent commits:\n%s" "$RET1"
        fi
      else
        display_center "Your copy of '42FileChecker' has been modified locally."
        display_center "Skip update if you don't want to erase your changes."
      fi
      printf "\n  Choose UPDATE 42FILECHECKER (1) to install the latest version or skip this warning by choosing SKIP UPDATE (2) or by using '--no-update' at launch.\n\n"$C_CLEAR
      display_menu\
        "$C_INVERTRED"\
        check_install_42filechecker "UPDATE 42FILECHECKER"\
        "check_update_set_return continue" "SKIP UPDATE"\
        "check_update_set_return exit" "EXIT"
    ;;
    esac
  }

  function check_update_external_repository
  {
    local MOULIDATE
    local REPONAME=$1
    local URL=$2
    local DIR=$3
    display_header
    printf "\n"
    printf "  Checking for updates (${REPONAME})...\n"
    (check_for_updates_external_repository ${DIR} > .myret) &
    display_spinner $!
    MOULIDATE=`cat .myret`
    case "${MOULIDATE}" in
    "1")
      printf "continue" > .myret
    ;;
    "3")
      display_header "$C_INVERTRED"
      printf "\n  Cannot check for updates: Your Internet connection is probably down...\n\n"$C_CLEAR
      [ "${GLOBAL_IS_INTERACTIVE}" == "0" ] && utils_exit
      display_menu\
        "$C_INVERTRED"\
        "check_update_set_return continue" "SKIP UPDATE"\
        "check_update_set_return exit" "EXIT"
    ;;
    "0")
      [ "${GLOBAL_IS_INTERACTIVE}" == "0" ] && check_install_external_repository ${REPONAME} ${URL} ${DIR} && return
      display_header "$C_INVERTRED"
      printf "\n"
      printf $C_RED"  Your version of '${REPONAME}' (${URL}) is out-of-date.\n  Choose UPDATE EXTERNAL REPOSITORY (1) to install the latest version or SKIP UPDATE (2) if you want to skip this warning.\n\n"$C_CLEAR
      display_menu\
        "$C_INVERTRED"\
        "check_install_external_repository ${REPONAME} ${URL} ${DIR}" "UPDATE EXTERNAL REPOSITORY"\
        "check_update_set_return continue" "SKIP UPDATE"\
        "check_update_set_return exit" "EXIT"
    ;;
    "2")
      [ "${GLOBAL_IS_INTERACTIVE}" == "0" ] && check_install_external_repository ${REPONAME} ${URL} ${DIR} && return
      display_header "$C_INVERTRED"
      printf "\n"
      printf $C_RED"  The '${REPONAME}' (${URL}) is not installed.\n  Choose INSTALL EXTERNAL REPOSITORY (1) to install it or SKIP INSTALL (2) if you want to skip this warning.\n\n"$C_CLEAR
      display_menu\
        "$C_INVERTRED"\
        "check_install_external_repository ${REPONAME} ${URL} ${DIR}" "INSTALL EXTERNAL REPOSITORY"\
        "check_update_set_return continue" "SKIP INSTALL"\
        "check_update_set_return exit" "EXIT"
    ;;
    esac
  }

  function check_for_updates_42filechecker
  {
    local DIFF0
    DIFF0=`git fetch --all 2>&1 | tee .myret2 | grep fatal`
    if [ "$DIFF0" != "" ]
    then
      printf "3"
    else
      DIFF0=`git diff "refs/remotes/origin/${GLOBAL_LOCALBRANCH}" 2>&1 | grep -E '^\+|^\-' | sed 's/\"//'`
      if [ "$DIFF0" != "" ]
      then
        printf "0"
      else
        printf "1"
      fi
    fi
  }

  function check_install_42filechecker
  {
    local RES0
    local LOGFILENAME=".myret"
    display_header
    printf "\n"
    printf "  Updating 42FileChecker\n"
    ${CMD_RM} -f ${LOGFILENAME}
    (git fetch --all >/dev/null 2>&1) &
    display_spinner $!
    (git reset --hard "origin/master" 2>&1 | grep -v 'HEAD is now at' >${LOGFILENAME}) &
    display_spinner $!
    RES0=`cat ${LOGFILENAME}`
    sleep 0.5
    if [ "${RES0}" == "" ]
    then
      printf ${C_BLUE}"  Done.\n"${C_CLEAR}
      (git shortlog -s | awk 'BEGIN {rev=0} {rev+=$1} END {printf rev"\n"}' >.myrev 2>/dev/null) &
      display_spinner $!
      sleep 0.5
      sh ./42FileChecker.sh
    else
      display_error "An error occured."
      printf ${C_RED}"\n  If the error persists, try discard this directory and clone again.\n"${C_CLEAR}
      tput cnorm
    fi
    check_update_set_return "nothing"
  }

  function check_for_updates_external_repository
  {
    local DIFF0 LOCALBRANCH
    local DIR=$1
    if [ ! -d "${DIR}" ]
    then
      printf "2"
    else
      cd "${DIR}"
      LOCALBRANCH=$(git branch | awk '$0 ~ /^\*/ {print $2}')
      DIFF0=`git fetch --all 2>&1 | grep fatal`
      if [ "$DIFF0" != "" ]
      then
        printf "3"
      else
        DIFF0=`git diff "refs/remotes/origin/${LOCALBRANCH}" 2>&1 | grep -E '^\+|^\-' | sed 's/\"//'`
        if [ "$DIFF0" != "" ]
        then
          printf "0"
        else
          printf "1"
        fi
      fi
      cd ..
    fi
  }


  function check_install_external_repository
  {
    local RES0 RES2 REPONAME="${1}" URL="${2}" DIR="${3}" LOCALBRANCH
    display_header
    printf "\n"
    if [ ! -d "${DIR}" ]
    then
      printf "  Installing ${REPONAME}...\n"
      (git clone "${URL}" "${DIR}" >.myret 2>&1) &
      display_spinner $!
    else
      cd "${DIR}"
      LOCALBRANCH=$(git branch | awk '$0 ~ /^\*/ {print $2}')
      printf "  Updating ${REPONAME}...\n"
      (git reset --hard "origin/${LOCALBRANCH}" 1>../.myret 2>&1) &
      display_spinner $!
      cd ..
    fi
    RES0=`cat .myret`
    RES2=`echo "$RES0" | grep fatal`
    if [ "$RES2" != "" ]
    then
      display_error "An error occured."
      printf $C_RED"$(echo "$RES0" | awk 'BEGIN {OFS=""} {print "  ",$0}')"$C_CLEAR
      printf "\n"
      sleep 5
      check_update_set_return "nothing"
    else
      printf $C_BLUE"  Done.\n"$C_CLEAR
      sleep 0.5
      check_update_set_return "continue"
    fi
  }

  function check_update_set_return
  {
    printf "${1}" > .myret
    LOCAL_UPDATE_RETURN="${1}"
  }

fi
