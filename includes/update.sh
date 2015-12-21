#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

function check_update
{
	local RET0
	tput civis
	${CMD_RM} -f .myret
	check_update_42filechecker
	RET0=`cat .myret`
	case "$RET0" in
		"exit") exit_checker; return ;;
		"nothing") tput cnorm; return ;;
	esac
	if [ "${OPT_NO_MOULITEST}" == "0" ]
	then
		${CMD_RM} -f .myret
		check_update_external_repository 'moulitest' ${MOULITEST_URL} ${MOULITEST_DIR}
		RET0=`cat .myret`
		case "$RET0" in
			"exit") exit_checker; return ;;
			"nothing") tput cnorm; return ;;
		esac
	fi
	if [ "${OPT_NO_LIBFTUNITTEST}" == "0" ]
	then
		${CMD_RM} -f .myret
		check_update_external_repository 'libft-unit-test' ${LIBFTUNITTEST_URL} ${LIBFTUNITTEST_DIR}
		RET0=`cat .myret`
		case "$RET0" in
			"exit") exit_checker; return ;;
			"nothing") tput cnorm; return ;;
		esac
	fi
	main
}

function check_update_42filechecker
{	if [ "${OPT_NO_UPDATE}" == "0" ]; then
	local UPTODATE MOULIDATE VERSION RET0 RET1 LOCALHASH REMOTEHASH LOCALBRANCH
	display_header
	printf "\n\n"
	printf "  Checking for updates (42FileChecker)...\n"
	(check_for_updates_42filechecker > .myret) &
	display_spinner $!
	UPTODATE=`cat .myret`
	case "${UPTODATE}" in
	"1")
		printf "continue" > .myret
	;;
	"3")
		display_header "$C_INVERTRED"
		printf "\n\n  Cannot check for updates: Your Internet connection is probably down...\n\n"$C_CLEAR
		display_menu\
			"$C_INVERTRED"\
			"printf 'continue' > .myret" "SKIP UPDATE"\
			"printf 'exit' > .myret" "EXIT"
	;;
	"0")
		LOCALBRANCH=$(git branch | grep '^\*' | cut -d" " -f2)
		LOCALHASH=`git show-ref | grep "refs/heads/${LOCALBRANCH}" | cut -d" " -f1`
		REMOTEHASH=`git ls-remote 2>/dev/null | grep refs/heads/${LOCALBRANCH} | cut -f1`
		CVERSION=$(git log --oneline "refs/heads/${LOCALBRANCH}" | wc -l | sed 's/ //g')
		VERSION=$(git log --oneline "refs/remotes/origin/${LOCALBRANCH}" | wc -l | sed 's/ //g')
		display_header "$C_INVERTRED"
		printf "\n\n"
		printf $C_RED""
		if [ "${REMOTEHASH}" != "${LOCALHASH}" -a "${REMOTEHASH}" != "" -a "${CVERSION}" -lt "${VERSION}" ]
		then
			display_center "Your version of '42FileChecker' is out-of-date."
			display_center "REMOTE: r$VERSION       LOCAL: r$CVERSION"
			RET1=`git log --pretty=oneline "refs/remotes/origin/${LOCALBRANCH}" 2>/dev/null | awk -v lhash=${LOCALHASH} '{if ($1 == lhash) {exit} print}' | cut -d" " -f2- | awk 'BEGIN {LIMIT=0} {print "  -> "$0; LIMIT+=1; if(LIMIT==10) {print "  -> (limited to 10 last commits...)"; exit}}'`
			if [ "$RET1" != "" ]
			then
				printf "\n\n  Most recent commits:\n%s" "$RET1"
			fi
		else
			display_center "Your copy of '42FileChecker' has been modified locally."
			display_center "Skip update if you don't want to erase your changes."
		fi
		printf "\n\n  Choose UPDATE 42FILECHECKER (1) for installing the latest version or skip this warning by choosing SKIP UPDATE (2) or by using '--no-update' at launch.\n\n"$C_CLEAR
		display_menu\
			"$C_INVERTRED"\
			check_install_42filechecker "UPDATE 42FILECHECKER"\
			"printf 'continue' > .myret" "SKIP UPDATE"\
			"printf 'exit' > .myret" "EXIT"
	;;
	esac
	fi
}

