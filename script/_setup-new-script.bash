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
	readonly script_dir="$(dirname "$script_path")"
	readonly script_name="$(basename "$script_path")"
	readonly script_params="$*"
}

# DESC: print usage information
# ARGS: None
# OUTS: None
# NOTE: must be customised to script to provide sensible info, duh.

usage() {

	echo -e "./${RED}${script_name} [NAME]...[DEPENDENCY OPTION]...${NOC}

# DESC: Helper for setting up a new script
# ARGS: name of the future script
# OUTS: copy of the script template in <repo>/script named to specification
#       copy of usage depencency named to specification

Script Version: ${version}

${RED} OPTIONS:${NOC}
    -n  future script name
    -d  use dependency template
    -h  Display help, version and exit

    Debugging options:
    -s  Exit script with null variables.  i.e 'set -o nounset'
    -v  verbose
    -d  run script in debug-mode (set -x)

${RED} PREREQUISITES / REQUIREMENTS:${NOC}
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

script_finish(){
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

function color_init() {
	readonly RED='\033[0;31m'
	readonly YELLOW='\e[33m'
	readonly NOC='\033[0m'
	readonly BLUE='\e[34m'
	readonly GREEN='\e[0;32m'
}

choice_init(){

while getopts ":n:dfqlhsvd" opt; do
    case "${opt}" in
        n) # script name
            n=${OPTARG}
            return "${n}"
            ;;
        d) # dependency template or all-in-one template?
            d=${OPTARG} 
            echo "building new script with dependencies set..."
            return "${d}"
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

shift $((OPTIND -1))
}

function main() {

  # main seem sto assume some inits first...
    echo -e "${YELLOW}first we check choices${NOC}"
    choice_init "${@}"

    local test="declared testvar"
    
    echo -e "${script_name}"
    echo -e "${YELLOW}within main${NOC}"
}

# init the helpers
script_init
color_init

trap script_finish EXIT INT TERM

# Make it rain
main "$@"
