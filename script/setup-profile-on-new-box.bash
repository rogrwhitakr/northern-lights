#! /usr/bin/env bash

# ######################################################################################
# BASH PROFILE SETUP
#   HISTORY:
#
#   2018-06-23 - v1.0.0  -  First Creation 
#
# ######################################################################################
# VARIABLES
#   VERSION
version="0.1.0"

#   FLAGS
quiet=0
verbose=0
force=0
strict=1
debug=1

#   ERROR CODES - not in use so far
EXIT_SUCCESS=0
EXIT_FAILURE=1
EXIT_ERROR=2
EXIT_BUG=10

# ######################################################################################
#   functions -> these need to go somehere else sometime, as they are helpers...

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
}
flags_init

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

usage(){

echo -e "${RED}${script_name} [OPTION]... [FILE]...${NOC}

this script sets up sourcing of:
    .bash_profile
    .bashrc
    .bash_logout
using versioned aliases, functions and the like    
    github.com/rogrwhitakr/templates/

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

${RED} PREREQUISITES / REQUIREMENTS:${NOC}
    - network connectivity

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

script_finish(){

    local ERROR_CODE="$?" 
  if [[ "${ERROR_CODE}" = 0 ]]; then
    echo -e "${GREEN}exit green, no errors${NOC}"
    echo -e "ERROR CODE: ${ERROR_CODE}"
  else  
    echo -e "${RED}exit RED${NOC}"
    echo -e "ERROR CODE: ${ERROR_CODE}"
  fi
  echo -e "${YELLOW}trap::script_finish::handler -> ${ERROR_CODE}${NOC}"
}

# DESC: the core function of the script
# NOTE: The creation of readonly variables in dependent functions (like color_init)
#       failed, moving these functions AFTER the main function seemed to solve this
#       THIS CANNOT STAND. WHY is this happening?
#       Okay, seems it was the flag stuff 
# ARGS: $@: Arguments provided to the script
# OUTS: Magic!

function main() {  

    echo -e "within main"
    script_init
    color_init
    trap script_finish EXIT INT TERM

# getting stuff

    cd "/home/admin/profile-setup-test"

declare -a files=('.alias' '.functions' '.export' '.programs')
  
for file in "${files[@]}";do
  echo -e "${GREEN}collecting raw file from github: ${file}${NOC}"
  local url="https://raw.githubusercontent.com/rogrwhitakr/northern-lights/master/conf/dotfiles/system"
  wget "${url}/${file}" -O "${file}"
done

# we do a check
echo -e "${RED}$(ls -lah)${NOC}"

# setting up .bashrc file in such a way that the files get sourced

# create .bashrc if it doesn't exist
if [[ ! -f "/home/admin/profile-setup-test/.bashrc" ]]; then
	touch "/home/admin/profile-setup-test/.bashrc"
fi


# remove old sourcing
# okay apperently sed is at its best when looking at one individual line
for file in "${files[@]}";do
  echo -e "removing definition for ${file}"
  sed --in-place "/# Source user ${file} definitions/d" "/home/admin/profile-setup-test/.bashrc"
  sed --in-place "/if [[ -f ~/${file} ]]; then/d" "/home/admin/profile-setup-test/.bashrc"
  sed --in-place "/fi # <- end source/d" "/home/admin/profile-setup-test/.bashrc"
done  


# put the new sourcing in

# DEFINITION
# # Source user ${file} definitions
# if [[ -f ~/${file} ]]; then
# 	. ~/${file}
# fi # <- end source


for file in "${files[@]}";do
    echo -e "${YELLOW}adding sourcing for ${file}${NOC}"
    echo -e "
# Source user ${file} definitions
if [[ -f ~/${file} ]]; then
	. ~/${file}
fi # <- end source" >> "/home/admin/profile-setup-test/.bashrc"
done

# echo -e "
# # Source user ${alias} definitions
# if [[ -f ~/${alias} ]]; then
# 	. ~/${alias}
# fi" >> "/home/admin/profile-setup-test/.bashrc"


# resultset
cat "/home/admin/profile-setup-test/.bashrc"

}
# Make it rain
main "$@"
