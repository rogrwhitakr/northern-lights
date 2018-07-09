#! /usr/bin/env bash

# ######################################################################################
# BASH SCRIPT TEMPLATE
#   HISTORY:
#
#   2018-06-13 - v1.0.0  -  First Creation (mostly by stealing from others)
#   2018-06-15 - v1.1.0  -  got some understanding as to what some parts do,
#                           the debugging set is pretty awesome. wrapping in a function
#                           may need to be rethought
#   2018-06-27 - v0.2.2  -  all getoptsy stuff is in the choice function now
#                           cleaned up calling order of functions, before main
#   2018-07-09 - v0.2.3  -  unififed ALL helper functions in this template script
#                           should always be the same as de DEPENDENCY template one
#
# ######################################################################################
# VARIABLES

version="0.2.3"

# DESC: debugging options
# ARGS: Flags debug, strict set
# OUTS: debugging info
# INFO: is called right away

flags_init() {
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
		echo -e "
        Flag settings:
        quiet   =${quiet}
        verbose =${verbose}
        force   =${force}
        strict  =${strict}
        debug   =${debug}"
	fi
}

# DESC: print usage information
# ARGS: None
# OUTS: None
# NOTE: must be customised to script to provide sensible info, duh.

usage() {

	echo -e "${RED}${script_name} [OPTION]... [FILE]...${NOC}

script template: what does it do? what is its function that is beyond the
comprehension of the filename?

Script Version: ${version}

${RED} OPTIONS:${NOC}
    -u  Username for script
    -p  User password
    -f  force, skip all user interaction.  Implied 'Yes' to all actions.
    -q  Quiet (no output)
    -l  Print log to file
    -h  Display help, version and exit

    Debugging options:
    -s  Exit script with null variables.  i.e 'set -o nounset'
    -v  verbose
    -d  run script in debug-mode (set -x)

${RED} PREREQUISITES / REQUIREMENTS:${NOC}
    - file is located within home directory
    - file is one of *.service, (*.timer)

${RED} EXAMPLES:${NOC}
    - Create a timer 
        ${script_name} borg-backup.timer
    - Create a Service
        ${script_name} virtual-machines.service
"
}

#   ERROR CODES - not in use so far
EXIT_SUCCESS=0
EXIT_FAILURE=1
EXIT_ERROR=2
EXIT_BUG=10

# DESC: Initialise colour variables
# ARGS: None
# OUTS: Read-only variables with ANSI control codes
# NOTE: If --no-colour was set the variables will be empty

function color_init() {
	readonly RED='\033[0;31m'
	readonly YELLOW='\e[33m'
	readonly NOC='\033[0m'
	readonly BLUE='\e[34m'
	readonly GREEN='\e[0;32m'
}

# DESC: Generic script initialisation
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: $exec_path: The current working directory when the script was run
#       $script_path: The full path to the script
#       $script_dir: The directory path of the script
#       $script_name: The file name of the script

function script_init() {
	local exec_path="$PWD"
	readonly script_path="${BASH_SOURCE[1]}"
	readonly script_dir="$(dirname "$script_path")"
	readonly script_name="$(basename "$script_path")"
	readonly script_params="$*"
}

# DESC: print usage information
# ARGS: None
# OUTS: None
# NOTE: must be customised to script to provide sensible info, duh.

usage() {

	echo -e "${RED}${script_name} [OPTION]... [FILE]...${NOC}

script template: what does it do? what is its function that is beyond the
comprehension of the filename?

Script Version: ${version}

${RED} OPTIONS:${NOC}
    -u  Username for script
    -p  User password
    -f  force, skip all user interaction.  Implied 'Yes' to all actions.
    -q  Quiet (no output)
    -l  Print log to file
    -h  Display help, version and exit

    Debugging options:
    -s  Exit script with null variables.  i.e 'set -o nounset'
    -v  verbose
    -d  run script in debug-mode (set -x)

${RED} PREREQUISITES / REQUIREMENTS:${NOC}
    - file is located within home directory
    - file is one of *.service, (*.timer)

${RED} EXAMPLES:${NOC}
    - Create a timer 
        ${script_name} borg-backup.timer
    - Create a Service
        ${script_name} virtual-machines.service
"
}

# DESC: Trap exits with cleanup function
# ARGS: exit code -> trap <script_finish> EXIT INT TERM
# OUTS: None (so far)
# INFO: ERROR_CODE is put in local var, b/c otherwise one gets the return code
#       of the most recently completed command
#       (and i dont care for knowing "echo" ran successfully...)

script_finish() {

	local ERROR_CODE="$?"
	if [[ "${ERROR_CODE}" == 0 ]]; then
		echo -e "${GREEN}exit green, no errors${NOC}"
		echo -e "ERROR CODE: ${ERROR_CODE}"
	else
		echo -e "${RED}exit RED${NOC}"
		echo -e "ERROR CODE: ${ERROR_CODE}"
	fi
	echo -e "${YELLOW}trap::script_finish::handler -> ${ERROR_CODE}${NOC}"
}

# DESC: any and all flags go here for evaluation
# NOTE: can this be put in a function to be evaluated? sense?
# ARGS: $@: Arguments provided to the script
# OUTS: go for main

color_init
flags_init
choice_init() {

	while getopts ":u:p:fqlhsvd" opt; do
		case "${opt}" in
		u) # user
			u=${OPTARG}
			id -u "${u}" &&
				echo "success!" ||
				return "${ERROR_USER_UNKNOWN}"
			;;
		p) # password
			p=${OPTARG}
			if [[ -z "${OPTARG}" ]]; then
				echo -e "no value provided for password!"
				usage
			fi
			echo "-p was triggered, Parameter: $OPTARG" >&2
			;;

		# force -> this seems a bit difficult / or needs to be handled with care.
		# anytime "read" or sudo command occurs, i will need to pass the thngy provided
		# read is probably easy, but needs to be incorporated into the script then
		# sudo, hm. i will need to look at that one....
		f)
			force flag # force
			f=${OPTARG}
			;;
		q)
			q=${OPTARG}
			;;
		l)
			l=${OPTARG}
			;;
		h)
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
		#p) -> pid would be something...
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

# DESC: the core function of the script
# NOTE: The creation of readonly variables in dependent functions (like color_init)
#       failed, moving these functions AFTER the main function seemed to solve this
#       THIS CANNOT STAND. WHY is this happening?
#       Okay, seems it was the flag stuff
# ARGS: $@: Arguments provided to the script
# OUTS: Magic!

function main() {

	local test="declared testvar"

	script_init
	echo -e "${script_name}"
	echo -e "${YELLOW}within main${NOC}"
	trap script_finish EXIT INT TERM

}

# Make it rain
main "$@"
