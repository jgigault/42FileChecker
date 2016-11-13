#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function check_makefile
  {
    local CHK_MAKEFILE_PATH="${1}" CHK_MAKEFILE_BINARY="${2}" CHK_MAKEFILE_BINARYPATH="${1}/${2}" CHK_MAKEFILE_FILEPATH LOGFILENAME=".mymakefile" ERRORS=0 WARNINGS=0

    [ -f "${1}/Makefile" ] && CHK_MAKEFILE_FILEPATH="${1}/Makefile" || CHK_MAKEFILE_FILEPATH="${1}/makefile"
    ${CMD_RM} -f "${LOGFILENAME}"
    ${CMD_TOUCH} "${LOGFILENAME}"
    if [ "${OPT_NO_MAKEFILE}" == "0" ]
    then
      if [ ! -f "${CHK_MAKEFILE_FILEPATH}" ]
      then
        printf "%s" "Makefile not found"
        return 1
      fi
      printf "%s\n" "CLEANING DIRECTORY" >> "${LOGFILENAME}"
      make -C "${CHK_MAKEFILE_PATH}" fclean &>/dev/null
      [ -f "${CHK_MAKEFILE_BINARYPATH}" ] && printf "%s\n" "-> Cleaning directory failed when processing 'fclean' rule" >> "${LOGFILENAME}" && (( ERRORS += 1 ))
      [ ! -z "$(ls -aR1 "${CHK_MAKEFILE_PATH}" | awk '$0 ~ /\.o$/ {print}')" ] && printf "%s\n" "-> Cleaning directory failed when processing 'fclean' rule" >> "${LOGFILENAME}" && (( ERRORS += 1 ))
      check_makefile_all >> "${LOGFILENAME}" || (( ERRORS += 1 ))
      check_makefile_clean >> "${LOGFILENAME}" || (( ERRORS += 1 ))
      check_makefile_re >> "${LOGFILENAME}" || (( ERRORS += 1 ))
      check_makefile_fclean >> "${LOGFILENAME}" || (( ERRORS += 1 ))
      check_makefile_name >> "${LOGFILENAME}" || (( ERRORS += 1 ))
      #check_makefile_phony >> "${LOGFILENAME}" || (( WARNINGS += 1 ))
      if [ "${ERRORS}" != 0 -a "${WARNINGS}" != 0 ]
      then
        printf "%d %s %d %s" "${ERRORS}" "error(s) and " "${WARNINGS}" "warning(s)"
        return 1
      fi
      if [ "${ERRORS}" != 0 ]
      then
        printf "%d %s" "${ERRORS}" "error(s)"
        return 1
      fi
      if [ "${WARNINGS}" != 0 ]
      then
        printf "%d %s" "${WARNINGS}" "warning(s)"
        return 2
      fi
      printf "%s" "All tests passed"
      return 0
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_makefile_all
  {
    local RET=0 MAKEALLTWICE INODE1 INODE2

    printf "%s\n%s\n" "--------------------------------------------" "CHECKING RULE: all"
    [ "$(awk '$0 ~ /^all[\t ]*:/ {printf "%s", "OK"}' "${CHK_MAKEFILE_FILEPATH}")" != "OK" ] && printf "%s\n" "-> Missing rule" && return 1
    [ "$(awk '$0 ~ /^all[\t ]*:.*\$(\(NAME\)|\{NAME\})/ {printf "%s", "OK"}' "${CHK_MAKEFILE_FILEPATH}")" != "OK" ] && printf "%s\n" "-> The rule 'all' should call the rule '\$(NAME)'" && return 1
    make -C "${CHK_MAKEFILE_PATH}" all &>/dev/null
    [ ! -f "${CHK_MAKEFILE_BINARYPATH}" ] && printf "%s\n" "-> Failing rule: It should have compiled a binary named '${CHK_MAKEFILE_BINARY}'" && RET=1
    [ -z "$(ls -aR1 "${CHK_MAKEFILE_PATH}" | awk '$0 ~ /\.o$/ {print}')" ] && printf "%s\n" "-> Failing rule: It should not have cleaned the objects files" && RET=1
    MAKEALLTWICE="$(make -C "${CHK_MAKEFILE_PATH}" all 2>/dev/null)"
    [ -z "$(echo ${MAKEALLTWICE} | grep -i "Nothing to be done")" -a -z "$(echo ${MAKEALLTWICE} | grep -i "is up to date")" ] && printf "%s\n" "-> Failing rule: Processing the rule 'all' twice in a row should result in nothing to be done" && RET=1
    return "${RET}"
  }

  function check_makefile_clean
  {
    local RET=0

    printf "%s\n%s\n" "--------------------------------------------" "CHECKING RULE: clean"
    [ "$(awk '$0 ~ /^clean[\t ]*:/ {printf "%s", "OK"}' "${CHK_MAKEFILE_FILEPATH}")" != "OK" ] && printf "%s\n" "-> Missing rule" && return 1
    [ ! -f "${CHK_MAKEFILE_BINARYPATH}" ] && printf "%s\n" "-> Cannot check the rule 'clean' because of the failing rule 'all'" && return 1
    make -C "${CHK_MAKEFILE_PATH}" clean &>/dev/null
    [ ! -f "${CHK_MAKEFILE_BINARYPATH}" ] && printf "%s\n" "-> Failing rule: It should not have cleaned the binary named '${CHK_MAKEFILE_BINARY}'" && RET=1
    [ ! -z "$(ls -aR1 "${CHK_MAKEFILE_PATH}" | awk '$0 ~ /\.o$/ {print}')" ] && printf "%s\n" "-> Failing rule: It should have cleaned the objects files" && RET=1
    return "${RET}"
  }

  function check_makefile_re
  {
    local RET=0 INODE1 INODE2

    printf "%s\n%s\n" "--------------------------------------------" "CHECKING RULE: re"
    [ "$(awk '$0 ~ /^re[\t ]*:/ {printf "%s", "OK"}' "${CHK_MAKEFILE_FILEPATH}")" != "OK" ] && printf "%s\n" "-> Missing rule" && return 1
    [ ! -f "${CHK_MAKEFILE_BINARYPATH}" ] && printf "%s\n" "-> Cannot check the rule 're' because of the failing rule 'all'" && return 1
    INODE1="$(ls -i "${CHK_MAKEFILE_BINARYPATH}" 2>/dev/null | awk '{print $1}')"
    make -C "${CHK_MAKEFILE_PATH}" re &>/dev/null
    INODE2="$(ls -i "${CHK_MAKEFILE_BINARYPATH}" 2>/dev/null | awk '{print $1}')"
    [ -z "$(ls -aR1 "${CHK_MAKEFILE_PATH}" | awk '$0 ~ /\.o$/ {print}')" ] && printf "%s\n" "-> Failing rule: It should have built the objects files" && RET=1
    [ ! -f "${CHK_MAKEFILE_BINARYPATH}" ] && printf "%s\n" "-> Failing rule: It should have compiled the binary named '${CHK_MAKEFILE_BINARY}'" && RET=1
    [ "${INODE1}" == "${INODE2}" -o "${INODE2}" == "" ] && printf "%s\n" "-> Failing rule: It should have compiled again the binary named '${CHK_MAKEFILE_BINARY}' (inode unchanged)" && RET=1
    return "${RET}"
  }

  function check_makefile_fclean
  {
    local RET=0

    printf "%s\n%s\n" "--------------------------------------------" "CHECKING RULE: fclean"
    [ "$(awk '$0 ~ /^fclean[\t ]*:/ {printf "%s", "OK"}' "${CHK_MAKEFILE_FILEPATH}")" != "OK" ] && printf "%s\n" "-> Missing rule" && return 1
    make -C "${CHK_MAKEFILE_PATH}" fclean &>/dev/null
    [ -f "${CHK_MAKEFILE_BINARYPATH}" ] && printf "%s\n" "-> Failing rule: It should have cleaned the binary named '${CHK_MAKEFILE_BINARY}'" && RET=1
    [ ! -z "$(ls -aR1 "${CHK_MAKEFILE_PATH}" | awk '$0 ~ /\.o$/ {print}')" ] && printf "%s\n" "-> Failing rule: It should have cleaned the objects files" && RET=1
    [ ! -z "$(ls -aR1 "${CHK_MAKEFILE_PATH}" | awk '$0 ~ /\.a$/ {print}')" ] && printf "%s\n" "-> Failing rule: It should have cleaned the libraries" && RET=1
    return "${RET}"
  }

  function check_makefile_name
  {
    local RET=0 MAKEALLTWICE

    printf "%s\n%s\n" "--------------------------------------------" "CHECKING RULE: \$(NAME)"
    [ "$(awk '$0 ~ /^\$(\(NAME\)|\{NAME\})[\t ]*:/ {printf "%s", "OK"}' "${CHK_MAKEFILE_FILEPATH}")" != "OK" ] && printf "%s\n" "-> Missing rule" && return 1
    make -C "${CHK_MAKEFILE_PATH}" "${CHK_MAKEFILE_BINARY}" &>/dev/null
    [ ! -f "${CHK_MAKEFILE_BINARYPATH}" ] && printf "%s\n" "-> Failing rule: It should have compiled a binary named '${CHK_MAKEFILE_BINARY}'" && RET=1
    [ -z "$(ls -aR1 "${CHK_MAKEFILE_PATH}" | awk '$0 ~ /\.o$/ {print}')" ] && printf "%s\n" "-> Failing rule: It should not have cleaned the objects files" && RET=1
    MAKEALLTWICE="$(make -C "${CHK_MAKEFILE_PATH}" "${CHK_MAKEFILE_BINARY}" 2>/dev/null)"
    [ -z "$(echo ${MAKEALLTWICE} | grep -i "Nothing to be done")" -a -z "$(echo ${MAKEALLTWICE} | grep -i "is up to date")" ] && printf "%s\n" "-> Failing rule: Processing the rule 'all' twice in a row should result in nothing to be done" && RET=1
    return "${RET}"
  }

  function check_makefile_phony
  {
    local RET=0

    printf "%s\n%s\n" "--------------------------------------------" "CHECKING RULE: .PHONY"
    [ "$(awk '$0 ~ /^\.PHONY[\t ]*:/ {printf "%s", "OK"}' "${CHK_MAKEFILE_FILEPATH}")" != "OK" ] && printf "%s\n" "-> Missing rule" && return 1
    [ ! -f "${CHK_MAKEFILE_BINARYPATH}" ] && printf "%s\n" "-> Cannot check the rule '.PHONY' because of the failing rule '\$(NAME)'" && return 1
    make -C "${CHK_MAKEFILE_PATH}" .PHONY &>/dev/null
    [ ! -f "${CHK_MAKEFILE_BINARYPATH}" ] && printf "%s\n" "-> Failing rule: It should not have cleaned the binary named '${CHK_MAKEFILE_BINARY}'" && RET=1
    [ ! -z "$(ls -aR1 "${CHK_MAKEFILE_PATH}" | awk '$0 ~ /\.o$/ {print}')" ] && printf "%s\n" "-> Failing rule: It should have cleaned the objects files" && RET=1
    return "${RET}"
  }

fi