function check_update_external_repository
{
	local MOULIDATE
	local REPONAME=$1
	local URL=$2
	local DIR=$3
	display_header
	printf "\n\n"
	printf "  Checking for updates (${REPONAME})...\n"
	(check_for_updates_external_repository ${DIR} > .myret) &
	display_spinner $!
	MOULIDATE=`cat .myret`
	case "${MOULIDATE}" in
	"1") 
		printf "continue" > .myret
	;;
	"3")
		display_header "$C_INVERTRED"
		printf "\n\n  Cannot check for updates: Your Internet connection is probably down...\n\n"$C_CLEAR
		display_menu\
			"$C_INVERTRED"\
			"printf 'continue' > .myret" "SKIP UPDATE"\
			"printf 'exit' > .myret" "EXIT"
	;;
	"0")
		display_header "$C_INVERTRED"
		printf "\n\n"
		printf $C_RED"  Your version of '${REPONAME}' (${URL}) is out-of-date.\n  Choose UPDATE EXTERNAL REPOSITORY (1) for installing the latest version or SKIP UPDATE (2) if you want to skip this warning.\n\n"$C_CLEAR
		display_menu\
			"$C_INVERTRED"\
			"check_install_external_repository ${REPONAME} ${URL} ${DIR}" "UPDATE EXTERNAL REPOSITORY"\
			"printf 'continue' > .myret" "SKIP UPDATE"\
			"printf 'exit' > .myret" "EXIT"
	;;		
	"2")	
		display_header "$C_INVERTRED"
		printf "\n\n"
		printf $C_RED"  The '${REPONAME}' (${URL}) is not installed.\n  Choose INSTALL EXTERNAL REPOSITORY (1) for installing it or SKIP INSTALL (2) if you want to skip this warning.\n\n"$C_CLEAR
		display_menu\
			"$C_INVERTRED"\
			"check_install_external_repository ${REPONAME} ${URL} ${DIR}" "INSTALL EXTERNAL REPOSITORY"\
			"printf 'continue' > .myret" "SKIP INSTALL"\
			"printf 'exit' > .myret" "EXIT"
	;;
	esac
}

function check_for_updates_42filechecker
{
	local DIFF0
	local LOCALBRANCH=$(git branch | grep '^\*' | cut -d" " -f2)
	DIFF0=`git fetch --all 2>&1 | tee .myret2 | grep fatal`
	if [ "$DIFF0" != "" ]
	then
		printf "3"
	else
		DIFF0=`git diff "refs/remotes/origin/${LOCALBRANCH}" 2>&1 | grep -E '^\+|^\-' | sed 's/\"//'`
		if [ "$DIFF0" != "" ]
		then
			printf "0"
		else
			printf "1"
		fi
	fi
}

function check_install_42filechecker
{
	local RES0
	local LOGFILENAME=".myret"
	display_header
	printf "\n\n"
	printf "  Updating 42FileChecker\n"
	${CMD_RM} -f ${LOGFILENAME}
	(git fetch --all >/dev/null 2>&1) &
	display_spinner $!
	(git reset --hard origin/master 2>&1 | grep -v 'HEAD is now at' >${LOGFILENAME}) &
	display_spinner $!
	RES0=`cat ${LOGFILENAME}`
	sleep 0.5
	if [ "${RES0}" == "" ]
	then
		printf ${C_BLUE}"  Done.\n"${C_CLEAR}
		(git shortlog -s | awk 'BEGIN {rev=0} {rev+=$1} END {printf rev"\n"}' >.myrev 2>/dev/null) &
		display_spinner $!
		sleep 0.5
		sh ./42FileChecker.sh
	else
		display_error "An error occured."
		printf ${C_RED}"\n  If the error persists, try discard this directory and clone again.\n"${C_CLEAR}
		tput cnorm
	fi
	printf "nothing" >.myret
}

function check_for_updates_external_repository
{
	local DIFF0 LOCALBRANCH
	local DIR=$1
	if [ ! -d "${DIR}" ]
	then
		printf "2"
	else
		cd "${DIR}"
		LOCALBRANCH=$(git branch | grep '^\*' | cut -d" " -f2)
		DIFF0=`git fetch --all 2>&1 | grep fatal`
		if [ "$DIFF0" != "" ]
		then
			printf "3"
		else
			DIFF0=`git diff "refs/remotes/origin/${LOCALBRANCH}" 2>&1 | grep -E '^\+|^\-' | sed 's/\"//'`
			if [ "$DIFF0" != "" ]
			then
				printf "0"
			else
				printf "1"
			fi
		fi
		cd ..
	fi
}


function check_install_external_repository
{
	local RES0 RES2
	local REPONAME=$1
	local URL=$2
	local DIR=$3
	display_header
	printf "\n\n"
	if [ ! -d "${DIR}" ]
	then
		printf "  Installing ${REPONAME}...\n"
		(git clone "${URL}" "${DIR}" >.myret 2>&1) &
		display_spinner $!
	else
		cd "${DIR}"
		printf "  Updating moulitest...\n"
		((git reset --hard origin/master >../.myret 2>&1) && git checkout master 2>/dev/null) &
		display_spinner $!
		cd ..
	fi
	RES0=`cat .myret`
	RES2=`echo "$RES0" | grep fatal`
	if [ "$RES2" != "" ]
	then
		display_error "An error occured."
		printf $C_RED"$(echo "$RES0" | awk 'BEGIN {OFS=""} {print "  ",$0}')"$C_CLEAR
		printf "\n"
		tput cnorm
		printf "nothing" > .myret
	else
		printf $C_BLUE"  Done.\n"$C_CLEAR
		sleep 0.5
		printf "continue" > .myret
	fi
}

fi