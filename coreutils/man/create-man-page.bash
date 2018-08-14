#! /usr/bin/env bash

# ######################################################################################
# BASH SCRIPT TEMPLATE
#   HISTORY:
#
#   2018-08-13 - v1.0.0  -  First Creation
#
# ######################################################################################
# VARIABLES

version="1.0.0"

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
		echo -e "
        Flag settings:
        quiet   =${quiet}
        verbose =${verbose}
        force   =${force}
        strict  =${strict}
        debug   =${debug}"
	fi
}

color_init() {

	# DESC: Initialise colour variables
	# ARGS: None
	# OUTS: Read-only variables with ANSI control codes
	# NOTE: If --no-colour was set the variables will be empty

	readonly RED='\033[0;31m'
	readonly YELLOW='\e[33m'
	readonly NOC='\033[0m'
	readonly BLUE='\e[34m'
	readonly GREEN='\e[0;32m'
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
	readonly script_dir="$(dirname "$script_path")"
	readonly script_name="$(basename "$script_path")"
	readonly script_params="$*"
}

usage() {

	# DESC: print usage information
	# ARGS: None
	# OUTS: None
	# NOTE: must be customised to script to provide sensible info, duh.

	echo -e "./${RED}${script_name} [OPTION]... [FILE]...${NOC}

script template: what does it do? what is its function that is beyond the
comprehension of the filename?

Script Version: ${version}

${RED} OPTIONS:${NOC}
	-n	Name
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
        ./${script_name} borg-backup.timer
    - Create a Service
        ./${script_name} virtual-machines.service
"
}

script_finish() {

	# DESC: Trap exits with cleanup function
	# ARGS: exit code -> trap <script_finish> EXIT INT TERM
	# OUTS: None (so far)
	# INFO: ERROR_CODE is put in local var, b/c otherwise one gets the return code
	#       of the most recently completed command
	#       (and i dont care for knowing "echo" ran successfully...)

	local ERROR_CODE="$?"
	if [[ "${ERROR_CODE}" == 0 ]]; then
		echo -e "${GREEN}exit green, no errors${NOC}"
		echo -e "ERROR CODE: ${ERROR_CODE}"
	elif [[ "${ERROR_CODE}" == 16 ]]; then
		echo -e "${RED}man: At least one of the pages/files/keywords didn't exist or wasn't matched.${NOC}"
	else
		echo -e "${RED}exit RED${NOC}"
		echo -e "ERROR CODE: ${ERROR_CODE}"
	fi
	echo -e "${YELLOW}trap::script_finish::handler -> ${ERROR_CODE}${NOC}"
}

color_init
flags_init
choice_init() {

	# DESC: any and all flags go here for evaluation
	# NOTE: can this be put in a function to be evaluated? sense?
	# ARGS: $@: Arguments provided to the script
	# OUTS: go for main

	t=false

	while getopts ":f:thsvd" opt; do
		case "${opt}" in

		f) # manfile
			f=${OPTARG}
			if [[ -z "${OPTARG}" ]]; then
				echo -e "file: no value provided!"
				usage
			fi
			;;

		t) # test manfile
			readonly t=true
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

main() {

	choice_init "${@}"
	script_init
	trap script_finish EXIT INT TERM

	# start
	local mantest="${t}"
	local manpage="${f}"

	if [[ "${mantest}" == true ]]; then
		echo -e "${RED}testing man-page ${manpage}${NOC}"
		mandir="$(find -wholename "${manpage}")"
		sleep 2
		man "${mandir}"
		exit 0
	fi
}

choice_init

# Make it rain
main "$@"
