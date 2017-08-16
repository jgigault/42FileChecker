#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  declare -a CHK_FT_PRINTF_LIST
  declare -a CHK_FT_PRINTF_LIST2


  # easy
  CHK_FT_PRINTF_LIST+=("0" "")
  CHK_FT_PRINTF_LIST+=("0" "\n")
  CHK_FT_PRINTF_LIST+=("0" "test")
  CHK_FT_PRINTF_LIST+=("0" "test\n")
  CHK_FT_PRINTF_LIST+=("0" "1234")

  # wrong flag
  CHK_FT_PRINTF_LIST2+=("0" "%")
  CHK_FT_PRINTF_LIST2+=("0" "% ")
  CHK_FT_PRINTF_LIST2+=("0" "% h")
  CHK_FT_PRINTF_LIST2+=("0" "%Z")
  CHK_FT_PRINTF_LIST2+=("0" "% hZ")

  # %
  CHK_FT_PRINTF_LIST+=("0" "%%")
  CHK_FT_PRINTF_LIST+=("0" "%5%")
  CHK_FT_PRINTF_LIST+=("0" "%-5%")
  CHK_FT_PRINTF_LIST2+=("0" "%05%")
  CHK_FT_PRINTF_LIST2+=("0" "%-05%")
  CHK_FT_PRINTF_LIST2+=("0" "% hZ%")
  CHK_FT_PRINTF_LIST+=("0" "%.0%")

  CHK_FT_PRINTF_LIST2+=("s" "% Z|test")
  CHK_FT_PRINTF_LIST2+=("s" "% Z |test")
  CHK_FT_PRINTF_LIST2+=("s" "% Z%s|test")
  CHK_FT_PRINTF_LIST+=("s" "%%|test")
  CHK_FT_PRINTF_LIST+=("s" "%   %|test")
  CHK_FT_PRINTF_LIST2+=("s" "%000   %|test")
  CHK_FT_PRINTF_LIST2+=("s" "%%%|test")
  CHK_FT_PRINTF_LIST2+=("s" "%%   %|test")

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

  CHK_FT_PRINTF_LIST+=("x" "%#x|42")
  CHK_FT_PRINTF_LIST2+=("x" "%ll#x|9223372036854775807")
  CHK_FT_PRINTF_LIST+=("x" "%#llx|9223372036854775807")

  CHK_FT_PRINTF_LIST+=("x" "%#x|0")
  CHK_FT_PRINTF_LIST+=("x" "%#x|42")
  CHK_FT_PRINTF_LIST+=("x" "%#X|42")
  CHK_FT_PRINTF_LIST+=("x" "%#8x|42")
  CHK_FT_PRINTF_LIST+=("x" "%#08x|42")
  CHK_FT_PRINTF_LIST+=("x" "%#-08x|42")

  CHK_FT_PRINTF_LIST+=("d" "@moulitest: %#.x %#.0x|0|0")
  CHK_FT_PRINTF_LIST+=("d" "@moulitest: %.x %.0x|0|0")
  CHK_FT_PRINTF_LIST+=("d" "@moulitest: %5.x %5.0x|0|0")

  # string
  CHK_FT_PRINTF_LIST+=("s" "%s|abc")
  CHK_FT_PRINTF_LIST+=("s" "%s|this is a string")
  CHK_FT_PRINTF_LIST+=("s" "%s |this is a string")
  CHK_FT_PRINTF_LIST+=("s" "%s  |this is a string")
  CHK_FT_PRINTF_LIST+=("s" "this is a %s|string")
  CHK_FT_PRINTF_LIST+=("s" "%s is a string|this")
  CHK_FT_PRINTF_LIST+=("s" "Line Feed %s|\n")

  CHK_FT_PRINTF_LIST+=("s" "%10s is a string|this")
  CHK_FT_PRINTF_LIST2+=("s" "%010s is a string|this")
  CHK_FT_PRINTF_LIST+=("s" "%.2s is a string|this")
  CHK_FT_PRINTF_LIST+=("s" "%5.2s is a string|this")
  CHK_FT_PRINTF_LIST+=("s" "%10s is a string|")
  CHK_FT_PRINTF_LIST+=("s" "%.2s is a string|")
  CHK_FT_PRINTF_LIST+=("s" "%5.2s is a string|")

  CHK_FT_PRINTF_LIST+=("s" "%-10s is a string|this")
  CHK_FT_PRINTF_LIST2+=("s" "%-010s is a string|this")
  CHK_FT_PRINTF_LIST+=("s" "%-.2s is a string|this")
  CHK_FT_PRINTF_LIST+=("s" "%-5.2s is a string|this")
  CHK_FT_PRINTF_LIST+=("s" "%-10s is a string|")
  CHK_FT_PRINTF_LIST+=("s" "%-.2s is a string|")
  CHK_FT_PRINTF_LIST+=("s" "%-5.2s is a string|")

  CHK_FT_PRINTF_LIST+=("s" "%s %s|this|is")
  CHK_FT_PRINTF_LIST+=("s" "%s %s %s|this|is|a")
  CHK_FT_PRINTF_LIST+=("s" "%s %s %s %s|this|is|a|multi")
  CHK_FT_PRINTF_LIST+=("s" "%s %s %s %s string. gg!|this|is|a|multi|string")
  CHK_FT_PRINTF_LIST+=("s" "%s%s%s%s%s|this|is|a|multi|string")

  CHK_FT_PRINTF_LIST+=("sN" "@moulitest: %s|NULL")
  CHK_FT_PRINTF_LIST+=("dN" "%.2c|NULL")
  CHK_FT_PRINTF_LIST+=("sN" "%s %s|NULL|string")

  # c
  CHK_FT_PRINTF_LIST+=("dc" "%c|42")
  CHK_FT_PRINTF_LIST+=("dc" "%5c|42")
  CHK_FT_PRINTF_LIST2+=("dc" "%05c|42")
  CHK_FT_PRINTF_LIST+=("dc" "%-5c|42")
  CHK_FT_PRINTF_LIST+=("dc" "@moulitest: %c|0")
  CHK_FT_PRINTF_LIST+=("dc" "%2c|0")
  CHK_FT_PRINTF_LIST+=("dc" "null %c and text|0")
  CHK_FT_PRINTF_LIST+=("dc" "% c|0")

  # o
  CHK_FT_PRINTF_LIST+=("d" "%o|40")
  CHK_FT_PRINTF_LIST+=("d" "%5o|41")
  CHK_FT_PRINTF_LIST+=("d" "%05o|42")
  CHK_FT_PRINTF_LIST+=("d" "%-5o|2500")
  CHK_FT_PRINTF_LIST+=("d" "%#6o|2500")
  CHK_FT_PRINTF_LIST+=("d" "%-#6o|2500")
  CHK_FT_PRINTF_LIST+=("d" "%-05o|2500")
  CHK_FT_PRINTF_LIST+=("d" "%-5.10o|2500")
  CHK_FT_PRINTF_LIST+=("d" "%-10.5o|2500")
  CHK_FT_PRINTF_LIST+=("d" "@moulitest: %o|0")
  CHK_FT_PRINTF_LIST+=("d" "@moulitest: %.o %.0o|0|0")
  CHK_FT_PRINTF_LIST+=("d" "@moulitest: %5.o %5.0o|0|0")
  CHK_FT_PRINTF_LIST+=("d" "@moulitest: %#.o %#.0o|0|0")
  CHK_FT_PRINTF_LIST+=("d" "@moulitest: %.10o|42")

  # integer
  CHK_FT_PRINTF_LIST2+=("d" "% Z|42")

  CHK_FT_PRINTF_LIST+=("d" "%d|1")
  CHK_FT_PRINTF_LIST+=("d" "the %d|1")
  CHK_FT_PRINTF_LIST+=("d" "%d is one|1")
  CHK_FT_PRINTF_LIST+=("d" "%d|-1")
  CHK_FT_PRINTF_LIST+=("d" "%d|4242")
  CHK_FT_PRINTF_LIST+=("d" "%d|-4242")
  CHK_FT_PRINTF_LIST+=("d" "%d|2147483647")
  CHK_FT_PRINTF_LIST+=("d" "%d|2147483648")
  CHK_FT_PRINTF_LIST+=("d" "%d|-2147483648")
  CHK_FT_PRINTF_LIST+=("d" "%d|-2147483649")

  CHK_FT_PRINTF_LIST+=("d" "% d|42")
  CHK_FT_PRINTF_LIST+=("d" "% d|-42")
  CHK_FT_PRINTF_LIST2+=("d" "%0 d|42")
  CHK_FT_PRINTF_LIST2+=("d" "%0 d|-42")
  CHK_FT_PRINTF_LIST2+=("d" "% 0d|42")
  CHK_FT_PRINTF_LIST2+=("d" "% 0d|-42")

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
  CHK_FT_PRINTF_LIST2+=("d" "%5+d|42")
  CHK_FT_PRINTF_LIST+=("d" "%05d|42")
  CHK_FT_PRINTF_LIST+=("d" "%0+5d|42")
  CHK_FT_PRINTF_LIST+=("d" "%5d|-42")
  CHK_FT_PRINTF_LIST2+=("d" "%5+d|-42")
  CHK_FT_PRINTF_LIST+=("d" "%05d|-42")
  CHK_FT_PRINTF_LIST+=("d" "%0+5d|-42")

  CHK_FT_PRINTF_LIST+=("d" "%-5d|42")
  CHK_FT_PRINTF_LIST2+=("d" "%-5+d|42")
  CHK_FT_PRINTF_LIST+=("d" "%-05d|42")
  CHK_FT_PRINTF_LIST2+=("d" "%-0+5d|42")
  CHK_FT_PRINTF_LIST+=("d" "%-5d|-42")
  CHK_FT_PRINTF_LIST2+=("d" "%-5+d|-42")
  CHK_FT_PRINTF_LIST+=("d" "%-05d|-42")
  CHK_FT_PRINTF_LIST2+=("d" "%-0+5d|-42")

  # integer short
  CHK_FT_PRINTF_LIST+=("dh" "%hd|32767")
  CHK_FT_PRINTF_LIST+=("dh" "%hd|−32768")
  CHK_FT_PRINTF_LIST+=("dh" "%hd|32768")
  CHK_FT_PRINTF_LIST+=("dh" "%hd|−32769")

  # signed char
  CHK_FT_PRINTF_LIST+=("dH" "%hhd|127")
  CHK_FT_PRINTF_LIST+=("dH" "%hhd|128")
  CHK_FT_PRINTF_LIST+=("dH" "%hhd|-128")
  CHK_FT_PRINTF_LIST+=("dH" "%hhd|-129")

  # integer long
  CHK_FT_PRINTF_LIST+=("dl" "%ld|2147483647")
  CHK_FT_PRINTF_LIST+=("dl" "%ld|-2147483648")
  CHK_FT_PRINTF_LIST+=("dl" "%ld|2147483648")
  CHK_FT_PRINTF_LIST+=("dl" "%ld|-2147483649")

  # integer long long
  CHK_FT_PRINTF_LIST+=("dL" "%lld|9223372036854775807")
  CHK_FT_PRINTF_LIST+=("dL" "%lld|-9223372036854775808")

  # interger intmax_t
  CHK_FT_PRINTF_LIST+=("dj" "%jd|9223372036854775807")
  CHK_FT_PRINTF_LIST+=("dj" "%jd|-9223372036854775808")

  # interger size_t
  CHK_FT_PRINTF_LIST+=("dz" "%zd|4294967295")
  CHK_FT_PRINTF_LIST+=("dz" "%zd|4294967296")
  CHK_FT_PRINTF_LIST+=("dz" "%zd|-0")
  CHK_FT_PRINTF_LIST+=("dz" "%zd|-1")

  CHK_FT_PRINTF_LIST+=("d" "%d|1")
  CHK_FT_PRINTF_LIST+=("d" "%d %d|1|-2")
  CHK_FT_PRINTF_LIST+=("d" "%d %d %d|1|-2|33")
  CHK_FT_PRINTF_LIST+=("d" "%d %d %d %d|1|-2|33|42")
  CHK_FT_PRINTF_LIST+=("d" "%d %d %d %d gg!|1|-2|33|42|0")

  # accuracy
  CHK_FT_PRINTF_LIST+=("d" "%4.15d|42")
  CHK_FT_PRINTF_LIST+=("d" "%.2d|4242")
  CHK_FT_PRINTF_LIST+=("d" "%.10d|4242")
  CHK_FT_PRINTF_LIST+=("d" "%10.5d|4242")
  CHK_FT_PRINTF_LIST+=("d" "%-10.5d|4242")
  CHK_FT_PRINTF_LIST+=("d" "% 10.5d|4242")
  CHK_FT_PRINTF_LIST+=("d" "%+10.5d|4242")
  CHK_FT_PRINTF_LIST+=("d" "%-+10.5d|4242")
  CHK_FT_PRINTF_LIST+=("d" "%03.2d|0")
  CHK_FT_PRINTF_LIST+=("d" "%03.2d|1")
  CHK_FT_PRINTF_LIST+=("d" "%03.2d|-1")
  CHK_FT_PRINTF_LIST+=("d" "@moulitest: %.10d|-42")
  CHK_FT_PRINTF_LIST+=("d" "@moulitest: %.d %.0d|42|43")
  CHK_FT_PRINTF_LIST+=("d" "@moulitest: %.d %.0d|0|0")
  CHK_FT_PRINTF_LIST+=("d" "@moulitest: %5.d %5.0d|0|0")

  # u
  CHK_FT_PRINTF_LIST+=("u" "%u|0")
  CHK_FT_PRINTF_LIST+=("u" "%u|1")
  CHK_FT_PRINTF_LIST+=("u" "%u|-1")
  CHK_FT_PRINTF_LIST+=("u" "%u|4294967295")
  CHK_FT_PRINTF_LIST+=("u" "%u|4294967296")

  CHK_FT_PRINTF_LIST+=("u" "%5u|4294967295")
  CHK_FT_PRINTF_LIST+=("u" "%15u|4294967295")
  CHK_FT_PRINTF_LIST+=("u" "%-15u|4294967295")
  CHK_FT_PRINTF_LIST+=("u" "%015u|4294967295")
  CHK_FT_PRINTF_LIST+=("u" "% u|4294967295")
  CHK_FT_PRINTF_LIST+=("u" "%+u|4294967295")

  CHK_FT_PRINTF_LIST+=("ul" "%lu|4294967295")
  CHK_FT_PRINTF_LIST+=("ul" "%lu|4294967296")
  CHK_FT_PRINTF_LIST+=("ul" "%lu|-42")

  CHK_FT_PRINTF_LIST+=("uL" "%llu|4999999999")

  CHK_FT_PRINTF_LIST+=("uj" "%ju|4999999999")

  CHK_FT_PRINTF_LIST+=("uz" "%ju|4294967296")

  CHK_FT_PRINTF_LIST+=("uU" "%U|4294967295")
  CHK_FT_PRINTF_LIST+=("uU" "%hU|4294967296")
  CHK_FT_PRINTF_LIST+=("uU" "%U|4294967296")

  CHK_FT_PRINTF_LIST+=("u" "@moulitest: %.5u|42")

  # mistaken
  CHK_FT_PRINTF_LIST2+=("uz" "%zhd|4294967296")
  CHK_FT_PRINTF_LIST2+=("uL" "%jzd|9223372036854775807")
  CHK_FT_PRINTF_LIST2+=("uL" "%jhd|9223372036854775807")
  CHK_FT_PRINTF_LIST2+=("uL" "%lhl|9223372036854775807")
  CHK_FT_PRINTF_LIST2+=("uL" "%lhlz|9223372036854775807")
  CHK_FT_PRINTF_LIST2+=("uL" "%zj|9223372036854775807")
  CHK_FT_PRINTF_LIST2+=("ul" "%lhh|2147483647")
  CHK_FT_PRINTF_LIST2+=("ul" "%hhld|128")
  CHK_FT_PRINTF_LIST2+=("d" "@main_ftprintf: %####0000 33..1..#00d\n|256")
  CHK_FT_PRINTF_LIST2+=("d" "@main_ftprintf: %####0000 33..1d|256")

  CHK_FT_PRINTF_LIST2+=("d" "@main_ftprintf: %###-#0000 33...12..#0+0d|256")

fi;
