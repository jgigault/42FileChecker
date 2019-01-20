#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

  function display_credits
  {
    local SEL LEN

    display_splash_screen
    display_header
    printf "${C_INVERT}"
    display_center "  _  _  ____  _____ _ _       ____ _               _              "
    display_center " | || ||___ \|  ___(_) | ___ / ___| |__   ___  ___| | _____ _ __  "
    display_center " | || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ __| |/ / _ \ '__| "
    display_center " |__   _/ __/|  _| | | |  __/ |___| | | |  __/ (__|   <  __/ |    "
    display_center "    |_||_____|_|   |_|_|\___|\____|_| |_|\___|\___|_|\_\___|_|    "
    display_center "                     https://github.com/jgigault/42FileChecker    "
    display_center " "
    printf "${C_CLEAR}"
    printf "\n"
    printf "  %s\n\n" "42FileChecker is a tiny bash script developed at 42 school by jgigault for testing and checking the files according to the rules of the subjects." | fold -s -w "${COLUMNS}"
    printf "  %s\n\n" "The script has the following dependencies:"
    printf "  ${C_WHITE}%s${C_CLEAR}\n" "-> norminette (42 born2code)"
    printf "     %s\n\n" "http://www.42.fr"
    printf "  ${C_WHITE}%s${C_CLEAR}\n" "-> moulitest (yyang42 and other contributors)"
    printf "     %s\n\n" "${MOULITEST_URL}"
    printf "  ${C_WHITE}%s${C_CLEAR}\n" "-> libft-unit-test (alelievr)"
    printf "     %s\n\n" "${LIBFTUNITTEST_URL}"
    printf "  ${C_WHITE}%s${C_CLEAR}\n" "-> fillit_checker (anisg)"
    printf "     %s\n\n" "${EXTERNAL_REPOSITORY_FILLITCHECKER_URL}"
    printf "  ${C_WHITE}%s${C_CLEAR}\n" "-> Maintest (QuentinPerez and other contributors)"
    printf "     %s\n\n" "${EXTERNAL_REPOSITORY_MAINTEST_URL}"
    printf "  ${C_WHITE}%s${C_CLEAR}\n" "-> 42ShellTester (gabkk, jgigault)"
    printf "     %s\n\n" "${EXTERNAL_REPOSITORY_42SHELLTESTER_URL}"
    printf "  ${C_WHITE}%s${C_CLEAR}\n" "-> Text to ASCII Art Generator (patorjk@gmail.com)"
    printf "     %s\n\n" "http://patorjk.com/software/taag/"
    display_menu ""\
      "main" "OK"
  }

fi;
