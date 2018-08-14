#! /usr/bin/env bash

. /helpers/initialisation.sh
color_init

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

	if ([[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]); then
		echo -e "USAGE: display_help() \$1"
		echo -e "\tto display help, the function needs to be called explicity"
		echo -e "\t--help\t\t-h\tdisplays this help and exits."
		echo -e "\t--help\t\t-h\tdisplays this help and exits."
		echo -e "\t--explanation\t-e\texplanation, as to what the programme/function should do"
		exit 0
	fi
}

display_help $1

print_red functions-library
print_noc - to display help, append --help
print_noc - i need to figure out how to make these functions behave like echo. they strip any \\nregexp stuff away

# pass an array to a function
#--> "${a[@]}"

# copy an array
#--> ( "${a[@]}" )

# a function to get all the hosts that are in the sshconfig
get_hosts() {
	if [[ ! -r ~/.ssh/config ]]; then
		printf "no ssh-config-file found! Exiting"
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

#small check
find_in_target() {
	if [[ ! -z $1 ]] || [[ ! -z $2 ]]; then
		echo -e "${YELLOW}args not found $1, $2${NOC}"
	fi
	echo -e "${YELLOW}source: $1 target: $2${NOC}"
}

# over @ the defensive script guid they recommend doing:
# abstact away the -d ==> function directory_exists
# looks like this then:

is_directory() {
	local directory="$1"
	[[ -d "${directory}" ]]
}

is_executable() {
	local executable="$1"
	[[ -x "${executable}" ]]
}

is_directory /var/log && echo "YES" || echo "NO"
is_directory /var/lag && echo "YES" || echo "NO"
is_executable /usr/bin/borg && echo "YES" || echo "NO"
is_executable /usr/bin/borg
if [[ "${?}" == 0 ]]; then
	echo "okilidokili"
fi
is_executable /usr/bin/barg && echo "YES" || echo "NO"

if [[ "$(is_executable "/usr/bin/borg")" == 0 ]]; then
	echo "we do shit"
	echo "i forgot to escape the \" today...."
else
	echo "maybe not..."
fi

# okay that does not work like i want it to
# too much stripping of things away by the interpreter
# what good is a helper function i have to constantly double-check?

scriptname="${0}"
runs=0

if [[ $runs -eq 0 ]]; then
	echo "I have never run before."
elif [[ $runs -eq 1 ]]; then
	echo "I have ran $runs time before."
elif [[ $runs -gt 1 ]]; then
	echo "I have ran $runs times before."
fi

# Set variable for sed
current_run=$runs
# Increment for each run
((runs++))
# Sed to change the runs variable inside the script
sed -i "s/^runs=$current_run/runs=$runs/" $scriptname

print() {

	case "${1^^}" in
	RED)
		printf '\033[0;31m%s\033[0m\n' "${2}"
		;;
	YELLOW)
		printf '\e[33m%s\033[0m\n' "${2}"
		;;
	BLUE)
		printf '\e[33m%s\033[0m\n' "${2}"
		;;
	GREEN)
		printf '\e[0;32m%s\033[0m\n' "${2}"
		;;
	*)
		printf '\033[0m%s\033[0m\n' "${1}"
		;;
	esac

}

# do the coloring thing
print RED "test"
print YELLOW "test"
print "razzie"
print GREEN "with a \nnewline\tdat dont work"
print RED "wit a \"quote\" inside, that works"
print red "small red, we upper that arg"