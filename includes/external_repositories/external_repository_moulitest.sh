#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function check_moulitest
  {
    local RET0 RET1 TOTAL

    if [ "$OPT_NO_MOULITEST" == "0" ]
    then
      rm -f .mymoulitest
      if [ -d "${MOULITEST_DIR}" ]
      then
        make "$1" -C "${MOULITEST_DIR}" 1> .mymoulitest 2>&1
        check_cleanlog .mymoulitest
        RET1=`cat .mymoulitest`
        RET0=`echo "$RET1" | grep "STARTING ALL UNIT TESTS"`
        if [ "$RET0" == "" ]
        then
          printf "%s" "Cannot compile"
        else
          RET0=`echo "$RET1" | grep "END OF UNIT TESTS"`
          if [ "$RET0" == "" ]
          then
            printf "%s" "Moulitest has aborted"
          else
            RET0=`echo "$RET1" | grep FAIL`
            if [ "$RET0" != "" ]
            then
              TOTAL=`printf "%s\n" "$RET0" | awk 'END {print NR}'`
              printf "%s" "${TOTAL} failed test(s)"
            else
              printf "%s" "All Unit Tests passed"
              return 0
            fi
          fi
        fi
      else
        printf "%s" "Not installed"
      fi
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function configure_moulitest
  {
    local LPATH=$(printf "%s" "$2" | sed 's/ /\\ /g')

    [ "$OPT_NO_MOULITEST" != "0" ] && return
    case "$1" in
      "libft")
        echo "LIBFT_PATH = \"${LPATH}\"" > "$RETURNPATH"/"${MOULITEST_DIR}"/config.ini
        ;;
      "gnl")
        echo "GET_NEXT_LINE_PATH = \"${LPATH}\"" > "$RETURNPATH"/"${MOULITEST_DIR}"/config.ini
        ;;
      "ft_ls")
        echo "FT_LS_PATH = \"${LPATH}\"" > "$RETURNPATH"/"${MOULITEST_DIR}"/config.ini
        ;;
      "ft_printf")
        echo "FT_PRINTF_PATH = \"${LPATH}\"" > "$RETURNPATH"/"${MOULITEST_DIR}"/config.ini
        ;;
    esac
  }

fi;
