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

script_init

# DESC: Initialise colour variables
# ARGS: None
# OUTS: Read-only variables with ANSI control codes
# NOTE: If --no-colour was set the variables will be empty

function _colors_init() {

    RED='\033[0;31m' 
    readonly "${RED}"
 #   readonly YELLOW='\e[33m'
 #   readonly NOC='\033[0m'
 #   readonly BLUE='\e[34m'
 #   readonly GREEN='\e[0;32m'

}
_colors_init

# DESC: print usage information
# ARGS: None
# OUTS: None
# NOTE: must be customised to script to provide sensible info, duh.

usage(){

echo -e "${RED}${scriptName} [OPTION]... [FILE]...${NOC}

script template: what does it do? what is its function that is beyond the
comprehension of the filename?

${RED} Options:${NOC}
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

${RED} Prerequisites:${NOC}
    - file is located within home directory
    - file is one of *.service, (*.timer)
"
}
# usage

# Trap bad exits with cleanup function
script_finish(){
  echo "TODO: Cleanup functions: ERROR CODE: $?"
}
# trap script_finish EXIT INT TERM

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


function main() {

    echo -e "within main"
    # okay, this one in need to test first...
#    source "$(dirname "${BASH_SOURCE[0]}")/source.sh"

#    trap script_trap_err ERR
#    trap script_trap_exit EXIT
    trap script_finish EXIT INT TERM

    printf '%s%b' "$1" "$ta_none"
    echo -e "before init"
    _colors_init
    script_init
    if [[ ! -z "$@" ]];then
        usage
    fi    
}


# Make it rain
main "$@"