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

print_blue() {
	if [[ -z "$@" ]]; then
		echo "print_red(): no args set"
	fi	  	
	NOC='\033[0m'
	BLUE='\e[34m'
	echo -e ${BLUE}"$@"${NOC}
}
############################ exec ############################ 

display_help() {

	if ( [[ "$1" = "--help" ]] || [[ "$1" = "-h" ]] ); then
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

# pass an array to a function
#--> "${a[@]}"

# copy an array
#--> ( "${a[@]}" )

# a function to get all the hosts that are in the sshconfig
get_hosts() {

	if [[ ! -r ~/.ssh/config ]]; then
		printf "no ssh-config-file found! Exiting"
		exit 1 
	else
		awk '/Host / { print $2 "\t\t\t" $3 "\t\t\t" $4 }' ~/.ssh/config | nl -w 2
	fi
}

get_hosts