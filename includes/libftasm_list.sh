#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	declare -a CHK_LIBFTASM_LIST

	CHK_LIBFTASM_LIST+=("strlen" 0 "")
	CHK_LIBFTASM_LIST+=("strlen" 0 "42")
	CHK_LIBFTASM_LIST+=("strlen" 0 "Montpellier, first mentioned in a document of 985, was founded under a local feudal dynasty, the Guilhem, who combined two hamlets and built a castle and walls around the united settlement. The two surviving towers of the city walls, the Tour des Pins and the Tour de la Babotte, were built later, around the year 1200.")


fi;

