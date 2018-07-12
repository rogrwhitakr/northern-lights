# ######################################################################################
# variables
#   maybe look into replacing with true / false as the man page for "false" hilariously
#   lets you know:NAME
#       false - do nothing, unsuccessfully

quiet=0
verbose=0
force=0
strict=0
debug=0

# ######################################################################################
# functions

# DESC: debugging options
# ARGS: Flags debug, strict set 
# OUTS: debugging info
# INFO: is called right away

flags_init(){
    local quiet=${quiet}
    local verbose=${verbose}
    local force=${force}
    local strict=${strict}
    local debug=${debug}

    # enforce running in debug mode
    # one `COULD` build a unset -x functionality also...
    if [[ "${debug}" = "1" ]]; then
        set -x
    fi
    # Exit on empty variable
    if [[ "${strict}" = "1" ]]; then
        set -o nounset
    fi

    # Bash will remember & return the highest exitcode in a chain of pipes.
    # This way you can catch the error in case mysqldump fails in `mysqldump |gzip`, for example.
    set -o pipefail

    # Exit on error. Append '||true' when you run the script if you expect an error.
    set -o errexit

    if [[ "${verbose}" = "1" ]]; then
        echo -e "
        Flag settings:
        quiet   =${quiet}
        verbose =${verbose}
        force   =${force}
        strict  =${strict}
        debug   =${debug}"
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

# DESC: Generic script initialisation
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: $exec_path: The current working directory when the script was run
#       $script_path: The full path to the script
#       $script_dir: The directory path of the script
#       $script_name: The file name of the script

# additional explainer:
# ${BASH_SOURCE[0]} (or, more simply, $BASH_SOURCE[1] ) contains the (potentially relative) path 
# of the containing script in all invocation scenarios, notably also when the script is sourced, 
# which is not true for $0.
# integrate ${BASH_SOURCE[1]%/*}

script_init() {
    local exec_path="$PWD"
    readonly script_path="${BASH_SOURCE[1]}"
    readonly script_dir="$(dirname "$script_path")"
    readonly script_name="$(basename "$script_path")"
    readonly script_params="$*"
}