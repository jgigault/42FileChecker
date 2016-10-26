#!/bin/bash

if [ "${FILECHECKER_SH}" == "1" ]
then

  declare CONF_LIBFT_NAME="libft"
  declare CONF_LIBFT_DISPLAYNAME="LIBFT"
  declare CONF_LIBFT_FUNCTIONMAIN="check_project_libft"
  declare CONF_LIBFT_FUNCTIONTESTALL="check_project_libft_all"
  declare CONF_LIBFT_AUTHORFILE="mandatory"
  declare CONF_LIBFT_TESTS="CHK_LIBFT"
  declare CONF_LIBFT_FORBIDDENFUNCS="CHK_LIBFT_AUTHORIZED_FUNCS"

  declare -a CHK_LIBFT='( "check_author" "author file" "check_libft_required_exists" "required functions" "check_libft_bonus_exists" "bonus" "check_libft_extra" "extra functions" "check_norme" "norminette" "check_libft_static" "static declarations" "check_libft_makefile" "makefile" "check_libft_forbidden_func" "forbidden functions" "check_libft_moulitest" "moulitest (${MOULITEST_URL})" "check_libft_libftunittest" "libft-unit-test (${LIBFTUNITTEST_URL})" "check_libft_extrep_maintest" "Maintest (${EXTERNAL_REPOSITORY_MAINTEST_URL})" )'

  declare -a LIBFT_MANDATORIES='(libft.h ft_strcat.c ft_strncat.c ft_strlcat.c ft_strchr.c ft_strnstr.c ft_strrchr.c ft_strclr.c ft_strcmp.c ft_strncmp.c ft_strcpy.c ft_strncpy.c ft_strdel.c ft_strdup.c ft_strequ.c ft_strnequ.c ft_striter.c ft_striteri.c ft_strjoin.c ft_strlen.c ft_strmap.c ft_strmapi.c ft_strnew.c ft_strstr.c ft_strsplit.c ft_strsub.c ft_strtrim.c ft_atoi.c ft_itoa.c ft_tolower.c ft_toupper.c ft_putchar.c ft_putchar_fd.c ft_putstr.c ft_putstr_fd.c ft_putnbr.c ft_putnbr_fd.c ft_putendl.c ft_putendl_fd.c ft_isalnum.c ft_isalpha.c ft_isascii.c ft_isdigit.c ft_isprint.c ft_memalloc.c ft_memchr.c ft_memcmp.c ft_memcpy.c ft_memccpy.c ft_memdel.c ft_memmove.c ft_memset.c ft_bzero.c)'

  declare -a LIBFT_BONUS='(ft_lstnew.c ft_lstdelone.c ft_lstdel.c ft_lstiter.c ft_lstadd.c ft_lstmap.c)'

  declare -a LIBFT_EXTRA='()'

  function check_project_libft_main
  {
    local LOCAL_UPDATE_RETURN=""

    if [ "${OPT_NO_MOULITEST}" == "0" ]
    then
      check_update_external_repository "moulitest" "${MOULITEST_URL}" "${MOULITEST_DIR}"
      case "${LOCAL_UPDATE_RETURN}" in
        "exit") main; return ;;
      esac
    fi
    if [ "${OPT_NO_LIBFTUNITTEST}" == "0" ]
    then
      check_update_external_repository "libft-unit-test" "${LIBFTUNITTEST_URL}" "${LIBFTUNITTEST_DIR}"
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
    if [ "${GLOBAL_IS_INTERACTIVE}" == "0" ]
    then
      ${CONF_LIBFT_FUNCTIONTESTALL}
    else
      ${CONF_LIBFT_FUNCTIONMAIN}
    fi
  }

  function check_project_libft
  {
    local MYPATH

    MYPATH=$(get_config "${CONF_LIBFT_NAME}")
    display_header
    display_top "${MYPATH}" LIBFT
    if [ -d "${MYPATH}" ]
    then
      display_menu\
        ""\
        "${CONF_LIBFT_FUNCTIONTESTALL}" "check all!"\
        "_"\
        "TESTS" "${CONF_LIBFT_TESTS}" "${CONF_LIBFT_FUNCTIONTESTALL}"\
        "_"\
        "check_configure \"${CONF_LIBFT_FUNCTIONMAIN}\" \"${CONF_LIBFT_NAME}\" \"${CONF_LIBFT_DISPLAYNAME}\"" "change path"\
        main "BACK TO MAIN MENU"
    else
      display_menu\
        ""\
        "check_configure \"${CONF_LIBFT_FUNCTIONMAIN}\" \"${CONF_LIBFT_NAME}\" \"${CONF_LIBFT_DISPLAYNAME}\"" "configure"\
        main "BACK TO MAIN MENU"
    fi
  }

  function check_project_libft_all
  {
    local TESTONLY="${1}" MYPATH

    MYPATH=$(get_config "${CONF_LIBFT_NAME}")
    configure_moulitest "${CONF_LIBFT_NAME}" "${MYPATH}"
    display_header
    display_top "${MYPATH}" "${CONF_LIBFT_DISPLAYNAME}"
    utils_launch_tests "${TESTONLY}" "${CONF_LIBFT_TESTS}"
    display_menu\
      ""\
      "${CONF_LIBFT_FUNCTIONMAIN}" "OK"\
      "open .myLIBFT_MANDATORIES" "more info: required functions"\
      "open .myLIBFT_BONUS" "more info: bonus functions"\
      "open .myextra" "more info: extra functions"\
      "open .mynorminette" "more info: norminette"\
      "open .mystatic" "more info: static declarations"\
      "open .mymakefile" "more info: makefile"\
      "open .myforbiddenfunc" "more info: forbidden functions"\
      "open .mymoulitest" "more info: moulitest"\
      "open .mylibftunittest" "more info: libft-unit-test"\
      "open .mymaintest_libft" "more info: Maintest"\
      "_"\
      "open https://github.com/jgigault/42FileChecker/issues/new" "REPORT A BUG ON 42FILECHECKER"\
      "open ${MOULITEST_URL}/issues/new" "REPORT A BUG ON MOULITEST"\
      "open ${LIBFTUNITTEST_URL}/issues/new" "REPORT A BUG ON LIBFT-UNIT-TEST"\
      "open ${EXTERNAL_REPOSITORY_MAINTEST_URL}/issues/new" "REPORT A BUG ON MAINTEST"\
      main "BACK TO MAIN MENU"
  }

  function check_libft_makefile
  {
    if [ "$OPT_NO_MAKEFILE" == "0" ]
    then
      check_makefile "${MYPATH}" "libft.a"
      return "${?}"
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_libft_bonus_exists
  {
    if [ "$OPT_NO_LIBFTFILESEXIST" == "0" ]
    then
      check_fileexists LIBFT_BONUS "${MYPATH}"
      return "${?}"
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_libft_required_exists
  {
    if [ "$OPT_NO_LIBFTFILESEXIST" == "0" ]
    then
      check_fileexists LIBFT_MANDATORIES "${MYPATH}"
      return "${?}"
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_libft_forbidden_func
  {
    local F FILEN

    if [ "$OPT_NO_FORBIDDEN" == "0" ]
    then
      if [ -f "${MYPATH}/Makefile" -o -f "${MYPATH}/makefile" ]
      then
        FILEN=forbiddenfuncs
        F=$RETURNPATH/tmp/$FILEN.c
        LIBFTH=`find "$MYPATH" -name libft.h`
        check_create_tmp_dir
        echo "#define NULL ((void *)0)" > $F
        echo "#include \"$LIBFTH\"" >> $F
        echo "int main(void) {" >> $F
        echo "ft_putstr(NULL);" >> $F
        echo "ft_memset(NULL, 0, 0);" >> $F
        echo "ft_bzero(NULL, 0);" >> $F
        echo "ft_memcpy(NULL, NULL, 0);" >> $F
        echo "ft_memccpy(NULL, NULL, 0, 0);" >> $F
        echo "ft_memmove(NULL, NULL, 0);" >> $F
        echo "ft_memchr(NULL, 0, 0);" >> $F
        echo "ft_memcmp(NULL, NULL, 0);" >> $F
        echo "ft_strlen(NULL);" >> $F
        echo "ft_strdup(NULL);" >> $F
        echo "ft_strcpy(NULL, NULL);" >> $F
        echo "ft_strncpy(NULL, NULL, 0);" >> $F
        echo "ft_strcat(NULL, NULL);" >> $F
        echo "ft_strncat(NULL, NULL, 0);" >> $F
        echo "ft_strlcat(NULL, NULL, 0);" >> $F
        echo "ft_strchr(NULL, 0);" >> $F
        echo "ft_strrchr(NULL, 0);" >> $F
        echo "ft_strstr(NULL, NULL);" >> $F
        echo "ft_strnstr(NULL, NULL, 0);" >> $F
        echo "ft_strcmp(NULL, NULL);" >> $F
        echo "ft_strncmp(NULL, NULL, 0);" >> $F
        echo "ft_atoi(NULL);" >> $F
        echo "ft_isalpha(0);" >> $F
        echo "ft_isdigit(0);" >> $F
        echo "ft_isalnum(0);" >> $F
        echo "ft_isascii(0);" >> $F
        echo "ft_isprint(0);" >> $F
        echo "ft_toupper(0);" >> $F
        echo "ft_tolower(0);" >> $F
        echo "ft_memalloc(0);" >> $F
        echo "ft_memdel(NULL);" >> $F
        echo "ft_strnew(0);" >> $F
        echo "ft_strdel(NULL);" >> $F
        echo "ft_strclr(NULL);" >> $F
        echo "ft_striter(NULL, NULL);" >> $F
        echo "ft_striteri(NULL, NULL);" >> $F
        echo "ft_strmap(NULL, NULL);" >> $F
        echo "ft_strmapi(NULL, NULL);" >> $F
        echo "ft_strequ(NULL, NULL);" >> $F
        echo "ft_strnequ(NULL, NULL, 0);" >> $F
        echo "ft_strsub(NULL, 0, 0);" >> $F
        echo "ft_strjoin(NULL, NULL);" >> $F
        echo "ft_strtrim(NULL);" >> $F
        echo "ft_strsplit(NULL, 0);" >> $F
        echo "ft_itoa(0);" >> $F
        echo "ft_putchar(0);" >> $F
        echo "ft_putchar_fd(0, 0);" >> $F
        echo "ft_putstr(NULL);" >> $F
        echo "ft_putstr_fd(NULL, 0);" >> $F
        echo "ft_putendl(NULL);" >> $F
        echo "ft_putendl_fd(NULL, 0);" >> $F
        echo "ft_putnbr(0);" >> $F
        echo "ft_putnbr_fd(0, 0);" >> $F
        RET0=`check_fileexists LIBFT_BONUS "${MYPATH}" | grep 'All files were found'`
        if [ "$RET0" != "" ]
        then
          echo "ft_lstnew(NULL, 0);" >> $F
          echo "ft_lstdelone(NULL, NULL);" >> $F
          echo "ft_lstdel(NULL, NULL);" >> $F
          echo "ft_lstadd(NULL, NULL);" >> $F
          echo "ft_lstiter(NULL, NULL);" >> $F
          echo "ft_lstmap(NULL, NULL);" >> $F
        fi
        echo "return (1); }" >> $F
        cd "$RETURNPATH"/tmp
        make re -C "$MYPATH" 1>../.myforbiddenfunc 2>&1
        if [ -f "$MYPATH/libft.a" ]
        then
          $CMD_RM -f "$FILEN"
          RET0=`gcc "$F" -L"$MYPATH" -lft -o "$FILEN" 1>../.myforbiddenfunc 2>&1`
          cd "$RETURNPATH"
          if [ -f "./tmp/$FILEN" ]
          then
            check_forbidden_func "${CONF_LIBFT_FORBIDDENFUNCS}" "./tmp/$FILEN"
            return "${?}"
          else
            printf "%s" "Compilation has failed"
            return 1
          fi
        else
          printf "%s" "libft.a not found"
          return 1
        fi
      else
        printf "%s" "Makefile not found"
        return 1
      fi
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_libft_extra
  {
    local i j exists TOTAL TOTAL2 RET0 LOGFILENAME

    if [ "$OPT_NO_LIBFTFILESEXIST" == "0" ]
    then
      LOGFILENAME=.myextra
      $CMD_RM -f $LOGFILENAME $LOGFILENAME
      $CMD_TOUCH $LOGFILENAME $LOGFILENAME
      TOTAL=0
      TOTAL2=0
      for i in $(ls -R1 "$MYPATH" | sed '/^\.\/\./d' | grep -E \\.\[c\]$)
      do
        j=0
        exists=0
        while [ "$exists" == "0" -a "${LIBFT_MANDATORIES[$j]}" != "" ]
        do
          if [ "${LIBFT_MANDATORIES[$j]}" == "$i" ]
          then
            exists=1
            (( TOTAL += 1 ))
          fi
          (( j += 1 ))
        done
        j=0
        while [ "$exists" == "0" -a "${LIBFT_BONUS[$j]}" != "" ]
        do
          if [ "${LIBFT_BONUS[$j]}" == "$i" ]
          then
            exists=1
            (( TOTAL += 1 ))
          fi
          (( j += 1 ))
        done
        if [ "$exists" == "0" ]
        then
          (( TOTAL2 += 1 ))
          RET0=$RET0"Extra function: $i\n"
        fi
      done
      echo "$RET0" > $LOGFILENAME
      if [ "$TOTAL2" == "0" ]
      then
        printf "%s" "No extra functions were found"
        return 255
      else
        if [ "$TOTAL2" == "1" ]
        then
          printf "%s" "1 extra function was found"
        else
          printf "%s" "${TOTAL2} extra functions were found"
        fi
        return 0
      fi
    fi
    printf "%s" "Not performed"
    return 255
  }

  function check_libft_moulitest
  {
    local RET0

    if [ "${OPT_NO_MOULITEST}" == "0" ]
    then
      RET0=`check_fileexists LIBFT_BONUS "${MYPATH}" | grep 'All files were found'`
      if [ "$RET0" == "" ]
      then
        check_moulitest "libft_part2"
      else
        check_moulitest "libft_bonus"
      fi
      return "${?}"
    fi
    return 255
  }

  function check_libft_libftunittest
  {
    if [ "${OPT_NO_LIBFTUNITTEST}" == "0" ]
    then
      check_libftunittest
      return "${?}"
    fi
    return 255
  }

  function check_libft_extrep_maintest
  {
    if [ "${OPT_NO_MAINTEST}" == "0" ]
    then
      check_maintest_libft ".mymaintest_libft" "${MYPATH}"
      return "${?}"
    fi
    return 255
  }

  function check_libft_static
  {
    local RET0 TOTAL LOGFILENAME

    if [ "${OPT_NO_STATICDECLARATIONS}" == "0" ]
    then
      LOGFILENAME=.mystatic
      $CMD_RM -f $LOGFILENAME $LOGFILENAME
      $CMD_TOUCH $LOGFILENAME $LOGFILENAME
      RET0=`check_statics "$MYPATH" | tee $LOGFILENAME`
      TOTAL=`echo "$RET0" | wc -l | sed 's/ //g'`
      if [ "$RET0" == "" ]
      then
        printf "%s" "All auxiliary functions are declared as static"
        return 0
      else
        if [ "$RET0" == "Files not found" ]
        then
          printf "%s" "Files not found"
        else
          printf "%s" "${TOTAL} warning(s)"
        fi
        return 1
      fi
    fi
    return 255
  }

  function check_statics
  {
    local TOTAL OLDIFS

    TOTAL=$(find "$1" -type f -name "*.c")
    OLDIFS=${IFS}
    IFS=$'\n'
    if [ "${TOTAL}" == "" ]
    then
      printf "Files not found"
    else
      for i in $(find "$1" -type f -name "*.c")
      do
        FILEN=$(basename "$i")
        awk -v FILEN="${FILEN}" -v FILEN2="${FILEN}" 'BEGIN \
        { \
          OFS = ""
          sub(/\.c/, "", FILEN)
        } \
        $0 ~ /^[a-z_]+[	 ]+\**[a-z_]*\(.*/ \
        { \
          gsub (/^[a-z_]*[	 ]+\**/, "")
          gsub (/ *\(.*$/, "")
          if ($1 != FILEN) \
          { \
            print FILEN2, " (line ", NR, ") : ", $0, "() should be declared as static" \
          } \
        }' "$i"
      done
    fi
    IFS=${OLDIFS}
  }

fi
