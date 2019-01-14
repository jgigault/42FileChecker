#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function utils_get_inode
  {
    local FILEPATH GETINODEDIR GETINODEEXE LOGFILENAME

    FILEPATH="${1}"
    GETINODEDIR="${GLOBAL_INSTALLDIR}/srcs/get_inode"
    GETINODEEXE="${GETINODEDIR}/get_inode"
    LOGFILENAME="${2}"
    ${CMD_RM}  -f ${LOGFILENAME}
    ${CMD_TOUCH} ${LOGFILENAME}
    make -C "${GETINODEDIR}" 1>${LOGFILENAME} 2>&1 || return 1
    "${GETINODEEXE}" "${FILEPATH}" 2>${LOGFILENAME} || return 1
    return ${?}
  }

fi