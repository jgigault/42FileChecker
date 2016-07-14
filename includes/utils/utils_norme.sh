#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function check_norme
  {
    if [ "${OPT_NO_NORMINETTE}" == "0" ]
    then
      local RET0 RET2 RET3 RET4 TOTAL TOTA2
      rm -f "$RETURNPATH"/.mynorminette
      RET0=$(find "${MYPATH}" -type f -name "*.[ch]" ! -name 'mlx.h' | awk 'BEGIN {ORS=" "} {gsub(/\ /, "\\ "); print}')
      if [ "${RET0}" != "" ]
      then
        RET2=`eval norminette $RET0 2>&1`
        RET4=$?
        echo "$RET2" > "$RETURNPATH"/.mynorminette
        RET2=`cat .mynorminette | grep Error`
        RET3=`cat .mynorminette | grep Warning`
        if [ "$RET2" == "" -a "$RET3" == "" -a "$RET4" == 0 ]
        then
          printf "%s" "All files passed the tests"
          return 0
        else
          if [ "$RET4" != 0 ]
          then
            printf "%s" "Command not found"
            return 255
          else
            if [ "$RET2" == "" ]
            then
              TOTAL=0
            else
              TOTAL=`echo "$RET2" | awk 'END {print NR}'`
            fi
            if [ "$RET3" == "" ]
            then
              TOTA2=0
            else
              TOTA2=`echo "$RET3" | awk 'END {print NR}'`
            fi
            (( TOTAL = $TOTAL + $TOTA2 ))
            printf "%s" "${TOTAL} error(s) or warning(s)"
            return 1
          fi
        fi
      else
        printf "%s" "No source file (.c) or header (.h) to check"
        return 255
      fi
    fi
    return 255
  }

fi
