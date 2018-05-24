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
		awk '/Host / { print $2 }' ~/.ssh/config | nl -w 2
	fi
}
get_hosts

# Use word splitting to trim whitespace.
trim() {
    set -f
    set -- $*
    printf "%s\\n" "$*"
    set +f
}


# INCOMPLETE !!!!
# check if directory exists
_dir_check(){
if [[ -n "$1" ]] && [[ -d "$1" ]]; then
  return 0
else
  return 1
fi
}

_dir_check "$backup_target" 
_dir_check "$backup_path"
#if [[ _dir_check "$backup_target" eq 0 ]]; then
#  echo "success"
#fi
#if [[ $(_dir_check "$backup_path") -eq 0 ]]; then
#  echo "more success"
#fi
