#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	declare -a CHK_FT_PRINTF_LIST


	CHK_FT_PRINTF_LIST+=("d" "%###-#0000 33...12..#00d |256")
	CHK_FT_PRINTF_LIST+=("d" "%###+#0000 33...12..#00d|256")
	CHK_FT_PRINTF_LIST+=("d" "%####0000 33...12..15..#00d|256")
	CHK_FT_PRINTF_LIST+=("d" "%.*C\n|0|945")
	CHK_FT_PRINTF_LIST+=("d" "%.*C\n|1|945")
	CHK_FT_PRINTF_LIST+=("d" "%.*C\n|2|945")
	CHK_FT_PRINTF_LIST+=("d" "%.*C\n|3|945")
	CHK_FT_PRINTF_LIST+=("d" "%.*C\n|4|945")
	CHK_FT_PRINTF_LIST+=("d" "%.*C\n|5|945")
	CHK_FT_PRINTF_LIST+=("d" "%.*C\n|6|945")
	CHK_FT_PRINTF_LIST+=("d" "%.*C\n|7|945")
	CHK_FT_PRINTF_LIST+=("d" "%.*C\n|8|945")
	CHK_FT_PRINTF_LIST+=("d" "%.*C\n|9|945")
	CHK_FT_PRINTF_LIST+=("d" "%.*C\n|10|945")
	CHK_FT_PRINTF_LIST+=("d" "je test ja=aja,n %.*C\n|11|1045")
	CHK_FT_PRINTF_LIST+=("d" "je test ja=aja,n %.*C\n|11|10045")
	CHK_FT_PRINTF_LIST+=("d" "|256")
	CHK_FT_PRINTF_LIST+=("d" "|256")
	CHK_FT_PRINTF_LIST+=("d" "|256")
	CHK_FT_PRINTF_LIST+=("d" "|256")
	CHK_FT_PRINTF_LIST+=("d" "|256")
	CHK_FT_PRINTF_LIST+=("d" "|256")
	CHK_FT_PRINTF_LIST+=("d" "|256")
	CHK_FT_PRINTF_LIST+=("d" "|256")
	CHK_FT_PRINTF_LIST+=("d" "|256")
	CHK_FT_PRINTF_LIST+=("d" "|256")


	# extra !!
	# integer long long ??
	# m == L


fi;
