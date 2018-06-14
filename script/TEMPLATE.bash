#! /usr/bin/env bash

# ######################################################################################
# BASH SCRIPT TEMPLATE
#   HISTORY:
#
#   2018-06-13 - v1.0.0  - First Creation (mostly by stealing from others)
#
# ######################################################################################
# VARIABLES
#   VERSION
version="1.0.0"

#   FLAGS - can be overridden by user input?
quiet=0
printLog=0
verbose=0
force=0
strict=0
debug=0

#   ERROR CODES
EXIT_SUCCESS=0
EXIT_FAILURE=1
EXIT_ERROR=2
EXIT_BUG=10

# ######################################################################################
#   functions -> these need to go somehere else sometime, as they are helpers...

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
    readonly script_bash_source_zero="${BASH_SOURCE[0]}"
}



# DESC: print usage information
# ARGS: None
# OUTS: None
# NOTE: must be customised to script to provide sensible info, duh.

usage(){

echo -e "${RED}${script_name} [OPTION]... [FILE]...${NOC}

script template: what does it do? what is its function that is beyond the
comprehension of the filename?

${RED} OPTIONS:${NOC}
    -u  Username for script
    -p  User password
    -f  force, skip all user interaction.  Implied 'Yes' to all actions.
    -q  Quiet (no output)
    -l  Print log to file
    -s  Exit script with null variables.  i.e 'set -o nounset'
    -v  verbose
    -d  run script in debug-mode (set -x)
    -h  Display this help and exit
    -v  Output version information and exit

${RED} PREREQUISITES:${NOC}
    - file is located within home directory
    - file is one of *.service, (*.timer)

${RED} EXAMPLES:${NOC}
    - Create a timer 
        ${script_name} borg-backup.timer
    - Create a Service
        ${script_name} virtual-machines.service
"
}


# Trap bad exits with cleanup function
script_finish(){
  echo "TODO: Cleanup functions: ERROR CODE: $?"
}

# DESC: the core function of the script
# NOTE: The creation of readonly variables in dependent functions (like color_init)
#       failed, moving these functions AFTER the main function seemed to solve this
#       THIS CANNOT STAND. WHY is this happening?
# ARGS: $@: Arguments provided to the script
# OUTS: Magic!

function main() {

    echo -e "within main"
    script_init
    color_init
    trap script_finish EXIT INT TERM

# TODO: some sourcing of default variables 
# like colors and script vars
#    source "$(dirname "${BASH_SOURCE[0]}")/source.sh"
#    printf '%s%b' "$1" "$ta_none"
    echo -e "${RED}test${NOC}"
    echo "${script_path}"
    usage
}

# Make it rain
main "$@"



# Exit on error. Append '||true' when you run the script if you expect an error.
set -o errexit

# Run in debug mode, if set
if [ "${debug}" == "1" ]; then
  set -x
fi

# Exit on empty variable
if [ "${strict}" == "1" ]; then
  set -o nounset
fi

# Bash will remember & return the highest exitcode in a chain of pipes.
# This way you can catch the error in case mysqldump fails in `mysqldump |gzip`, for example.
set -o pipefail

