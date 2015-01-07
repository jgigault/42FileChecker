#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	function check_leaks
	{
		local errors fatal PROCESSID RET0 RET1 PROGNAME NOTICE
		errors=0
		fatal=0
		PROGNAME="$1"
		PROGARGS="$2"
		LOGFILENAME="$3"
		NOTICE="$4"
		if [ -f "$PROGNAME" ]
		then
			(eval "$PROGNAME $PROGARGS" 1>/dev/null 2>$LOGFILENAME &)
			PROCESSID=`ps | grep "$PROGNAME" | grep -v "grep" | sed 's/^[ ]*//g' | cut -d" " -f1`
			if [ "$PROCESSID" != "" ]
			then
				sleep 5
				RET0=`leaks $PROCESSID 2>&1`
				RET1=`echo "$RET0" | grep "command not found"`
				if [ "$RET1" != "" ]
				then
					fatal=2
					echo "$RET0" > $LOGFILENAME
				else
					RET1=`echo "$RET0" | grep "because the process does not exist"`
					if [ "$RET1" != "" ]
					then
						(( errors += 1 ))
					else
						check_kill_by_name "$PROGNAME"
						echo "$RET0" > $LOGFILENAME
						RET0=`cat "$LOGFILENAME" | grep "pointer being freed was not allocated"`
						if [ "$RET0" != "" ]
						then
							(( errors += 1 ))
						fi
					fi
				fi
			else
				(( errors += 1 ))
			fi
			if (( $fatal > 0 ))
			then
				if (( $fatal == 1 ))
				then
					printf $C_RED"  Fatal error: Cannot compile"$C_CLEAR
				fi
				if (( $fatal == 2 ))
				then
					printf $C_RED"  Command not found"$C_CLEAR
				fi
			else
				if (( $errors == 0 ))
				then
					RET0=`cat $LOGFILENAME | grep "0 leaks for 0 total leaked bytes"`
					if [ "$RET0" == "" ]
					then
						RET0=`cat $LOGFILENAME | grep "total leaked bytes" | cut -d":" -f2 | sed 's/^[ ]*//g' | sed 's/[. ]*$//g'`
						if [ "$RET0" != "" ]
				        then
							RET1=`cat $LOGFILENAME`
							RET1=`echo "$NOTICE$RET1" > $LOGFILENAME`
							printf $C_RED"  $RET0"$C_CLEAR
				        else
				            printf $C_RED"  An error occured"$C_CLEAR
				        fi
				    else
				        RET0=`echo "$RET0" | cut -d":" -f2 | sed 's/^[ ]*//g' | sed 's/[. ]*$//g'`
				        printf $C_GREEN"  $RET0"$C_CLEAR
				    fi
				else
				    printf $C_RED"  An error occured"$C_CLEAR
				fi
			fi
		else
			printf $C_RED"  Fatal error: Cannot compile"$C_CLEAR
		fi
	}

fi;