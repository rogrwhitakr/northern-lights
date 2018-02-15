# bin/sh

# echo
RED='\033[0;31m'
YELLOW='\e[33m'
NOC='\033[0m'
BLUE='\e[34m'

echo "echo -e = option will print escaped characters"
echo -e "${RED}How to echo / STDIN / STERR / escape stuff in bash ${NOC}"
echo -e "${YELLOW}initalizes an empty repository in `pwd` ${NOC}"

# Bypassing shell aliases
# alias ls='ls -Z'
ls
# only ls command
\ls

# bash has built-in String Variable Manipulation
# with sed:
VAR='HEADERMy voice is my passwordFOOTER'
PASS="$(echo $VAR | sed 's/^HEADER(.*)FOOTER/1/')"
echo $PASS

# bash built-in
VAR='HEADERMy voice is my passwordFOOTER'
PASS="${VAR#HEADER}"
PASS="${PASS%FOOTER}"
echo $PASS

# The # means ‘match and remove the following pattern from the start of the string’
# The % means ‘match and remove the following pattern from the end of the string

# defaults.sh
FIRST_ARG="${1:-no_first_arg}"
SECOND_ARG="${2:-no_second_arg}"
THIRD_ARG="${3:-no_third_arg}"
echo ${FIRST_ARG}
echo ${SECOND_ARG}
echo ${THIRD_ARG}