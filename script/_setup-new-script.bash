#! /usr/bin/env bash

# GLOBAL
#
# DESC: Helper for setting up a new script
# ARGS: name of the future script
# OUTS: copy of the script template in <repo>/script named to specification
#       copy of usage depencency named to specification

version="1.0.0"

quiet=0
verbose=0
force=0
strict=0
debug=0

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

# DESC: Generic script initialisation
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: $exec_path: The current working directory when the script was run
#       $script_path: The full path to the script
#       $script_dir: The directory path of the script
#       $script_name: The file name of the script

function script_init() {
	local exec_path="$PWD"
	readonly script_path="${BASH_SOURCE[1]}"
	readonly script=$(readlink -f $0)
	readonly script_dir="$(dirname "$script")"
	readonly script_name="$(basename "$script")"
	readonly script_params="$*"

	if [[ "${verbose}" == "1" ]]; then
		echo -e "
        script settings:
        script_path   		=${script_path}
        script_full_path	=${script}
        script_dir   		=${script_dir}
        script_name  		=${script_name}
        script_params   	=${script_params}"
	fi
}

# DESC: print usage information
# ARGS: None
# OUTS: None
# NOTE: must be customised to script to provide sensible info, duh.

usage() {

	echo -e "${RED}./${script_name} [NAME]...[DEPENDENCY OPTION]...${NOC}

# DESC: Helper for setting up a new script
# ARGS: name of the future script
# OUTS: copy of the script template in <repo>/script named to specification
#       copy of usage depencency named to specification

Script Version: ${version}

${RED} OPTIONS:${NOC}
    -n  future script name
    -t  use dependency template
    -h  Display help, version and exit

    Debugging options:
    -s  Exit script with null variables.  i.e 'set -o nounset'
    -v  verbose
    -d  run script in debug-mode (set -x)

${RED} PREREQUISITES / REQUIREMENTS:${NOC}
    - name of future script
    - location is <repo>/script

${RED} EXAMPLES:${NOC}
    - Create a script with dependencies 
        ./${script_name} -n testing-NICs.sh -d
    - Create a script with a single file
        ./${script_name} -n testing-NICs.sh
"
}

# DESC: Trap exits with cleanup function
# ARGS: exit code -> trap <script_finish> EXIT INT TERM
# OUTS: None (so far)

script_finish() {
	local ERROR_CODE="$?"
	if [[ "${ERROR_CODE}" != 0 ]]; then
		echo -e "NEED TO REMOVE WHAT WE CREATED!!!!"
	else
		echo -e "ALL IS WELL"
	fi
}

# DESC: Initialise colour variables
# ARGS: None
# OUTS: Read-only variables with ANSI control codes
# NOTE: If --no-colour was set the variables will be empty

color_init() {
	readonly RED='\033[0;31m'
	readonly YELLOW='\e[33m'
	readonly NOC='\033[0m'
	readonly BLUE='\e[34m'
	readonly GREEN='\e[0;32m'
}

# DESC: any and all flags go here for evaluation
# ARGS: $@: Arguments provided to the script
# OUTS: go for main

choice_init() {

	# if not set, dependency setting is false
	t=false

	while getopts ":n:thsvd" opt; do
		case "${opt}" in
		n) # script name
			readonly n=${OPTARG}
			;;
		t) # dependency template or all-in-one template?
			t=true
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

# DESC: null-checks inputs provided to choice_init
# ARGS: $@: Arguments set in choice_init
# OUTS: go for main / usage if not

choice_check() {
	if [ -z "${n}" ]; then
		echo -e "${RED}You must provide a name for the new script !!!${NOC}

printing usage, and exiting script

${RED}usage:${NOC}
"
		usage
		exit 0
	fi
}

# DESC: null-checks inputs provided to choice_init
# ARGS: $@: Arguments set in choice_init
# OUTS: go for main / usage if not
choice_verify() {
	local name="${name}"

	echo 'verification goes here'
	# todo validate choices [a-z0-9]
	# grep verify[a-zA-Z]\\+\( *

	if [[ ${name} =~ ^[a-zA-Z0-9]{1,80}$ ]]; then
		echo 'is okay'
	else
		echo "somehow doidnt pass"
	fi
}

main() {

	echo -e "${YELLOW}within main${NOC}"
	local name="${n}"
	local dependency="${t}"
	choice_check "${name}"
	choice_verify "${name}"

	echo -e "name: ${name}.sh, build with dependencies: ${dependency}"
	read -rp $'Continue (Y/n)? ' -ei $'Y' key
	if [[ "${key}" == "Y" ]]; then
		copy_template "${name}" "${dependency}"
	else
		echo -e "${RED}aborted by user. Exiting${NOC}"
		exit 0
	fi
}

copy_template() {

	local directory=${script_dir}
	local name=${1}
	local dependency=${2}
	local TEMPLATE_WITH_DEPENDENCY="/home/admin/MyScripts/script/template/_TEMPLATE.DEPENDENCY.bash"
	local TEMPLATE_NO_DEPENDENCY="/home/admin/MyScripts/script/template/_TEMPLATE.bash"
	local USAGE="/home/admin/MyScripts/script/helpers/usage.sh"

	echo -e "copying template to ${directory}, name ${name}"
	if [[ "${dependency}" == true ]]; then
		local directory=${script_dir}
		cp "${TEMPLATE_WITH_DEPENDENCY}" "${directory}/${name}.sh"

		#for the depenedncy one we need to copy and amend the usage file and sed the sourcing
		#		mv
	elif [[ "${dependency}" == false ]]; then
		local directory=${script_dir}
		cp "${TEMPLATE_NO_DEPENDENCY}" "${directory}/${name}.sh"
	else
		echo -e "${RED}something went wrong while copying / modifiying the template files${NOC}"
		exit 5
	fi

}

# init the helpers
choice_init "${@}"
script_init
color_init

trap script_finish EXIT INT TERM

# Make it rain
main "$@"

# TODO:check
#[[ -v name_of_var ]]
