#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	declare -a CHK_FT_PRINTF_LIST

	# easy
	CHK_FT_PRINTF_LIST+=("0" "")
	CHK_FT_PRINTF_LIST+=("0" "test")
	CHK_FT_PRINTF_LIST+=("0" "1234")

	# wrong flag
	CHK_FT_PRINTF_LIST+=("0" "%")
	CHK_FT_PRINTF_LIST+=("0" "% ")
	CHK_FT_PRINTF_LIST+=("0" "% z")
	CHK_FT_PRINTF_LIST+=("s" "% z|test")
	CHK_FT_PRINTF_LIST+=("d" "% z|42")

	# %
	CHK_FT_PRINTF_LIST+=("0" "%%")
	CHK_FT_PRINTF_LIST+=("s" "%%|test")
	CHK_FT_PRINTF_LIST+=("s" "%   %|test")
	CHK_FT_PRINTF_LIST+=("s" "%000   %|test")
	CHK_FT_PRINTF_LIST+=("s" "%%%|test")
	CHK_FT_PRINTF_LIST+=("s" "%%   %|test")

	# string
	CHK_FT_PRINTF_LIST+=("s" "%s|this is a string")
	CHK_FT_PRINTF_LIST+=("s" "this is a %s|string")
	CHK_FT_PRINTF_LIST+=("s" "%s is a string|this")

	CHK_FT_PRINTF_LIST+=("s" "%10s is a string|this")
	CHK_FT_PRINTF_LIST+=("s" "%.2s is a string|this")
	CHK_FT_PRINTF_LIST+=("s" "%5.2s is a string|this")

	# integer
	CHK_FT_PRINTF_LIST+=("d" "%d|1")
	CHK_FT_PRINTF_LIST+=("d" "%d|-1")
	CHK_FT_PRINTF_LIST+=("d" "%d|4242")
	CHK_FT_PRINTF_LIST+=("d" "%d|-4242")
	CHK_FT_PRINTF_LIST+=("d" "%d|4242424242424242424242")
	CHK_FT_PRINTF_LIST+=("d" "%d|-4242424242424242424242")

	CHK_FT_PRINTF_LIST+=("d" "% d|42")
	CHK_FT_PRINTF_LIST+=("d" "% d|-42")
	CHK_FT_PRINTF_LIST+=("d" "%0 d|42")
	CHK_FT_PRINTF_LIST+=("d" "%0 d|-42")
	CHK_FT_PRINTF_LIST+=("d" "% 0d|42")
	CHK_FT_PRINTF_LIST+=("d" "% 0d|-42")

	CHK_FT_PRINTF_LIST+=("d" "%+d|42")
	CHK_FT_PRINTF_LIST+=("d" "%+d|-42")
	CHK_FT_PRINTF_LIST+=("d" "%+d|0")
	CHK_FT_PRINTF_LIST+=("d" "%+d|4242424242424242424242")
	CHK_FT_PRINTF_LIST+=("d" "% +d|42")
	CHK_FT_PRINTF_LIST+=("d" "% +d|-42")
	CHK_FT_PRINTF_LIST+=("d" "%+ d|42")
	CHK_FT_PRINTF_LIST+=("d" "%+ d|-42")
	CHK_FT_PRINTF_LIST+=("d" "%  +d|42")
	CHK_FT_PRINTF_LIST+=("d" "%  +d|-42")
	CHK_FT_PRINTF_LIST+=("d" "%+  d|42")
	CHK_FT_PRINTF_LIST+=("d" "%+  d|-42")
	CHK_FT_PRINTF_LIST+=("d" "% ++d|42")
	CHK_FT_PRINTF_LIST+=("d" "% ++d|-42")
	CHK_FT_PRINTF_LIST+=("d" "%++ d|42")
	CHK_FT_PRINTF_LIST+=("d" "%++ d|-42")

	CHK_FT_PRINTF_LIST+=("d" "%0d|-42")
	CHK_FT_PRINTF_LIST+=("d" "%00d|-42")

	CHK_FT_PRINTF_LIST+=("d" "%5d|42")
	CHK_FT_PRINTF_LIST+=("d" "%05d|42")
	CHK_FT_PRINTF_LIST+=("d" "%005d|42")

fi;
