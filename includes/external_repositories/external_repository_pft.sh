#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function check_pft_php_installed
  {
    local RET
    RET=`php -v 2>/dev/null | grep -c "PHP" | tr -d " \t"`
    if [ "$RET" == "0" ] ; then
      return 0
    fi
    return 1
  }

  function pft_append_disabled_tests_list
  {
    echo "\n" >> .mypft
    echo "==========================" >> .mypft
    echo "  Disabled Tests" >> .mypft
    echo "==========================" >> .mypft
    echo "" >> .mypft
    ${PFT_DIR}"/show-disabled-tests" >> .mypft
  }

  function check_pft
  {
    local RET0 RET1 TOTAL MYPATH PASSED TOTAL
    if [ "$OPT_NO_PFT" == "0" ] ; then
      rm -f .mypft
      check_pft_php_installed
      if ! [ "${?}" -eq 1 ] ; then
        printf "%s" "Requires PHP"
        return 255
      fi
      if ! [ -d "${PFT_DIR}" ] ; then
        printf "%s" "Not installed"
        return 1
      fi
      MYPATH=$(get_config "ft_printf")
      make -C "${PFT_DIR}" re 1> .mypft 2>&1
      # Check compilation
      RET1=`cat .mypft`
      RET0=`echo "$RET1" | grep -c "error"`
      if ! [ "$RET0" == "0" ] ; then
        printf "%s" "Cannot compile"
        return 1
      fi
      # Run tests
      "${PFT_DIR}/test" 1> .mypft-tmp1 2>&1
        # Analyze results
      RET1=`cat .mypft-tmp1`
      RET0=`echo "$RET1" | grep "Tests completed."`
      if [ "$RET0" == "" ] ; then
        printf "%s" "PFT has aborted"
        return 1
      fi
      # Get test results summary
      PASSED=`echo "$RET0" | cut -d ' ' -f 3 | cut -d '/' -f 1`
      TOTAL=`echo "$RET0" | cut -d ' ' -f 3 | cut -d '/' -f 2`
      printf "%s" "${PASSED}/${TOTAL} tests passed"
      if [ "$PASSED" == "$TOTAL" ] ; then
        # Output test summary
        cat .mypft-tmp1 > .mypft
        pft_append_disabled_tests_list
        rm .mypft-tmp1
        check_cleanlog .mypft
        return 0
      fi
      # Output detailed tests results and test summary
      cat .mypft-tmp1 | head -n 4 > .mypft
      echo "\nResults of failed tests:\n\n" >> .mypft
      cat .pft_results.txt >> .mypft 2>/dev/null
      rm .pft_results.txt 2>/dev/null
      echo "\nTest Summary:" >> .mypft
      cat .mypft-tmp1 >> .mypft
      rm .mypft-tmp1
      pft_append_disabled_tests_list
      check_cleanlog .mypft
      return 1
    fi
    printf "%s" "Not performed"
    return 255
  }

  function configure_pft
  {
    [ "$OPT_NO_PFT" != "0" ] && return
    check_pft_php_installed
    if ! [ "${?}" -eq 1 ] ; then
      return
    fi
    [ -d "${PFT_DIR}" ] || return
    php ${PFT_DIR}/configurations/42fc/configure_42fc.php $1
  }

fi;
