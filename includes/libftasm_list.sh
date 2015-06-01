#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	declare -a CHK_LIBFTASM_LIST

	CHK_LIBFTASM_LIST+=("strlen" 0 "Empty string" "")
	CHK_LIBFTASM_LIST+=("strlen" 0 "Short string" "42")
	CHK_LIBFTASM_LIST+=("strlen" 0 "Long string" "Montpellier, first mentioned in a document of 985, was founded under a local feudal dynasty, the Guilhem, who combined two hamlets and built a castle and walls around the united settlement. The two surviving towers of the city walls, the Tour des Pins and the Tour de la Babotte, were built later, around the year 1200.")

	CHK_LIBFTASM_LIST+=("bzero" 0 "Nothing to be done" "")
	CHK_LIBFTASM_LIST+=("bzero" 0 "Short string" "This is a string")
	CHK_LIBFTASM_LIST+=("bzero" 1 "Truncated string" "This is a string")
	CHK_LIBFTASM_LIST+=("bzero" 2 "Truncated string #2" "42 is a number")

	CHK_LIBFTASM_LIST+=("memset" 0 "Nothing to be done" "65|")
	CHK_LIBFTASM_LIST+=("memset" 0 "Short string" "65|This is a string")
	CHK_LIBFTASM_LIST+=("memset" 0 "bzero style" "0|This is a string")
	CHK_LIBFTASM_LIST+=("memset" 1 "Replace begining of a string" "66|42 is a number")


fi;

