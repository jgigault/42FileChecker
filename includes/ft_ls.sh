#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  declare -a CHK_FT_LS='( "check_author" "auteur" "check_norme" "norminette" "check_ft_ls_makefile" "makefile" "check_ft_ls_forbidden_func" "forbidden functions" "check_ft_ls_leaks" "leaks" "check_ft_ls_speedtest" "speed test" "check_ft_ls_moulitest" "moulitest (${MOULITEST_URL})" "check_ft_ls_extrep_maintest" "Maintest (${EXTERNAL_REPOSITORY_MAINTEST_URL})" )'

  function check_ft_ls_main
  {
    local LOCAL_UPDATE_RETURN=""
    if [ "${OPT_NO_MOULITEST}" == "0" ]
    then
      check_update_external_repository "moulitest" "${MOULITEST_URL}" "${MOULITEST_DIR}"
      case "${LOCAL_UPDATE_RETURN}" in
        "exit") main; return ;;
      esac
    fi
    if [ "${OPT_NO_MAINTEST}" == "0" ]
    then
      check_update_external_repository "Maintest" "${EXTERNAL_REPOSITORY_MAINTEST_URL}" "${EXTERNAL_REPOSITORY_MAINTEST_DIR}"
      case "${LOCAL_UPDATE_RETURN}" in
        "exit") main; return ;;
      esac
    fi
    check_ft_ls
  }

  function check_ft_ls_all
  {
    local FUNC TITLE i j j2 k RET0 MYPATH TESTONLY
    TESTONLY="$1"
    MYPATH=$(get_config "ft_ls")
    configure_moulitest "ft_ls" "$MYPATH"
    i=0
    j=1
    k=0
    display_header
    display_top "$MYPATH" FT_LS
    while [ "${CHK_FT_LS[$i]}" != "" ]
    do
      FUNC=${CHK_FT_LS[$i]}
      (( i += 1 ))
      TITLE=`echo "${CHK_FT_LS[$i]}"  | sed 's/%/%%/g'`
      j2=`ft_itoa "$j"`
      printf "  $C_WHITE${j2} -> $TITLE$C_CLEAR\n"
      if [ "$TESTONLY" == "" -o "$TESTONLY" == "$k" ]
      then
        (eval "$FUNC" "all" > .myret) &
        display_spinner $!
        RET0=`cat .myret | sed 's/%/%%/g'`
        printf "$RET0\n"
        printf "\n"
      else
        printf $C_GREY"  --Not performed--\n"$C_CLEAR
        printf "\n"
      fi
      (( j += 1 ))
      (( i += 1 ))
      (( k += 1 ))
    done
    display_menu\
      ""\
      check_ft_ls "OK"\
      "open .mynorminette" "more info: norminette"\
      "open .mymakefile" "more info: makefile"\
      "open .myforbiddenfunc" "more info: forbidden functions"\
      "open .myleaks" "more info: leaks"\
      "open .myspeedtest" "more info: speed test"\
      "open .mymoulitest" "more info: moulitest"\
      "open .mymaintest_ft_ls" "more info: Maintest"\
      "_"\
      "open https://github.com/jgigault/42FileChecker/issues/new" "REPORT A BUG ON 42FILECHECKER"\
      "open ${MOULITEST_URL}/issues/new" "REPORT A BUG ON MOULITEST"\
      main "BACK TO MAIN MENU"
  }

  function check_ft_ls_speedtest
  {	if [ "$OPT_NO_SPEEDTEST" == "0" ]; then
    local LOGFILENAME
    LOGFILENAME=.myspeedtest
    rm -f $LOGFILENAME
    touch $LOGFILENAME
    check_create_tmp_dir
    make re -C "$MYPATH" >/dev/null 2>&1
    if [ -f "$MYPATH/ft_ls" ]
    then
      check_speedtest "$MYPATH/ft_ls" "ls" "-1lR /" "$LOGFILENAME" "Your program is compared with the original 'ls'.\n\n"
    else
      printf $C_RED"  Fatal error: Cannot compile"$C_CLEAR
    fi
    else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
  }

  function check_ft_ls_leaks
  {	if [ "${OPT_NO_LEAKS}" == "0" ]; then
    local RET0 LOGFILENAME PROGNAME
    LOGFILENAME=".myleaks"
    ${CMD_RM} -f ${LOGFILENAME}
    ${CMD_TOUCH} ${LOGFILENAME}
    make re -C "${MYPATH}" >${LOGFILENAME} 2>&1
    if [ -f "${MYPATH}/ft_ls" ]
    then
      check_leaks "${MYPATH}/ft_ls" "-R /" "${LOGFILENAME}" ""
    else
      printf ${C_RED}"  Fatal error: Cannot compile"${C_CLEAR}
    fi
    else printf ${C_GREY}"  --Not performed--"${C_CLEAR}; fi
  }

  function check_ft_ls_makefile
  {	if [ "$OPT_NO_MAKEFILE" == "0" ]; then
    local MYPATH
    MYPATH=$(get_config "ft_ls")
    check_makefile "$MYPATH" ft_ls
    else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
  }

  function check_ft_ls_forbidden_func
  {	if [ "$OPT_NO_FORBIDDEN" == "0" ]; then
    local RET0
    RET0=`make -C "$MYPATH" 2>&1`
    if [ -f "$MYPATH/ft_ls" ]
    then
      check_forbidden_func CHK_FT_LS_AUTHORIZED_FUNCS "$MYPATH/ft_ls"
    else
      printf $C_RED"  Test not performed (see details)"$C_CLEAR
      echo "$RET0" > .myforbiddenfunc
    fi
    else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
  }

  function check_ft_ls_moulitest
  {	if [ "$OPT_NO_MOULITEST" == "0" ]; then
    check_moulitest "ft_ls"
    else printf $C_GREY"  --Not performed--"$C_CLEAR; fi
  }

  function check_ft_ls_extrep_maintest
  { if [ "${OPT_NO_MAINTEST}" == "0" ]; then
    check_maintest_ft_ls ".mymaintest_ft_ls" "${MYPATH}"
    else printf "  ${C_GREY}%s${C_CLEAR}"  "--Not performed--"; fi
  }

  function check_ft_ls
  {
    local MYPATH
    MYPATH=$(get_config "ft_ls")
    display_header
    display_top "$MYPATH" FT_LS
    if [ -d "$MYPATH" ]
    then
      display_menu\
              ""\
        check_ft_ls_all "check all!"\
        "_"\
        "TESTS" "CHK_FT_LS" "check_ft_ls_all"\
        "_"\
        "check_configure check_ft_ls ft_ls FT_LS" "change path"\
        main "BACK TO MAIN MENU"
    else
      display_menu\
        ""\
        "check_configure check_ft_ls ft_ls FT_LS" "configure"\
        main "BACK TO MAIN MENU"
    fi
  }

fi
