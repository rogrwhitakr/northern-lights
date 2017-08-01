#! /bin/sh


############################ func ############################


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

############################ exec ############################ 

display_help() {

	if [[ "$1" = "--help" ]]; then
		echo "help"
		exit 0
	
	else 
		echo "no arg \"--help\" sent"	
		echo "$1"
		exit 127
	fi	
}

print_red functions-library
print_noc  - to display help, append --help
print_noc  - i need to figure out how to make these functions behave like echo. they strip any regexp stuff away
display_help