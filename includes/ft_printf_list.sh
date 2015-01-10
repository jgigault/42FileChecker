#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	declare -a CHK_FT_PRINTF_LIST

	# easy
	CHK_FT_PRINTF_LIST+=("0" "")
	CHK_FT_PRINTF_LIST+=("0" "\n")
	CHK_FT_PRINTF_LIST+=("0" "test")
	CHK_FT_PRINTF_LIST+=("0" "test\n")
	CHK_FT_PRINTF_LIST+=("0" "1234")

	# wrong flag
	CHK_FT_PRINTF_LIST+=("0" "%")
	CHK_FT_PRINTF_LIST+=("0" "% ")
	CHK_FT_PRINTF_LIST+=("0" "% v")

	# %
	CHK_FT_PRINTF_LIST+=("0" "%%")

	# hexadecimal
	#CHK_FT_PRINTF_LIST+=("0p" "%p|(void *)(str = \"I am a void\")")




	CHK_FT_PRINTF_LIST+=("s" "% v|test")
	CHK_FT_PRINTF_LIST+=("s" "%%|test")
	CHK_FT_PRINTF_LIST+=("s" "%   %|test")
	CHK_FT_PRINTF_LIST+=("s" "%000   %|test")
	CHK_FT_PRINTF_LIST+=("s" "%%%|test")
	CHK_FT_PRINTF_LIST+=("s" "%%   %|test")



	# x X
	CHK_FT_PRINTF_LIST+=("x" "%x|42")
	CHK_FT_PRINTF_LIST+=("x" "%X|42")
	CHK_FT_PRINTF_LIST+=("x" "%x|0")
	CHK_FT_PRINTF_LIST+=("x" "%X|0")
	CHK_FT_PRINTF_LIST+=("x" "%x|-42")
	CHK_FT_PRINTF_LIST+=("x" "%X|-42")
	CHK_FT_PRINTF_LIST+=("x" "%x|4294967296")
	CHK_FT_PRINTF_LIST+=("x" "%X|4294967296")
	CHK_FT_PRINTF_LIST+=("xs" "%x|test")

	CHK_FT_PRINTF_LIST+=("x" "%10x|42")
	CHK_FT_PRINTF_LIST+=("x" "%-10x|42")

	CHK_FT_PRINTF_LIST+=("x" "%lx|4294967296")
	CHK_FT_PRINTF_LIST+=("x" "%llX|4294967296")

	CHK_FT_PRINTF_LIST+=("x" "%hx|4294967296")
	CHK_FT_PRINTF_LIST+=("x" "%hhX|4294967296")

	CHK_FT_PRINTF_LIST+=("x" "%jx|4294967295")
	CHK_FT_PRINTF_LIST+=("x" "%jx|4294967296")

	CHK_FT_PRINTF_LIST+=("x" "%jx|-4294967296")
	CHK_FT_PRINTF_LIST+=("x" "%jx|-4294967297")

	CHK_FT_PRINTF_LIST+=("x" "%llx|9223372036854775807")
	CHK_FT_PRINTF_LIST+=("x" "%llx|9223372036854775808")

	CHK_FT_PRINTF_LIST+=("x" "%010x|542")
	CHK_FT_PRINTF_LIST+=("x" "%-15x|542")
	CHK_FT_PRINTF_LIST+=("x" "%2x|542")
	CHK_FT_PRINTF_LIST+=("x" "%.2x|5427")
	CHK_FT_PRINTF_LIST+=("x" "%5.2x|5427")



	# string
	CHK_FT_PRINTF_LIST+=("s" "%s|this is a string")
	CHK_FT_PRINTF_LIST+=("s" "this is a %s|string")
	CHK_FT_PRINTF_LIST+=("s" "%s is a string|this")
	CHK_FT_PRINTF_LIST+=("s" "this is a Line Feed %s|\n")

	CHK_FT_PRINTF_LIST+=("s" "%10s is a string|this")
	CHK_FT_PRINTF_LIST+=("s" "%010s is a string|this")
	CHK_FT_PRINTF_LIST+=("s" "%.2s is a string|this")
	CHK_FT_PRINTF_LIST+=("s" "%5.2s is a string|this")
	CHK_FT_PRINTF_LIST+=("s" "%10s is a string|")
	CHK_FT_PRINTF_LIST+=("s" "%.2s is a string|")
	CHK_FT_PRINTF_LIST+=("s" "%5.2s is a string|")

	CHK_FT_PRINTF_LIST+=("s" "%-10s is a string|this")
	CHK_FT_PRINTF_LIST+=("s" "%-010s is a string|this")
	CHK_FT_PRINTF_LIST+=("s" "%-.2s is a string|this")
	CHK_FT_PRINTF_LIST+=("s" "%-5.2s is a string|this")
	CHK_FT_PRINTF_LIST+=("s" "%-10s is a string|")
	CHK_FT_PRINTF_LIST+=("s" "%-.2s is a string|")
	CHK_FT_PRINTF_LIST+=("s" "%-5.2s is a string|")




	# integer
	CHK_FT_PRINTF_LIST+=("d" "% v|42")

	CHK_FT_PRINTF_LIST+=("d" "%d|1")
	CHK_FT_PRINTF_LIST+=("d" "the %d|1")
	CHK_FT_PRINTF_LIST+=("d" "%d is one|1")
	CHK_FT_PRINTF_LIST+=("d" "%d|-1")
	CHK_FT_PRINTF_LIST+=("d" "%d|4242")
	CHK_FT_PRINTF_LIST+=("d" "%d|-4242")
	CHK_FT_PRINTF_LIST+=("d" "%d|2147483647")
	CHK_FT_PRINTF_LIST+=("d" "%d|2147483648")
	CHK_FT_PRINTF_LIST+=("d" "%d|–2147483648")
	CHK_FT_PRINTF_LIST+=("d" "%d|–2147483649")

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
	CHK_FT_PRINTF_LIST+=("d" "%5+d|42")
	CHK_FT_PRINTF_LIST+=("d" "%05d|42")
	CHK_FT_PRINTF_LIST+=("d" "%0+5d|42")
	CHK_FT_PRINTF_LIST+=("d" "%5d|-42")
	CHK_FT_PRINTF_LIST+=("d" "%5+d|-42")
	CHK_FT_PRINTF_LIST+=("d" "%05d|-42")
	CHK_FT_PRINTF_LIST+=("d" "%0+5d|-42")

	CHK_FT_PRINTF_LIST+=("d" "%-5d|42")
	CHK_FT_PRINTF_LIST+=("d" "%-5+d|42")
	CHK_FT_PRINTF_LIST+=("d" "%-05d|42")
	CHK_FT_PRINTF_LIST+=("d" "%-0+5d|42")
	CHK_FT_PRINTF_LIST+=("d" "%-5d|-42")
	CHK_FT_PRINTF_LIST+=("d" "%-5+d|-42")
	CHK_FT_PRINTF_LIST+=("d" "%-05d|-42")
	CHK_FT_PRINTF_LIST+=("d" "%-0+5d|-42")

	# integer short
	CHK_FT_PRINTF_LIST+=("dh" "%hd|0")
	CHK_FT_PRINTF_LIST+=("dh" "%hd|42")
	CHK_FT_PRINTF_LIST+=("dh" "%hd|-42")
	CHK_FT_PRINTF_LIST+=("dh" "%hd|32767")
	CHK_FT_PRINTF_LIST+=("dh" "%hd|−32768")
	CHK_FT_PRINTF_LIST+=("dh" "%hd|32768")
	CHK_FT_PRINTF_LIST+=("dh" "%hd|−32769")

	# integer long
	CHK_FT_PRINTF_LIST+=("dl" "%ld|0")
	CHK_FT_PRINTF_LIST+=("dl" "%ld|42")
	CHK_FT_PRINTF_LIST+=("dl" "%ld|-42")
	CHK_FT_PRINTF_LIST+=("dl" "%ld|2147483647")
	CHK_FT_PRINTF_LIST+=("dl" "%ld|–2147483648")
	CHK_FT_PRINTF_LIST+=("dl" "%ld|2147483648")
	CHK_FT_PRINTF_LIST+=("dl" "%ld|–2147483649")



















	# extra !!
	# integer long long ??
	# m == L
	#CHK_FT_PRINTF_LIST+=("m" "%Ld|0")
	#CHK_FT_PRINTF_LIST+=("m" "%Ld|42")
	#CHK_FT_PRINTF_LIST+=("m" "%Ld|-42")
	#CHK_FT_PRINTF_LIST+=("m" "%Ld|9223372036854775807")
	#CHK_FT_PRINTF_LIST+=("m" "%Ld|–9223372036854775808")
	#CHK_FT_PRINTF_LIST+=("m" "%Ld|9223372036854775808")
	#CHK_FT_PRINTF_LIST+=("m" "%Ld|–9223372036854775809")


fi;
