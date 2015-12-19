#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	function check_forbidden_func
	{
		local EXTENSION FILEN
		local -a MYFUNCS
		local exists total i RET0
		LOG_FILENAME=".myforbiddenfunc"
		OLD_IFS=${IFS}
		IFS=''
		local tab_str="$1[*]"
		local tab_local=(${!tab_str})
		IFS=${OLD_IFS}
		if [ -z $3 ]
		then
			EXTENSION="c"
		else
			EXTENSION=$3
		fi
		${CMD_RM} -f "${LOG_FILENAME}"
		${CMD_TOUCH} "${LOG_FILENAME}"
		if [ -f "$2" ]
		then
			RET0=`nm -m -u "$2" | grep '(from libSystem)' | awk '{OFS=""; ORS=" "} $0 ~ / _/ {gsub(/^[a-zA-Z0-9\(\)_, \[\]]* _[_]*/, ""); gsub(/_chk[ A-Za-z0-9\(\)]*$/, ""); print $1}'`
			eval "MYFUNCS=(${RET0})"
			total=0
			OLD_IFS=${IFS}
			IFS=$'\n'
			for item in ${!MYFUNCS[@]};
			do
				exists=0
				for item2 in ${!tab_local[@]};
				do
					if [ ${MYFUNCS[${item}]} == ${tab_local[${item2}]} ]
					then
						exists=1
					fi
				done
				if [ "${exists}" == "0" ]
				then
					for i in $(find "${MYPATH}" -name "*.${EXTENSION}")
					do
						FILEN=$(basename "$i")
						if [ "${EXTENSION}" == "s" ]
						then
							RET0=`echo "cat \"$i\" | awk 'BEGIN{ORS=\"\"} \\$0 ~ /call[ \t\_]*${MYFUNCS[$item]}/ {gsub(/[\\t]/, \" \"); gsub(/[ ]+/, \" \"); gsub(/^ /, \"\"); printf(\"%s%s%s%s\", \"-> \", \"${MYFUNCS[$item]}\\\\\\n\\\\\\n\", \"   line \"NR\" in $FILEN:\\\\\\n\", \"   \"\\$0\"\\\\\\n\\\\\\n\")}'"`
						else
							RET0=`echo "cat \"$i\" | awk 'BEGIN{ORS=\"\"} \\$0 ~ /[\(\)= \t]${MYFUNCS[$item]}[ \\t]*\(/ {gsub(/[\\t]/, \" \"); gsub(/[ ]+/, \" \"); gsub(/^ /, \"\"); printf(\"%s%s%s%s\", \"-> \", \"${MYFUNCS[$item]}\\\\\\n\\\\\\n\", \"   line \"NR\" in $FILEN:\\\\\\n\", \"   \"\\$0\"\\\\\\n\\\\\\n\")}'"`
						fi
						RET0=$(eval "${RET0}")
						if [ "${RET0}" != "" ]
						then
							(( total += 1 ))
							if (( total == 1 ))
							then
								printf "%s\n\n" "You should justify the use of the following functions:" > ${LOG_FILENAME}
							fi
							printf "%s\n\n" "$RET0" >> ${LOG_FILENAME}
							exists=1
						fi
					done
				fi
			done
			IFS=${OLD_IFS}
			if (( total == 0 ))
			then
				printf ${C_GREEN}"  No forbidden function found"${C_CLEAR}
				echo "" > ${LOG_FILENAME}
			else
				printf ${C_RED}"  $total warning(s)"${C_CLEAR}
			fi
		else
			printf ${C_RED}"  Test not performed (see more info)"${C_CLEAR}
			echo "$2: File Not Found" > ${LOG_FILENAME}
		fi
	}

fi
