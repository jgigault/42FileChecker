#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  declare -a CHK_LIBFTASM_LIST

  CHK_LIBFTASM_LIST+=("part1" "strcat" 0 "Short strings" "This is |a string")
  CHK_LIBFTASM_LIST+=("part1" "strcat" 0 "Empty string at the end" "This is a string|")
  CHK_LIBFTASM_LIST+=("part1" "strcat" 0 "Empty string at the beginning" "|This is a string")

  CHK_LIBFTASM_LIST+=("part1" "is" 0 "isalpha" "")
  CHK_LIBFTASM_LIST+=("part1" "is" 1 "isdigit" "")
  CHK_LIBFTASM_LIST+=("part1" "is" 2 "isalnum" "")
  CHK_LIBFTASM_LIST+=("part1" "is" 3 "isascii" "")
  CHK_LIBFTASM_LIST+=("part1" "is" 4 "isprint" "")
  CHK_LIBFTASM_LIST+=("part1" "is" 5 "toupper" "")
  CHK_LIBFTASM_LIST+=("part1" "is" 6 "tolower" "")

  CHK_LIBFTASM_LIST+=("part1" "puts" 0 "Empty string" "")
  CHK_LIBFTASM_LIST+=("part1" "puts" 0 "Short string" "42")
  CHK_LIBFTASM_LIST+=("part1" "puts" 0 "Long string" "Montpellier, first mentioned in a document of 985, was founded under a local feudal dynasty, the Guilhem, who combined two hamlets and built a castle and walls around the united settlement. The two surviving towers of the city walls, the Tour des Pins and the Tour de la Babotte, were built later, around the year 1200.")

  CHK_LIBFTASM_LIST+=("part1" "bzero" 0 "Nothing to be done" "")
  CHK_LIBFTASM_LIST+=("part1" "bzero" 0 "Short string" "This is a string")
  CHK_LIBFTASM_LIST+=("part1" "bzero" 1 "Truncated string" "This is a string")
  CHK_LIBFTASM_LIST+=("part1" "bzero" 2 "Truncated string #2" "42 is a number")

  CHK_LIBFTASM_LIST+=("part2" "strlen" 0 "Empty string" "")
  CHK_LIBFTASM_LIST+=("part2" "strlen" 0 "Short string" "42")
  CHK_LIBFTASM_LIST+=("part2" "strlen" 0 "Long string" "Montpellier, first mentioned in a document of 985, was founded under a local feudal dynasty, the Guilhem, who combined two hamlets and built a castle and walls around the united settlement. The two surviving towers of the city walls, the Tour des Pins and the Tour de la Babotte, were built later, around the year 1200.")

  CHK_LIBFTASM_LIST+=("part2" "memset" 0 "Nothing to be done" "65|")
  CHK_LIBFTASM_LIST+=("part2" "memset" 0 "Short string" "65|This is a string")
  CHK_LIBFTASM_LIST+=("part2" "memset" 0 "bzero style" "0|This is a string")
  CHK_LIBFTASM_LIST+=("part2" "memset" 1 "Replace beginning of a string" "66|42 is a number")

  CHK_LIBFTASM_LIST+=("part2" "memcpy" 0 "Nothing to be done" "|0")
  CHK_LIBFTASM_LIST+=("part2" "memcpy" 0 "Nothing to be done #2" "This is a string|0")
  CHK_LIBFTASM_LIST+=("part2" "memcpy" 0 "Short string" "This is a string|16")
  CHK_LIBFTASM_LIST+=("part2" "memcpy" 0 "Short string #2" "This is a string|10")
  CHK_LIBFTASM_LIST+=("part2" "memcpy" 0 "Long string" "Montpellier, first mentioned in a document of 985, was founded under a local feudal dynasty, the Guilhem, who combined two hamlets and built a castle and walls around the united settlement. The two surviving towers of the city walls, the Tour des Pins and the Tour de la Babotte, were built later, around the year 1200.|319")

  CHK_LIBFTASM_LIST+=("part2"  "strdup" 0 "Empty string" "")
  CHK_LIBFTASM_LIST+=("part2" "strdup" 0 "Short string" "42")
  CHK_LIBFTASM_LIST+=("part2" "strdup" 0 "Long string" "Montpellier, first mentioned in a document of 985, was founded under a local feudal dynasty, the Guilhem, who combined two hamlets and built a castle and walls around the united settlement. The two surviving towers of the city walls, the Tour des Pins and the Tour de la Babotte, were built later, around the year 1200.")

  CHK_LIBFTASM_LIST+=("part3" "cat" 0 "Regular file" "./srcs/libftasm/ft_cat.txt")
  CHK_LIBFTASM_LIST+=("part3" "cat" 1 "Invalid file descriptor" "")
  CHK_LIBFTASM_LIST+=("part3" "cat" 2 "Closed file descriptor" "./srcs/libftasm/ft_cat.txt")

  CHK_LIBFTASM_LIST+=("bonus" "memalloc" 0 "Short string" "10")
  CHK_LIBFTASM_LIST+=("bonus" "memalloc" 0 "Long string" "357")

  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Zero" "0")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Simple number" "42")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Negative symbol" "-42")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Positive symbol" "+42")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Negative symbol #2" "--42")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Positive symbol #2" "++42")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Negative symbol #3" "- 42")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Positive symbol #3" "+ 42")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Negative symbol #4" "-")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Positive symbol #4" "+")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Positive and negative symbols" "+-1")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Negative and positive symbols" "-+1")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Spaces before" "        \n\t\v\f\r123")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Spaces everywhere" "  12 34 56  ")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Letters before" "abc123")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Letters in the middle" "1a2b3c")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Positive limit" "2147483647")
  CHK_LIBFTASM_LIST+=("bonus" "atoi" 0 "Negative limit" "-2147483648")

  CHK_LIBFTASM_LIST+=("bonus" "isspace" 0 "isspace" "")
  CHK_LIBFTASM_LIST+=("bonus" "islower" 0 "islower" "")
  CHK_LIBFTASM_LIST+=("bonus" "isupper" 0 "isupper" "")
  CHK_LIBFTASM_LIST+=("bonus" "isnumber" 0 "isnumber" "")
  CHK_LIBFTASM_LIST+=("bonus" "isdigit" 0 "isdigit" "")

  CHK_LIBFTASM_LIST+=("bonus" "memcmp" 0 "First string is empty" "|42FileChecker|13")
  CHK_LIBFTASM_LIST+=("bonus" "memcmp" 0 "Second string is empty" "42FileChecker||10")
  CHK_LIBFTASM_LIST+=("bonus" "memcmp" 0 "Identical strings" "42FileChecker|42FileChecker|13")
  CHK_LIBFTASM_LIST+=("bonus" "memcmp" 0 "First character only" "42FileChecker|52FileChecker|1")
  CHK_LIBFTASM_LIST+=("bonus" "memcmp" 0 "Long strings" "Montpellier, first mentioned in a document of 985, was founded under a local feudal dynasty, the Guilhem, who combined two hamlets and built a castle and walls around the united settlement. The two surviving towers of the city walls, the Tour des Pins and the Tour de la Babotte, were built later, around the year 1200.|Montpellier, first mentioned in a document of 985, was founded under a local feudal dynasty, the Guilhem, who combined two hamlets and built a castle and walls around the united settlement. The two surviving towers of the city walls, the Tour des Pins and the Tour de la Babotte, were built later, around the year 1200.|319")
  CHK_LIBFTASM_LIST+=("bonus" "memcmp" 0 "Long strings #2" "Montpellier, first mentioned in a document of 985, was founded under a local feudal dynasty, the Guilhem, who combined two hamlets and built a castle and walls around the united settlement. The two surviving towers of the city walls, the Tour des Pins and the Tour de la Babotte, were built later, around the year 1200.|Montpellier, first mentioned in a document of 985, was founded under a local feudal dynasty, the Guilhem, who combined two hamlets and built a castle and walls around the united settlement. The two surviving towers of the city walls, the Tour des Pins and the Tour de la Babotte, were built later, around the year 1201.|319")
  CHK_LIBFTASM_LIST+=("bonus" "memcmp" 1 "\\200 character" "\200|\0|1")

  CHK_LIBFTASM_LIST+=("bonus" "memchr" 0 "Locate end of string" "42FileChecker|0|14")
  CHK_LIBFTASM_LIST+=("bonus" "memchr" 0 "Locate beginning of string" "42FileChecker|52|14")
  CHK_LIBFTASM_LIST+=("bonus" "memchr" 0 "Locate inside of string" "42FileChecker|107|13")
  CHK_LIBFTASM_LIST+=("bonus" "memchr" 0 "Size too small" "42FileChecker|107|4")
  CHK_LIBFTASM_LIST+=("bonus" "memchr" 0 "Size null" "42FileChecker|52|0")
  CHK_LIBFTASM_LIST+=("bonus" "memchr" 0 "Byte not found" "42FileChecker|122|13")

  CHK_LIBFTASM_LIST+=("bonus" "strchr" 0 "Locate end of string" "42FileChecker|0")
  CHK_LIBFTASM_LIST+=("bonus" "strchr" 0 "Locate beginning of string" "42FileChecker|52")
  CHK_LIBFTASM_LIST+=("bonus" "strchr" 0 "Locate inside of string" "42FileChecker|107")
  CHK_LIBFTASM_LIST+=("bonus" "strchr" 0 "Locate first occurence" "42FileChecker|101")
  CHK_LIBFTASM_LIST+=("bonus" "strchr" 0 "Byte not found" "42FileChecker|122")

  CHK_LIBFTASM_LIST+=("bonus" "strrchr" 0 "Locate end of string" "42FileChecker|0")
  CHK_LIBFTASM_LIST+=("bonus" "strrchr" 0 "Locate beginning of string" "42FileChecker|52")
  CHK_LIBFTASM_LIST+=("bonus" "strrchr" 0 "Locate beginning of string" "42FileChecker|50")
  CHK_LIBFTASM_LIST+=("bonus" "strrchr" 0 "Locate inside of string" "42FileChecker|107")
  CHK_LIBFTASM_LIST+=("bonus" "strrchr" 0 "Locate last occurence" "42FileChecker|101")
  CHK_LIBFTASM_LIST+=("bonus" "strrchr" 0 "Byte not found" "42FileChecker|122")

fi;

