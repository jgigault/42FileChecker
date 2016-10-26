#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function check_configure
  {
    local AB0 AB2 MYPATH RETURNFUNC PROJECTNAME PROJECTNAME_DISPLAY STARTDIR OPTIONAL_AUTHORFILE="${4}"
    RETURNFUNC=$1
    PROJECTNAME=$2
    PROJECTNAME_DISPLAY=$3
    MYPATH=$(get_config "$PROJECTNAME")
    display_header
    display_top "$MYPATH" "${PROJECTNAME_DISPLAY}"
    printf "  Select a location where to find your project directory:\n\n"
    display_menu\
      ""\
      "check_configure_select HOME" "Home directory:       ~/"\
      "check_configure_select TMP" "Temporary directory:  /tmp"\
      "check_configure_select ROOT" "Root folder:          /"\
      "_"\
      "check_configure_select" "CANCEL"
    display_header
    display_top "$MYPATH" "${PROJECTNAME_DISPLAY}"
    if [ "$STARTDIR" != "*" ]
    then
      check_configure_read $RETURNFUNC $PROJECTNAME $PROJECTNAME_DISPLAY
      cd "$RETURNPATH"
      MYPATH=$(get_config "$PROJECTNAME")
      if [ "${STARTDIR}" != "*" -a ! -f "${MYPATH}/auteur" -a ! -f "${MYPATH}/author" -a "${OPTIONAL_AUTHORFILE}" != "optional" ]
      then
        display_header "$C_INVERTRED"
        display_top "$MYPATH" "${PROJECTNAME_DISPLAY}"
        printf ""$C_RED
        display_center "You selected the following folder:"
        display_center "$MYPATH"
        display_center "But this directory does not seem to be a project directory!"
        printf "\n\n"
        display_center "NO AUTHOR FILE WAS FOUND"
        printf "\n\n\n"$C_CLEAR
        display_menu\
          "$C_INVERTRED"\
          "$RETURNFUNC" "SKIP WARNING"\
          "check_configure $1 $2 $3" "RETRY"
      else
        $RETURNFUNC
      fi
    else
      $RETURNFUNC
    fi
  }

  function check_configure_select
  {
    case "$1" in
      'TMP')
        STARTDIR="/tmp"
        ;;
      'HOME')
        STARTDIR="$HOME"
        ;;
      'ROOT')
        STARTDIR=""
        ;;
      *)
        STARTDIR="*"
        ;;
    esac
  }

  function check_configure_read
  {
    local AB0 AB2 RETURNFUNC PROJECTNAME PROJECTNAME_DISPLAY
    RETURNFUNC=$1
    PROJECTNAME=$2
    PROJECTNAME_DISPLAY=$3
    printf "  Find your project directory by using the shell prompt and then press ENTER:\n  -> Use TAB to see what's inside the directories\n  -> Keep empty and press ENTER to cancel\n\n"$C_INVERTGREY
    cd "$STARTDIR/"
    ls
    printf "\n"$C_WHITE
    tput cnorm
    read -p "  $STARTDIR/" -e AB0
    tput civis
    if [ "$AB0" == "" ]
    then
      STARTDIR="*"
      return
    else
      AB0=`echo "$AB0" | sed 's/\/$//'`
      AB2="$STARTDIR/$AB0"
      while [ "$AB0" == "" -o ! -d "$AB2" ]
      do
        display_header
        display_top "$MYPATH" "$PROJECTNAME_DISPLAY"
        printf "  Find your project directory by using the shell prompt and then press ENTER:\n  -> Use TAB to see what's inside the directories\n  -> Keep empty and press ENTER to cancel\n\n"$C_INVERTGREY
        ls
        printf "\n"$C_WHITE
        if [ "$AB0" != "" ]
        then
          printf $C_RED"  $AB2: No such file or directory\n"$C_CLEAR$C_WHITE
        else
          printf $C_WHITE""
        fi
        tput cnorm
        read -p "  $STARTDIR/" -e AB0
        tput civis
        if [ "$AB0" == "" ]
        then
          STARTDIR="*"
          return
        fi
        AB0=`echo "$AB0" | sed 's/\/$//'`
        AB2="$STARTDIR/$AB0"
      done
      cd "$RETURNPATH"
      save_config "$PROJECTNAME" "$AB2"
      printf $C_CLEAR""
      return
    fi

  }

fi
