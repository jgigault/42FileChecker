#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function check_forbidden_func
  {
    local EXTENSION FILEN LOG_FILENAME=".myforbiddenfunc" REGEX
    local -a MYFUNCS
    local exists total i RET0

    OLD_IFS=${IFS}
    IFS=''
    local tab_str="$1[*]"
    local tab_local=(${!tab_str})
    IFS=${OLD_IFS}

    if [ -z ${3} ]
    then
      EXTENSION="c"
    else
      EXTENSION=${3}
    fi
    ${CMD_RM} -f "${LOG_FILENAME}"
    ${CMD_TOUCH} "${LOG_FILENAME}"
    if [ -f "$2" ]
    then
      RET0=`nm -m -u "$2" | grep '(from libSystem)' | awk '{OFS=""; ORS=" "} $0 ~ / _/ {gsub(/^[a-zA-Z0-9\(\)_, \[\]]* _[_]*/, ""); gsub(/_chk[ A-Za-z0-9\(\)]*$/, ""); gsub(/\\\$.*$/, "", $1); print $1}'`
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
          if [ "${REGEX}" == "" ]
          then
            REGEX="${MYFUNCS[${item}]}"
          else
            REGEX="${REGEX}|${MYFUNCS[${item}]}"
          fi
        fi
      done
      IFS=${OLD_IFS}

      if [ "${REGEX}" != "" ]
      then
        for i in $(find "${MYPATH}" -name "*.${EXTENSION}")
        do
          FILEN=$(basename "$i")
          if [ "${EXTENSION}" == "s" ]
          then
            RET0=`awk -v FILEN="${FILEN}" -v REGEX="call[ \\\\\t\\\\\_]\*(${REGEX})" 'BEGIN{ORS=""} $0 ~ REGEX {gsub(/[\t ]+/, " "); match($0, REGEX); myfunc=substr($0, RSTART, RLENGTH); gsub(/[ \t\_]/, "", myfunc); gsub(/^ /, ""); printf("-> %s\n   (line #%03s: %s)\n\n", myfunc, NR, $0)}' "$i"`
          else
            RET0=`awk -v FILEN="${FILEN}" -v REGEX="[\\\\\(\\\\\)= \\\\\t](${REGEX})[ \\\\\t]\*\\\\\(" 'BEGIN{ORS=""} $0 ~ REGEX {gsub(/[\t ]+/, " "); match($0, REGEX); myfunc=substr($0, RSTART, RLENGTH); gsub(/[\(\)= \t]/, "", myfunc); gsub(/^ /, ""); printf("-> %s\n   (line #%03s: %s)\n\n", myfunc, NR, $0)}' "$i"`
          fi
          if [ "${RET0}" != "" ]
          then
            (( total += 1 ))
            if (( total == 1 ))
            then
              printf "%s\n\n" "You should justify the use of the following functions:" > ${LOG_FILENAME}
            fi
            printf -- "------------------------------------\n%s\n\n%s\n\n" "$i" "$RET0" >> ${LOG_FILENAME}
            exists=1
          fi
        done
      fi

      if (( total == 0 ))
      then
        printf "%s" "No forbidden function found"
        echo "" > ${LOG_FILENAME}
        return 0
      else
        awk 'BEGIN {TOTAL1=0; TOTAL2=0} $0 ~ /^-> / {TOTAL1++} $0 ~ /^------/ {TOTAL2++} END {printf "%s warning(s) in %s file(s)", TOTAL1, TOTAL2}' "${LOG_FILENAME}"
        return 1
      fi
    else
      echo "$2: File Not Found" > ${LOG_FILENAME}
      return 1
    fi
    return 255
  }

fi
