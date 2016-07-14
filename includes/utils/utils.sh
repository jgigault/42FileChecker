#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function check_set_env
  {
    COLUMNS=`tput cols`
    if [ "${COLUMNS}" == "" ]
    then
      COLUMNS=80
    fi
    DISK_USAGE="$(du -ms | awk '$2 == "." {print $1}')"
  }

  function check_set_colors
  {
    if [ "$OPT_NO_COLOR" == "0" ]
    then
      C_BLACKBG="\033[40m\033[37m"
      C_CLEAR="\033[0m"$C_BLACKBG
      C_YELLOW=$C_BLACKBG"\033[33;1m"
      C_RED=$C_BLACKBG"\033[31m\033[38;5;160m"
      C_GREEN=$C_BLACKBG"\033[32m\033[38;5;70m"
      C_CYAN=$C_BLACKBG"\033[36;1m"
      C_WHITE=$C_BLACKBG"\033[37;1m"
      C_BLUE=$C_BLACKBG"\033[34;1m"
      C_GREY=$C_BLACKBG"\033[1;30m"
      C_GREY=$C_BLACKBG"\033[38;5;239m"
      C_BLACK="\033[30;1m"
      C_INVERT="\033[48;5;17m""\033[38;5;104m"
      C_INVERTGREY="\033[48;5;233m""\033[38;5;95m"
      C_INVERTRED="\033[48;5;88m""\033[38;5;107m"
    else
      C_BLACKBG=
      C_CLEAR="\033[0m"
      C_YELLOW=
      C_RED=
      C_GREEN=
      C_CYAN=
      C_WHITE=
      C_BLUE=
      C_GREY=
      C_GREY=
      C_BLACK=
      C_INVERT=
      C_INVERTGREY=
      C_INVERTRED=
    fi
  }

  CMD_RM=/bin/rm
  CMD_TOUCH=/usr/bin/touch
  CMD_GCC=/usr/bin/gcc
  MOULITEST_URL="https://github.com/yyang42/moulitest_42projects"
  MOULITEST_DIR="moulitest_42projects"
  LIBFTUNITTEST_URL="https://github.com/alelievr/libft-unit-test"
  LIBFTUNITTEST_DIR="libft-unit-test"
  EXTERNAL_REPOSITORY_FILLITCHECKER_URL="https://github.com/anisg/fillit_checker"
  EXTERNAL_REPOSITORY_FILLITCHECKER_DIR="fillit_checker"
  EXTERNAL_REPOSITORY_MAINTEST_URL="https://github.com/QuentinPerez/Maintest"
  EXTERNAL_REPOSITORY_MAINTEST_DIR="maintest"
  EXTERNAL_REPOSITORY_42SHELLTESTER_URL="https://github.com/we-sh/42ShellTester"
  EXTERNAL_REPOSITORY_42SHELLTESTER_DIR="42ShellTester"

  CONF_TIMEOUT_MAX=100

  function check_option_set
  {
    case "$1" in
      "OPT_NO_TIMEOUT")
        if [ "$OPT_NO_TIMEOUT" == 1 ]; then OPT_NO_TIMEOUT=0; else OPT_NO_TIMEOUT=1; fi
        ;;
      "OPT_NO_NORMINETTE")
        if [ "$OPT_NO_NORMINETTE" == 1 ]; then OPT_NO_NORMINETTE=0; else OPT_NO_NORMINETTE=1; fi
        ;;
      "OPT_NO_SPEEDTEST")
        if [ "$OPT_NO_SPEEDTEST" == 1 ]; then OPT_NO_SPEEDTEST=0; else OPT_NO_SPEEDTEST=1; fi
        ;;
      "OPT_NO_LEAKS")
        if [ "$OPT_NO_LEAKS" == 1 ]; then OPT_NO_LEAKS=0; else OPT_NO_LEAKS=1; fi
        ;;
      "OPT_NO_MOULITEST")
        if [ "$OPT_NO_MOULITEST" == 1 ]; then OPT_NO_MOULITEST=0; else OPT_NO_MOULITEST=1; fi
        ;;
      "OPT_NO_COLOR")
        if [ "$OPT_NO_COLOR" == 1 ]; then OPT_NO_COLOR=0; else OPT_NO_COLOR=1; fi
        check_set_colors
        ;;
    esac
    main
  }

  function display_error
  {
    echo $C_RED"  !!! $1 !!!"$C_CLEAR
  }

  function display_hr
  {
    local MARGIN
    (( MARGIN= $COLUMNS ))
    if [ "$1" == "" ]
    then
      printf $C_GREY""
    else
      printf "$1"
    fi
    printf "%"$MARGIN"s" "" | sed s/' '/"${c:=_}"/g | cut -c1-$MARGIN
    printf "$C_CLEAR"
  }

  function display_hr2
  {
    local MARGIN
    (( MARGIN= $COLUMNS ))
    printf $C_GREY""
    printf "%"$MARGIN"s" "" | sed s/' '/"${c:=¯ }"/g | cut -c1-$MARGIN
    printf $C_CLEAR""
    if [ "$1" != "" ]
    then
      echo "$1";
    fi
  }

  function display_righttitle
  {
    local LEN MARGIN
    if [ "$1" != "" ]
    then
      LEN=${#1}
      if [ ! -z $2 ]
      then
        (( MARGIN= $COLUMNS - $LEN - $2))
      else
        (( MARGIN= $COLUMNS - $LEN))
      fi
      printf "%"$MARGIN"s" " "
      printf "$1\n"
    else
      printf "\n"
    fi
  }

  function display_footer
  {
    echo $C_WHITE""
    printf "%"$COLUMNS"s" "" | sed s/' '/"${c:=#}"/g | cut -c1-$COLUMNS
    echo $C_CLEAR""
  }

  function ft_itoa
  {
    local -i i=$1
    if [ "$1" != "1" -a "$1" != "2" -a "$1" != "3" -a "$1" != "4" -a "$1" != "5" -a "$1" != "6" -a "$1" != "7" -a "$1" != "8" -a "$1" != "9" ]
    then
      (( i=$1 + 65 - 10 ))
      printf \\$(printf '%03o' $i)
    else
      printf "$1"
    fi
  }

  function ft_atoi
  {
    local SELN
    if [ "$1" == "NULL" ]
    then
      printf "0"
    else
      if [ "$1" != "1" -a "$1" != "2" -a "$1" != "3" -a "$1" != "4" -a "$1" != "5" -a "$1" != "6" -a "$1" != "7" -a "$1" != "8" -a "$1" != "9" ]
      then
        SELN=`LC_CTYPE=C printf '%d' "'$1"`
        if (( $SELN >= 65 )) && (( $SELN <= 90 ))
        then
          (( SELN=$SELN - 65 + 10 ))
          printf "$SELN"
        else
          if (( $SELN >= 97 )) && (( $SELN <= 122 ))
          then
            (( SELN=$SELN - 97 + 10 ))
            printf "$SELN"
          else
            printf "0"
          fi
        fi
      else
        printf "$1"
      fi
    fi
  }

  function get_config
  {
    local MYFILE LPATH RET0
    MYFILE=`printf "$RETURNPATH/.my$1" | sed 's/ /\\ /g'`
    if [ ! -f "$MYFILE" ]
    then
      touch "$MYFILE"
    fi
    LPATH=`cat "$MYFILE"`
    if [ ! -d "$LPATH" ]
    then
      printf "" > "$MYFILE"
      LPATH=""
    fi
    printf "$LPATH"
  }

  function save_config
  {
    local MYFILE RET0
    MYFILE=".my$1"
    RET0=`printf "$RETURNPATH/$MYFILE" | sed 's/ /\\ /g'`
    RET0=`echo "printf \"$2\" > \"$RET0\""`
    eval $RET0
  }

  function check_create_tmp_dir
  {
    if [ ! -d "$RETURNPATH"/tmp ]
    then
      mkdir "$RETURNPATH"/tmp
    else
      rm -rf "$RETURNPATH"/tmp/*
    fi
  }

  function check_kill_by_name
  {
    local PROCESSID PROCESSID0 PROGNAME PROCESSCOUNT
    PROGNAME="$1"
    if [ "$PROGNAME" != "" ]
    then
      PROCESSID=`ps | grep "$1" | grep -v "grep" | sed 's/^[ ]*//g' | cut -d" " -f1`
      if [ "$PROCESSID" != "" ]
      then
        PROCESSCOUNT=`echo "$PROCESSID" | awk 'END {print NR}'`
        while (( $PROCESSCOUNT > 0 ))
        do
          (( PROCESSCOUNT -= 1 ))
          PROCESSID0=`echo "$PROCESSID" | awk '{print; exit}'`
          kill $PROCESSID0
          wait $! 2>/dev/null
        done
      fi
    fi
  }

  function utils_clear
  {
    printf "${C_CLEAR}\n\n"
    [ "${GLOBAL_IS_INTERACTIVE}" == "0" ] && return
    tput cup 0 0
    tput cd
  }

  function check_cleanlog
  {
    local RET0 LOGFILENAME
    LOGFILENAME="$1"
    if [ -f "$LOGFILENAME" ]
    then
      RET0=`cat -e "$LOGFILENAME" | awk '{gsub(/\^M.*\^M/, ""); gsub(/\^@/, ""); gsub(/\^[\[]*[0-9;]*[MmHJ]/, "");  gsub(/[\$]$/, ""); print}'`
      echo "$RET0" > "$LOGFILENAME"
    fi
  }

fi
