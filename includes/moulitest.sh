#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	function check_moulitest_cleanlog
	{
		local RET0 LOGFILENAME
		LOGFILENAME="$1"
		if [ -f "$LOGFILENAME" ]
		then
			RET0=`cat -e "$LOGFILENAME"`
			RET0=`echo "$RET0" | awk '{gsub(/\^M.*\^M/, ""); print}'`
			RET0=`echo "$RET0" | awk '{gsub(/\^\[\[[0-9;]*m/, ""); print}'`
			RET0=`echo "$RET0" | awk '{gsub(/[\$]$/, ""); print}'`
			echo "$RET0" > "$LOGFILENAME"
		fi
	}

	function check_moulitest
	{	if [ "$OPT_NO_MOULITEST" == "0" ]; then
		local RET0 RET1 TOTAL
		rm -f .mymoulitest
		if [ -d moulitest ]
		then
			make "$1" -C moulitest 1> .mymoulitest 2>&1
			check_moulitest_cleanlog .mymoulitest
			RET1=`cat .mymoulitest`
			RET0=`echo "$RET1" | grep "STARTING ALL UNIT TESTS"`
			if [ "$RET0" == "" ]
			then
			    printf $C_RED"  Fatal error: moulitest cannot compile (see more info)"$C_CLEAR
			else
			    RET0=`echo "$RET1" | grep "END OF UNIT TESTS"`
			    if [ "$RET0" == "" ]
			    then
			        printf $C_RED"  Fatal error: moulitest has aborted (see more info)"$C_CLEAR
			    else
			        RET0=`echo "$RET1" | grep FAIL`
			        if [ "$RET0" != "" ]
			        then
			            TOTAL=`printf "%s" "$RET0" | wc -l | sed 's/ //g'`
			            printf $C_RED"  $TOTAL failed test(s)"$C_CLEAR
			        else
			            printf $C_GREEN"  All Unit Tests passed"$C_CLEAR
			        fi
			    fi
			fi
		else
			printf $C_RED"  'moulitest' is not installed"$C_CLEAR
		fi
		else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
	}


fi;