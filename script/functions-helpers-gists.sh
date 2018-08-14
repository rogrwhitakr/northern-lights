#! /usr/bin/env bash

printline() {
	echo [---------------------------------------------------------------------]
}

printline

printline() {

	separator="-"
	# set the separator (length must be 1)
	if ([[ ! -z "$1" ]] && [[ "${#1}" == 1 ]]); then
		separator="${1}"
	fi

	# get number of columns
	term_size="$(tput cols)"

	# add to a line variable
	line="["
	for ((i = 1; i <= "${term_size}-2"; i++)); do
		line+="${separator}"
	done
	line+="]"
	# regurgitate to terminal
	printf "${line}"
}

printline

printline "X"

printline "mo'than one column"

printline a

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
	LINE)
		separator="-"										# separator default
		line="["											# adding to a "line" variable
		term_size="$(tput cols)"							# get number of columns
		if ([[ ! -z "$2" ]] && [[ "${#2}" == 1 ]]); then	# set custom the separator (length must be 1)
			separator="${2}"
		fi
		for ((i = 1; i <= "${term_size}-2"; i++)); do		# make the line
			line+="${separator}"
		done
		line+="]"
		printf "${line}"									# regurgitate to terminal
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
print line 
print RED "wit a \"quote\" inside, that works"
print line X
print red "small red, we upper that arg"
