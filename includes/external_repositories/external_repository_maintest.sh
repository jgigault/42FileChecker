#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  declare -a MAINTEST_FUNCTIONS='(memset bzero memcpy memccpy memmove memchr memcmp strlen strdup strcpy strncpy strcat strncat strlcat strchr strrchr strstr strnstr strcmp strncmp atoi isalpha isdigit isalnum isascii isprint toupper tolower strnew strdel strclr striter striteri strmap strmapi strequ strnequ strsub strjoin strsplit itoa strtrim lstnew lstdelone lstdel lstadd lstiter lstmap)'

  function check_maintest_libft
  {
    local LOCALFILE RMVFUNCTIONS="" LOGFILENAME="${1}" PROJECTPATH="${2}" TOTAL=0 SUCCESS=0
    local -a MAINTEST_FUNCTIONS_MISSING

    ${CMD_RM} -f "${LOGFILENAME}"
    if [ -d "${EXTERNAL_REPOSITORY_MAINTEST_DIR}" ]
    then
      make re -C "${MYPATH}" 1>"${LOGFILENAME}" 2>&1
      if [ -f "${MYPATH}/libft.a" ]
      then
        check_create_tmp_dir
        ${CMD_RM} -rf "./tmp/mymaintest_libft"
        mkdir "./tmp/mymaintest_libft"

        #prepare blacklist of functions
        for LOCALFILE in "${MAINTEST_FUNCTIONS[@]}"
        do
          check_fileexists_one "ft_${LOCALFILE}.c" "${MYPATH}"
          if [ "${?}" != "0" ]
          then
            if [ "${RMVFUNCTIONS}" == "" ]
            then
              RMVFUNCTIONS="D_$(echo "${LOCALFILE}" | awk '{printf toupper($0)}')"
            else
              RMVFUNCTIONS="${RMVFUNCTIONS}|D_$(echo "${LOCALFILE}" | awk '{printf toupper($0)}')"
            fi
          fi
        done

        #special case for memalloc and memdel
        check_fileexists_one "ft_memalloc.c" "${MYPATH}" && check_fileexists_one "ft_memdel.c" "${MYPATH}"
        if [ "${?}" != "0" ]
        then
          if [ "${RMVFUNCTIONS}" == "" ]
          then
            RMVFUNCTIONS="D_MEMALLOC_AND_DEL"
          else
            RMVFUNCTIONS="${RMVFUNCTIONS}|D_MEMALLOC_AND_DEL"
          fi
        fi

        #copy main.c and comment blacklisted functions if necessary
        if [ "${RMVFUNCTIONS}" == "" ]
        then
          cp "${EXTERNAL_REPOSITORY_MAINTEST_DIR}/libft/main.c" "./tmp/mymaintest_libft/"
        else
          awk -v RMVFUNCTIONS="^[\t]?(#define)[\t ]*(${RMVFUNCTIONS})" '
          BEGIN {
            RMV=0
          }
          $0 ~ RMVFUNCTIONS {
            RMV=1
          }
          {
            if (RMV == 0) {
              print $0
            } else {
              printf "//%s\n", $0;
              RMV++;
              if (RMV == 3) {
                RMV=0
              }
            }
          }
          ' "${EXTERNAL_REPOSITORY_MAINTEST_DIR}/libft/main.c" 1>"./tmp/mymaintest_libft/main.c" 2>"${LOGFILENAME}"
        fi

        if [ "${?}" == "0" -a -f "./tmp/mymaintest_libft/main.c" ]
        then
          #compile main.c with libft.a
          ${CMD_GCC} -Wall -Werror -Wextra "./tmp/mymaintest_libft/main.c" -L "${MYPATH}" -I "${MYPATH}" -I "${MYPATH}/include" -I "${MYPATH}/includes" -lft -o "./tmp/mymaintest_libft/main" 1>>"${LOGFILENAME}" 2>&1

          #launch tests if compilation succeeded
          if [ -f "./tmp/mymaintest_libft/main" ]
          then
            eval "./tmp/mymaintest_libft/main" 1>"${LOGFILENAME}" 2>&1
            check_cleanlog "${LOGFILENAME}"
            TOTAL=`awk 'BEGIN {TOTAL=0} $0 ~ /^Test/ {TOTAL++} END {printf "%d", TOTAL}' "${LOGFILENAME}"`
            SUCCESS=`awk 'BEGIN {SUCCESS=0} $0 ~ /^Test.*OK$/ {SUCCESS++} END {printf "%d", SUCCESS}' "${LOGFILENAME}"`
            if [ "${TOTAL}" == "${SUCCESS}" ]
            then
              printf "%s" "All tests passed (${TOTAL} tests)"
              return 0
            else
              printf "%s" "$(( ${TOTAL} - ${SUCCESS} )) failed test(s) out of ${TOTAL} tests"
            fi
          else
            printf "%s" "Cannot compile"
          fi
        else
          printf "%s" "An error occured while preparing main.c"
        fi
      else
        printf "%s" "Cannot compile"
      fi
      return 1
    else
      printf "%s" "Not installed"
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_maintest_ft_ls
  {
    local LOCALFILE LOGFILENAME="${1}" PROJECTPATH="${2}" ERROR=0 SUCCESS=0

    ${CMD_RM} -f "${LOGFILENAME}"
    if [ -d "${EXTERNAL_REPOSITORY_MAINTEST_DIR}" ]
    then
      make re -C "${MYPATH}" 1>"${LOGFILENAME}" 2>&1
      if [ -f "${MYPATH}/ft_ls" ]
      then
        check_create_tmp_dir
        (cd ./maintest/ft_ls/ && ./diff_me.sh --non-interactive "${PROJECTPATH}/ft_ls" &> "../../${LOGFILENAME}")
        check_cleanlog "${LOGFILENAME}"
        ERROR=`awk 'BEGIN {ERROR=0} $0 ~ /^Error:/ {ERROR++} END {printf "%d", ERROR}' "${LOGFILENAME}"`
        SUCCESS=`awk 'BEGIN {SUCCESS=0} $0 ~ /^Success:/ {SUCCESS++} END {printf "%d", SUCCESS}' "${LOGFILENAME}"`
        if [ "${ERROR}" == "0" ]
        then
          printf "%s" "All tests passed (${SUCCESS} tests)"
          return 0
        else
          printf "%s" "$(( ${ERROR} )) failed test(s) out of $(( ${SUCCESS} + ${ERROR} )) tests"
        fi
      else
        printf "%s" "Cannot compile"
      fi
      return 1
    else
      printf "%s" "Not installed"
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

fi
