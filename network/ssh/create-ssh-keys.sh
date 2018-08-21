#! /usr/bin/env bash

version="1.0.1"

quiet=0
verbose=0
force=0
strict=0
debug=0

flags_init() {

	# DESC: debugging options
	# ARGS: Flags debug, strict set
	# OUTS: debugging info
	# INFO: is called right away

	local quiet=${quiet}
	local verbose=${verbose}
	local force=${force}
	local strict=${strict}
	local debug=${debug}

	# enforce running in debug mode
	# one `COULD` build a unset -x functionality also...
	if [[ "${debug}" == "1" ]]; then
		set -x
	fi
	# Exit on empty variable
	if [[ "${strict}" == "1" ]]; then
		set -o nounset
	fi

	# Bash will remember & return the highest exitcode in a chain of pipes.
	# This way you can catch the error in case mysqldump fails in `mysqldump |gzip`, for example.
	set -o pipefail

	# Exit on error. Append '||true' when you run the script if you expect an error.
	set -o errexit

	if [[ "${verbose}" == "1" ]]; then
		print "
        Flag settings:
        quiet   =${quiet}
        verbose =${verbose}
        force   =${force}
        strict  =${strict}
        debug   =${debug}"
	fi
}

print() {

	# DESC: pretty print text, lines
	# ARGS: 1 -> Color, line
	#		choices are:
	#			RED
	#			YELLOW
	#			BLUE
	#			GREEN
	#			NOC (no color)
	#			LINE
	#
	# ARGS: 2 -> Text, line element
	# OUTS: colorised text, (non-colorised) line
	# LIMITS:
	#		cannot take formatters (newline,tabs,etc...)
	# EXAMPLE:
	#		print RED "text to be printed red"
	#		print "text to be printed without color"
	#		print LINE
	#		print LINE #

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
		separator="-"            # separator default
		line="["                 # adding to a "line" variable
		term_size="$(tput cols)" # get number of columns
		for ((i = 1; i <= "${term_size}-2"; i++)); do # make the line
			line+="${separator}"
		done
		line+="]"
		printf "${line}" # regurgitate to terminal
		;;
	NOC)
		printf '\033[0m%s\033[0m\n' "${2}"
		;;
	*)
		printf '\033[0m%s\033[0m\n' "${1}"
		;;
	esac
}

script_init() {

	# DESC: Generic script initialisation
	# ARGS: $@ (optional): Arguments provided to the script
	# OUTS: $exec_path: The current working directory when the script was run
	#       $script_path: The full path to the script
	#       $script_dir: The directory path of the script
	#       $script_name: The file name of the script

	local exec_path="$PWD"
	readonly script_path="${BASH_SOURCE[1]}"
	readonly script=$(readlink -f $0)
	readonly script_dir="$(dirname "$script")"
	readonly script_name="$(basename "$script")"
	readonly script_params="$*"

	if [[ "${verbose}" == "1" ]]; then
		print "
        script settings:
        script_path   		=${script_path}
        script_full_path	=${script}
        script_dir   		=${script_dir}
        script_name  		=${script_name}
        script_params   	=${script_params}"
	fi
}

script_finish() {

	# DESC: Trap exits with cleanup function
	# ARGS: exit code -> trap <script_finish> EXIT INT TERM
	# OUTS: None (so far)
	# INFO: ERROR_CODE is put in local var, b/c otherwise one gets the return code
	#       of the most recently completed command
	#       (and i dont care for knowing "echo" ran successfully...)
	# INFO: sourcing this DOES NOT WORK!
	#       any assigned return codes will be overwritten by the "sourcing" retrun code,
	#       so this is useless!!!

	local ERROR_CODE="$?"
	if [[ "${ERROR_CODE}" == 0 ]]; then
		print GREEN "clean exit"
	elif [[ "${ERROR_CODE}" == 20 ]]; then
		print RED "name check: ${name} contains disallowed characters!"
		print "\tallowed characters: [a-zA-Z0-9_-.]"
		print LINE
	elif [[ "${ERROR_CODE}" == 100 ]]; then
		print RED "this script may NOT be run as root!"
		print RED "Exiting..."
		print LINE
	elif [[ "${ERROR_CODE}" == 5 ]]; then
		print YELLOW "no key created, as no name was provided"
		print LINE
	elif [[ "${ERROR_CODE}" == 6 ]]; then
		print YELLOW "Invalid name choice, exiting"
		print LINE
	else
		print RED "Errorcode: ${ERROR_CODE}, removing generated files"
		rm -fv ~/.ssh/"${key_name}.pub"
		rm -fv ~/.ssh/"${key_name}"
	fi
}

