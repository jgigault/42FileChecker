#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function check_speedtest_exec
  {
    local PROGNAME PROGARGS PROCESSID RET0 LOGFILENAME
    PROGNAME="$1"
    PROGARGS="$2"
    LOGFILENAME="$RETURNPATH/tmp/speedtest"
    rm -f $LOGFILENAME
    touch $LOGFILENAME
    check_kill_by_name "$PROGNAME $PROGARGS"
    (eval "$PROGNAME $PROGARGS" 1>$LOGFILENAME 2>&1 &)
    PROCESSID=`ps | grep "$PROGNAME $PROGARGS" | grep -v "grep" | sed 's/^[ ]*//g' | cut -d" " -f1`
    if [ "$PROCESSID" != "" ]
    then
      sleep 10
      PROCESSID=`ps | grep "$PROGNAME $PROGARGS" | grep -v "grep" | sed 's/^[ ]*//g' | cut -d" " -f1`
      if [ "$PROCESSID" != "" ]
      then
        check_kill_by_name "$PROGNAME $PROGARGS"
        RET0=`cat "$LOGFILENAME" | awk 'END {print NR}'`
        printf $RET0
      else
        printf "%s" "-2"
      fi
    else
      printf "%s" "-1"
    fi
    rm -f $LOGFILENAME
  }

  function check_speedtest
  {
    local errors fatal PROCESSID RET0 RET1 RET2 PROGNAME1 PROGNAME2 PROGARGS NOTICE
    errors=0
    fatal=0
    PROGNAME1="$1"
    PROGNAME2="$2"
    PROGARGS="$3"
    LOGFILENAME="$4"
    NOTICE="$5"
    if [ -f "$PROGNAME1" ]
    then
      printf "$NOTICE" >> $LOGFILENAME
      RET0=`check_speedtest_exec "$PROGNAME1" "$PROGARGS" 2>&1`
      if [ "$RET0" != "" ]
      then
        if [[ "$(echo "$RET0" | sed 's/[^0-9]*//g')" == "$RET0" ]]
        then
          RET1=`check_speedtest_exec "$PROGNAME2" "$PROGARGS" 2>&1`
          if [ "$RET1" != "" ]
          then
            if [[ "$(echo "$RET1" | sed 's/[^0-9]*//g')" == "$RET1" ]]
            then
              (( RET2= $RET0 * 100 / $RET1 ))
              if (( $RET2 <= 75 ))
              then
                printf "%s" "Estimated speed rate: ${RET2}%"
              else
                printf "%s" "Estimated speed rate: ${RET2}%"
                return 0
              fi
              printf "How it works:\nBoth programs are executed one at a time with the same options so that time needed for execution is greater than 10 seconds.\nDuring 10 seconds, the stdout of each program is saved in a temporary file and then the lines are counted.\nThe rate is calculated by comparing both line counts.\n\nWarning: Your program must work perfectly (the same stdout from the original program) and you should perform your own test with a greater interval of time.\n\n" >> $LOGFILENAME
              echo "-----------------\n" >> $LOGFILENAME
              printf "# Your program:\n" >> $LOGFILENAME
              printf "$PROGNAME1 $PROGARGS\n--> $RET0 lines written on stdout\n\n" >> $LOGFILENAME
              printf "# Original program:\n" >> $LOGFILENAME
              printf "$PROGNAME2 $PROGARGS\n--> $RET1 lines written on stdout\n\n" >> $LOGFILENAME
              printf "Estimated speed rate:  $RET2%%" >> $LOGFILENAME
            else
              printf "%s" "An error occured"
              if [ "$RET1" == "-1" ]
              then
                printf "$PROGNAME2 $PROGARGS has aborted" >> $LOGFILENAME
              else
                if [ "$RET1" == "-2" ]
                then
                  printf "$PROGNAME2 $PROGARGS has aborted or has terminated in less than 5 seconds" >> $LOGFILENAME
                else
                  printf "$RET1" >> $LOGFILENAME
                fi
              fi
            fi
          else
            printf "%s" "An error occured"
            printf "$PROGNAME2 $PROGARGS has aborted or did nothing" >> $LOGFILENAME
          fi
        else
          printf "%s" "An error occured"
          if [ "$RET0" == "-1" ]
          then
            printf "$PROGNAME1 $PROGARGS has aborted" >> $LOGFILENAME
          else
            if [ "$RET0" == "-2" ]
            then
              printf "$PROGNAME1 has aborted or has terminated in less than 5 seconds" >> $LOGFILENAME
            else
              printf "$RET0" >> $LOGFILENAME
            fi
          fi
        fi
      else
        printf "%s" "An error occured"
        printf "$PROGNAME1 $PROGARGS has aborted or did nothing" >> $LOGFILENAME
      fi
    else
      printf "%s" "Binary not found"
    fi
    return 1
  }

fi
