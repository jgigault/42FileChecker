#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	declare -a CHK_FT_PRINTF_LIST

	CHK_FT_PRINTF_LIST+=("s" "")
	CHK_FT_PRINTF_LIST+=("s" "test")
	CHK_FT_PRINTF_LIST+=("s" "1234")

	CHK_FT_PRINTF_LIST+=("s" "%%")
	CHK_FT_PRINTF_LIST+=("s" "%%|test")
	CHK_FT_PRINTF_LIST+=("s" "%   %|test")
	CHK_FT_PRINTF_LIST+=("s" "%000   %|test")
	CHK_FT_PRINTF_LIST+=("s" "%%%|test")
	CHK_FT_PRINTF_LIST+=("s" "%%   %|test")

	CHK_FT_PRINTF_LIST+=("s" "%s|this is a string")
	CHK_FT_PRINTF_LIST+=("s" "this is a %s|string")
	CHK_FT_PRINTF_LIST+=("s" "%s is a string|this")

	CHK_FT_PRINTF_LIST+=("s" "%10s is a string|this")
	CHK_FT_PRINTF_LIST+=("s" "%.2s is a string|this")
	CHK_FT_PRINTF_LIST+=("s" "%5.2s is a string|this")

fi;
