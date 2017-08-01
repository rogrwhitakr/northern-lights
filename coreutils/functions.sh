#! /bin/sh


############################ func ############################


printline() {
	echo [---------------------------------------------------------------------]
}

print_red() {
	if [[ -z "$@" ]]; then
		echo -e "print_red(): no args set"
	fi	  	
	RED='\033[0;31m'
	NOC='\033[0m'
	echo -e ${RED}"$@"${NOC}
}

print_yellow() {
	if [[ -z "$@" ]]; then
		echo -e "print_red(): no args set"
	fi	  	
	YELLOW='\e[33m'
	NOC='\033[0m'
	echo -e ${YELLOW}COMMAND: "$@"${NOC}
	echo 
}

print_noc() {
	if [[ -z "$@" ]]; then
		echo -e "print_red(): no args set"
	fi

	NOC='\033[0m'
	echo -e ${NOC}"$@"${NOC}
}

############################ exec ############################ 

display_help() {

	if [[ "$1" = "--help" ]]; then
		echo -e "USAGE: display_help() \$1"
		echo -e "\tto display help, the function needs to be called explicity"
		echo -e "\t--help\t\t-h\tdisplays this help and exits."
		echo -e "\t--help\t\t-h\tdisplays this help and exits."
		echo -e "\t--explanation\t-e\texplanation, as to what the programme/function should do"
		exit 0
	
	else 
		continue
	fi	
}

display_help $1

print_red functions-library
print_noc  - to display help, append --help
print_noc  - i need to figure out how to make these functions behave like echo. they strip any \\nregexp stuff away 

# ok i need to check the input for "\", then double that one up

isplay_help() \$1"

grep -E "[\]"