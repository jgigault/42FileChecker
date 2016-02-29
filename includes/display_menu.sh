#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  function display_menu
  {
    local -a MENU FUNCS
    local TOTAL SEL LEN SELN TITLE i TESTSA TESTSI
    SEL=""
    if [ "$1" != "" ]
    then
      printf $1
    else
      printf $C_INVERT""
    fi
    shift 1
    printf "%"$COLUMNS"s" " "
    printf "\n"
    while (( $# > 0 ))
    do
      if [ "$1" == "_" ]
      then
        printf "%"$COLUMNS"s" " "
            printf "\n"
        shift 1
      else
        if [ "$1" == "TESTS" ]
        then
          i=2
          TESTSI=1
          TESTSA="$2[$i]"
          while [ "${!TESTSA}" != "" ]
          do
            (( TOTAL += 1 ))
            (( i++ ))
            TESTSA="$2[$i]"
            FUNCS[$TOTAL]="$3 $TESTSI RUN_ALONE"
            MENU[$TOTAL]="${!TESTSA}"
            (( i++ ))
            (( TESTSI++ ))
            TITLE=`echo "${!TESTSA}" | sed 's/%/%%/g'`
            if (( $TOTAL < 10 ))
            then
              SELN=$TOTAL
            else
              (( SELN=65 + $TOTAL - 10 ))
              SELN=`echo "$SELN" | awk '{printf("%c", $0)}'`
            fi
            (( LEN=$COLUMNS - ${#TITLE} - 9 ))
            printf "  "$SELN")    $TITLE "
            printf "%"$LEN"s" " "
            printf "\n"
            TESTSA="$2[$i]"
          done
          shift 3
        else
          (( TOTAL += 1 ))
          FUNCS[$TOTAL]="$1"
          MENU[$TOTAL]="$2"
          TITLE=`echo "$2" | sed 's/%/%%/g'`
          if (( $TOTAL < 10 ))
          then
            SELN=$TOTAL
          else
            (( SELN=65 + $TOTAL - 10 ))
            SELN=`echo "$SELN" | awk '{printf("%c", $0)}'`
          fi
          (( LEN=$COLUMNS - ${#TITLE} - 9 ))
          printf "  "$SELN")    $TITLE "
          printf "%"$LEN"s" " "
          printf "\n"
          shift 2
        fi
      fi
    done

    printf "%"$COLUMNS"s" " "
    printf $C_CLEAR"\n"
    read -r -s -n 1 SEL
    [ $? != 0 ] && exit_checker
    SEL=$(display_menu_get_key $SEL)
    if [ "$SEL" == "ESC" ]
    then
      exit_checker
    fi
    SEL=`ft_atoi "$SEL"`
    while [ -z "${MENU[$SEL]}" -o "$(echo "${FUNCS[$SEL]}" | grep '^open ')" != "" ]
    do
      printf "\a"
      if [ "$(echo "${FUNCS[$SEL]}" | grep '^open ')" != "" ]
      then
        if [ -f "$(echo "${FUNCS[$SEL]}" | sed 's/^open //')" -o "$(echo "${FUNCS[$SEL]}" | grep http)" != "" ]
        then
          eval ${FUNCS[$SEL]}
        fi
      fi
      SEL=""
      read -s -n 1 SEL
      [ $? != 0 ] && exit_checker
      SEL=$(display_menu_get_key $SEL)
      if [ "$SEL" == "ESC" ]
      then
        exit_checker
      fi
      SEL=`ft_atoi "$SEL"`
    done
    printf "\n"
    if [ "${FUNCS[$SEL]}" != "" ]
    then
      eval ${FUNCS[$SEL]}
    fi
  }

  function display_menu_get_key
  {
    local ord_value old_tty_settings
    ord_value=$(printf '%d' "'$1")
    if [[ $ord_value -eq 27 ]]; then
      old_tty_settings=`stty -g`
      stty -icanon min 0 time 0
      read -s key
      if [ $? != 0 ];then
        stty "$old_tty_settings"
        exit_checker
      fi
      if [[ ${#key} -eq 0 ]]
      then
        printf "ESC"
      else
        printf "NULL"
      fi
      stty "$old_tty_settings"
    else
      printf "%s" "$1"
    fi
  }

fi
