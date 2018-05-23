#! /bin/sh

# TODOs
# incorporate
# http://wiki.bash-hackers.org/commands/builtin/read
# all read possibilities 

#################
### functions ###
#################

printline() {
	echo [---------------------------------------------------------------------]
}

print_red() {
	if [[ -z "$@" ]]; then
		echo "print_red(): no args set"
	fi	  	
	RED='\033[0;31m'
	NOC='\033[0m'
	echo -e ${RED}"$@"${NOC}
}

print_yellow() {
	if [[ -z "$@" ]]; then
		echo "print_red(): no args set"
	fi	  	
	YELLOW='\e[33m'
	NOC='\033[0m'
	echo -e ${YELLOW}COMMAND: "$@"${NOC}
	echo 
}

print_noc() {
	if [[ -z "$@" ]]; then
		echo "print_red(): no args set"
	fi	  	
	NOC='\033[0m'
	echo -e ${NOC}"$@"${NOC}
}

print_blue() {
	if [[ -z "$@" ]]; then
		echo "print_red(): no args set"
	fi	  	
	NOC='\033[0m'
	BLUE='\e[34m'
	echo -e ${BLUE}"$@"${NOC}
}


#################
### execution ###
#################

printline

print_red Enter solution
print_yellow read -rsp \$\'Press enter to continue...\n\'
read -rsp $'Press enter to continue...\n'

print_red Escape solution \(with -d \$\'\e\'\)
print_yellow read -rsp \$\'Press escape to continue...\n\' -d \$\'\e\'
read -rsp $'Press escape to continue...\n' -d $'\e'

print_red Any key solution \(with -n 1\)
print_yellow read -rsp \$\'Press any key to continue...\n\' -n 1 key
read -rsp $'Press any key to continue...\n' -n 1 key
print_blue $key

print_red Question with preselected choice \(with -ei \$\'Y\'\)
print_yellow read -rp \$\'Are you sure \(Y/n\) : \' -ei \$\'Y\' key;
read -rp $'Are you sure (Y/n) : ' -ei $'Y' key;
print_blue $key

read -rp $'Continue (Y/n) : ' -ei $'Y' continue_key;

print_red Timeout solution \(with -t 5\)
print_yellow read -rsp \$\'Press any key or wait 5 seconds to continue...\n\' -n 1 -t 5;
read -rsp $'Press any key or wait 5 seconds to continue...\n' -n 1 -t 5;

print_red Sleep enhanced alias
print_yellow read -rst 0.5; timeout=$?
read -rst 0.5; timeout=$?
print_blue $timeout

print_red Explanation
print_noc -r specifies raw mode, which don't allow combined characters like "\" or "^".
print_noc -s specifies silent mode, and because we don't need keyboard output.
print_noc -p $'prompt' specifies the prompt, which need to be between $' and ' to let spaces and escaped characters. Be careful, you must put between single quotes with dollars symbol to benefit escaped characters, otherwise you can use simple quotes.
print_noc -d $'\e' specifies escappe as delimiter charater, so as a final character for current entry, this is possible to put any character but be careful to put a character that the user can type.
print_noc -n 1 specifies that it only needs a single character.
print_noc -e specifies readline mode.
print_noc -i $'Y' specifies Y as initial text in readline mode.
print_noc -t 5 specifies a timeout of 5 seconds
print_noc key serve in case you need to know the input, in -n1 case, the key that has been pressed.
print_noc $? serve to know the exit code of the last program, for read, 142 in case of timeout, 0 correct input. Put $? in a variable as soon as possible if you need to test it after somes commands, because all commands would rewrite $?

# read assigns REPLY automatically
read
echo ${REPLY}

exit 0