usage() {

	# DESC: print usage information
	# ARGS: None
	# OUTS: None
	# NOTE: must be customised to script to provide sensible info, duh.

	print RED "./${script_name} [SSH-KEY-NAME]...[OPTIONS]..."
	print NOC ""
	print NOC "# VERSION:	${version}"
	print NOC "# DESC:		generate a ssh key, set correct permissions, etc"
	print NOC "	"
	print RED "OPTIONS:"
	print NOC "	-n  ssh-key-name					<REQUIRED>"
	print NOC "	-r  remote box(es) the key should be copied to		<OPTIONAL>"
	print NOC "	-h  Display help, version and exit			<OPTIONAL>"
	print NOC ""
	print NOC "	Debugging options:"
	print NOC "	-s  Exit script with null variables.  i.e 'set -o nounset'"
	print NOC "	-v  verbose"
	print NOC "	-d  run script in debug-mode (set -x)"
	print NOC "	"
	print RED "PREREQUISITES / REQUIREMENTS:"
	print NOC "    - name of future ssh key"
	print NOC "	"
	print RED "EXAMPLES:"
	print NOC "    - Create a ssh key and copy it to other boxes "
	print NOC "        ./${script_name} -n demo_it_rsa -r \"box1 box2\""
	print NOC "    - Just create a key"
	print NOC "        ./${script_name} -n demo_it_rsa"
}

choice_init() {

	# DESC: any and all flags go here for evaluation
	# ARGS: $@
	#       default flags (with sourcing)
	#       -h  Display help, version and exit
	#       -s  set strict
	#       -v  verbose
	#       -d  run in debug-mode
	# OUTS: go for main

	while getopts ":n:r:hsvd" opt; do
		case "${opt}" in
		n) # script name
			readonly n=${OPTARG}
			;;
		r) # elements (to add to the file, like init but not unit-file, but also logging...)
			remnotes+=("${OPTARG}") # use array -> ARGS MUST BE -e <thing1> -e <thing2>
			;;
		h) # usage output
			usage
			;;

		# debugging options
		d) # debug
			debug=1
			flags_init ${debug}
			;;
		v) # verbose
			verbose=1
			flags_init ${verbose}
			;;
		s) # strict
			strict=1
			flags_init ${strict}
			;;
		\?)
			echo "Invalid option: $OPTARG" 1>&2
			;;
		:)
			# If no argument is provided getopts will set opt to :.
			# recognize this error condition by catching the : case
			# and printing an appropriate error message.
			echo "Invalid option: $OPTARG requires an argument" 1>&2
			;;

		*)
			echo -e "in *)...\nThis happens, if a flag i spassed that is defined, yet no case..in is available for it"
			;;
		esac
	done

	shift $((OPTIND - 1))
}

createKey() {

	# function to create rsa keys for ssh
	local key_name="${1}"
	local host="${2}"

	if ([[ -z "${host}" ]] || [[ -z "${key_name}" ]]); then
		exit 6
	fi

	# get login user
	user=$(id -un)

	# create dir if not exist
	if [ ! -d ~/.ssh ]; then
		mkdir ~/.ssh/
		chown -c $user ~/.ssh/
		chgrp $user ~/.ssh/
		chmod 700 ~/.ssh/
	fi

	# generate a ssh key
	# maybe we can do some parameterizing later...
	ssh-keygen -t rsa -b 4096 -f ~/.ssh/$1

	# show what has been created
	echo -e "${RED}the contents of public key ${key_name}.pub${NOC}"
	cat ~/.ssh/$key_name.pub
	exit 0
}

# copy ssh key id to remote machine
# ssh-copy-id -i ${key_name}.pub <user>@<remote-box>

root_check() {
	# make sure the script is not run as root
	if [ "$(id -u)" == "0" ]; then
		exit 100
	fi
}

main() {

	local key_name="${n}"
	local hosts="${r}"

	root_check

	if [[ -z "${hosts}" ]]; then
		hosts="localhost"
	fi

	print line
	print "Creating public/private rsa key pair ${key_name} for host: ${hosts}"
	print line

	createKey "${key_name}" "${hosts}"
	print line
}

flags_init
script_init
trap script_finish EXIT INT TERM

# get the choices
choice_init "${@}"
# make it rain
main
