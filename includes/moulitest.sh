#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	function check_moulitest
	{	if [ "$OPT_NO_MOULITEST" == "0" ]; then
		local RET0 RET1 TOTAL
		rm -f .mymoulitest
		if [ -d "${MOULITEST_DIR}" ]
		then
			make "$1" -C "${MOULITEST_DIR}" 1> .mymoulitest 2>&1
			check_cleanlog .mymoulitest
			RET1=`cat .mymoulitest`
			RET0=`echo "$RET1" | grep "STARTING ALL UNIT TESTS"`
			if [ "$RET0" == "" ]
			then
			    printf $C_RED"  Fatal error: moulitest cannot compile (see more info)"$C_CLEAR
			else
			    RET0=`echo "$RET1" | grep "END OF UNIT TESTS"`
			    if [ "$RET0" == "" ]
			    then
			        printf $C_RED"  Fatal error: moulitest has aborted (see more info)"$C_CLEAR
			    else
			        RET0=`echo "$RET1" | grep FAIL`
			        if [ "$RET0" != "" ]
			        then
			            TOTAL=`printf "%s\n" "$RET0" | wc -l | sed 's/ //g'`
			            printf $C_RED"  $TOTAL failed test(s)"$C_CLEAR
			        else
			            printf $C_GREEN"  All Unit Tests passed"$C_CLEAR
			        fi
			    fi
			fi
		else
			printf $C_RED"  'moulitest' is not installed"$C_CLEAR
		fi
		else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
	}

    function configure_moulitest
    {
	local LPATH=$(printf "%s" "$2" | sed 's/ /\\ /g')
        case "$1" in
            "libft")
                echo "LIBFT_PATH = \"${LPATH}\"" > "$RETURNPATH"/"${MOULITEST_DIR}"/config.ini
                ;;
            "gnl")
                echo "GET_NEXT_LINE_PATH = \"${LPATH}\"" > "$RETURNPATH"/"${MOULITEST_DIR}"/config.ini
                ;;
            "ft_ls")
                echo "FT_LS_PATH = \"${LPATH}\"" > "$RETURNPATH"/"${MOULITEST_DIR}"/config.ini
                ;;
            "ft_printf")
                echo "FT_PRINTF_PATH = \"${LPATH}\"" > "$RETURNPATH"/"${MOULITEST_DIR}"/config.ini
                ;;
        esac
    }

fi;