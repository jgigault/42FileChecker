#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	function check_makefile
	{
		local LPATH=$1
		local LBINARY=$2
		local LMAKEFILE RET0 RET2
		local LLOG=./.mymakefile
		local errors=0
		rm -f $LLOG
		touch $LLOG
		if [ -f "$LPATH/Makefile" ]
		then
			LMAKEFILE=`cat "$LPATH/Makefile"`
			RET0=`echo "$LMAKEFILE" | awk 'BEGIN {OFS=""} $0 ~ /^all[\t ]*:/ {print}'`
			if [ "$RET0" == "" ]
			then
				(( errors += 1 ))
				echo "'all' rule is missing" >> $LLOG
			fi
			RET0=`echo "$LMAKEFILE" | awk 'BEGIN {OFS=""} $0 ~ /^clean[\t ]*:/ {print}'`
			if [ "$RET0" == "" ]
			then
				(( errors += 1 ))
				echo "'clean' rule is missing" >> $LLOG
			fi
			RET0=`echo "$LMAKEFILE" | awk 'BEGIN {OFS=""} $0 ~ /^fclean[\t ]*:/ {print}'`
			if [ "$RET0" == "" ]
			then
				(( errors += 1 ))
				echo "'fclean' rule is missing" >> $LLOG
			fi
			RET0=`echo "$LMAKEFILE" | awk 'BEGIN {OFS=""} $0 ~ /^re[\t ]*:/ {print}'`
			if [ "$RET0" == "" ]
			then
				(( errors += 1 ))
				echo "'re' rule is missing" >> $LLOG
			fi
			RET0=`echo "$LMAKEFILE" | awk 'BEGIN {OFS=""} $0 ~ /^\\$\(NAME\)[\t ]*:/ {print}'`
			if [ "$RET0" == "" ]
			then
				(( errors += 1 ))
				echo "'"\$\(NAME\)"' rule is missing" >> $LLOG
			fi
			if (( errors == 0 ))
			then
				RET0=`make fclean -C "$LPATH" >/dev/null 2>&1`
				RET0=`make -C "$LPATH" >/dev/null 2>&1`
				RET0=`make clean -C "$LPATH" >/dev/null 2>&1`
				RET0=`ls -1 "$LPATH" | awk '$0 ~ /\.o$/ {print "->", $0}'`
				if [ "$RET0" == "" ]
				then
					RET0=`make fclean -C "$LPATH" >/dev/null 2>&1`
					RET0=`echo "$LBINARY" | sed 's/\./\\\\\./g'`
					RET0="ls -1 \"$LPATH\" | awk '\$0 ~ /^$RET0$/ {print \"->\", \$0}'"
					RET0=`eval $RET0`
					if [ "$RET0" == "" ]
					then
						RET0=`make all -C "$LPATH" >/dev/null 2>&1`
						RET0=`echo "$LBINARY" | sed 's/\./\\\\\./g'`
						RET0="ls -1 \"$LPATH\" | awk '\$0 ~ /^$RET0$/ {print \"->\", \$0}'"
						RET0=`eval $RET0`
						if [ "$RET0" != "" ]
						then
							RET0=`make all -C "$LPATH" 2>&1 | sed 's/\^\[\[[0-9;]*m//g' | sed 's/\^\[\[0m//g' | sed 's/\$$//'`
							RET2=`echo "$RET0" | grep -i "is up to date"`
							RET0=`echo "$RET0" | grep -i "Nothing to be done"`
							if [ "$RET0" != "" -o "$RET2" != "" ]
							then
								printf $C_GREEN"  Makefile seems to work perfectly"$C_CLEAR
							else
								echo "Running 'make all' twice in a row should return the message \"make: Nothing to be done for \`all'\".\n" >> $LLOG
								printf $C_RED"  'all' rule should not have been performed (see more info)"$C_CLEAR
							fi
						else
							echo "The following file is missing:" >> $LLOG
							echo "-> $LBINARY" >> $LLOG
							printf $C_RED"  'all' rule has failed (see more info)"$C_CLEAR
						fi
					else
						echo "The following file should have been cleaned:" >> $LLOG
						echo "$RET0" >> $LLOG
						printf $C_RED"  'fclean' rule has failed (see more info)"$C_CLEAR
					fi
				else
					echo "The following files should have been cleaned:" >> $LLOG
					echo "$RET0" >> $LLOG
					printf $C_RED"  'clean' rule has failed (see more info)"$C_CLEAR
				fi
			else
				printf $C_RED"  $errors rule(s) are missing (see more info)"$C_CLEAR
			fi
		else
			printf $C_RED"  Makefile not found"$C_CLEAR
		fi
	}

fi