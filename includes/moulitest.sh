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



fi;