#! /usr/bin/env bash

source "../script/helpers/init.bash"

print line

print RED "Enter solution"
print YELLOW "read -rsp \$\'Press enter to continue...\n\'"
read -rsp $'Press enter to continue...\n'

print RED "Escape solution \(with -d \$\'\e\'\)"
print YELLOW "read -rsp \$\'Press escape to continue...\n\' -d \$\'\e\'"
read -rsp $'Press escape to continue...\n' -d $'\e'

print RED "Any key solution \(with -n 1\)"
print YELLOW "read -rsp \$\'Press any key to continue...\n\' -n 1 key"
read -rsp $'Press any key to continue...\n' -n 1 key
print BLUE "$key"

print RED "Question with preselected choice \(with -ei \$\'Y\'\)"""
print YELLOW "read -rp \$\'Are you sure \(Y/n\) : \' -ei \$\'Y\' key;"
read -rp $'Are you sure (Y/n) : ' -ei $'Y' key;
print BLUE "$key"

read -rp $'Continue (Y/n) : ' -ei $'Y' continue_key;

print RED "Timeout solution \(with -t 5\)"
print YELLOW "read -rsp \$\'Press any key or wait 5 seconds to continue...\n\' -n 1 -t 5;"
read -rsp $'Press any key or wait 5 seconds to continue...\n' -n 1 -t 5;

print RED "Sleep enhanced alias"
print YELLOW "read -rst 0.5; timeout=$?"
# read -rst 0.5; timeout=$?
# print BLUE "$timeout"

print RED "Explanation"
cat EOF << " 
-r specifies raw mode, which don't allow combined characters like "\" or "^".
-s specifies silent mode, and because we don't need keyboard output."

-p $'prompt' specifies the prompt, which need to be between $' and ' to let spaces and escaped characters. Be careful, you must put between single quotes with dollars symbol to benefit escaped characters, otherwise you can use simple quotes.
-d $'\e' specifies escappe as delimiter charater, so as a final character for current entry, this is possible to put any character but be careful to put a character that the user can type.
-n 1 specifies that it only needs a single character.
-e specifies readline mode.
-i $'Y' specifies Y as initial text in readline mode.
-t 5 specifies a timeout of 5 seconds
key serve in case you need to know the input, in -n1 case, the key that has been pressed.
$? serve to know the exit code of the last program, for read, 142 in case of timeout, 0 correct input. Put $? in a variable as soon as possible if you need to test it after somes commands, because all commands would rewrite $?
"
EOF

# read assigns REPLY automatically
read
echo ${REPLY}

exit 0