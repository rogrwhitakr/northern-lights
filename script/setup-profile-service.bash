#! /usr/bin/env bash

# ######################################################################################
# BASH PROFILE SETUP
#   HISTORY:
#
#   2018-06-23 - v0.0.1  -  First Creation 
#   2018-06-23 - v0.1.1  -  add one-shot service for pulling files  
#
# ######################################################################################
# VARIABLES
#   VERSION
version="0.1.1"

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
# OUTS: Read-only variables with color codes

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
    on startup, these are pulled from github using systemd

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

# DESC: check if file has a service extension
# ARGS: unit-file name
# OUTS: none

check_unit_file_extension(){
  unit_file="$1"

  if [[ -z "$1" ]]; then
    echo -e "no unit file provided"
    ERROR_CODE=112 # okay dont know if this works
  fi

  if [[ "${unit_file#*.}" = "service" ]]; then 
    return 0
  else 
    return 113
  fi
}
# DESC: create a one-shot unit file for pulling files
# NOTE: executed as user (non-root)
# ARGS: $@: Arguments provided to the script
# OUTS: unitfile creation and activation

create_unit_file(){
  echo -e "within create_unit_file"
  local unitfile = "$(touch "profile-setup.service")"
  tee >> /dev/null "${unit_file}" << EOF

#######################################
#
# creating and populating $demofile
#
#######################################

WAY 1)

RED='\033[0;31m'
YELLOW='\e[33m'
NOC='\033[0m'
BLUE='\e[34m'

EOF
}

create_unit_file(){
  echo -e "within create_unit_file"
  local unitfile = "$(touch "profile-setup.service")"
  tee >> /dev/null "${unit_file}" << EOF

#######################################
#
# creating and populating $demofile
#
#######################################

WAY 1)

RED='\033[0;31m'
YELLOW='\e[33m'
NOC='\033[0m'
BLUE='\e[34m'

EOF
}

# DESC: the core function of the script
# NOTE: main
# ARGS: $@: Arguments provided to the script
# OUTS: Magic!

function main() {  

  cd ~/profile-setup-test/
  script_init
  color_init
  usage
  trap script_finish EXIT INT TERM
  create_unit_file
  check_unit_file_extension test.service
  exit 0
# create .bashrc if it doesn't exist
# TODO correct path

declare -a sources=('.bashrc' '.bash_profile' '.bash_logout')

for source in "${sources[@]}";do
  if [[ ! -f ~/"${source}" ]]; then
    echo -e "${GREEN}creating ${source}${NOC}"
    touch ~/"${source}"
  fi
done

# setting up directory 
# -> parentheses here DO NOT WORK
# they hinder expansion of ~
if [[ ! -d ~/.dotfiles ]]; then
    echo -e "${GREEN}Creating directory .dotfiles${NOC}"
	mkdir ~/.dotfiles && cd ~/.dotfiles
else 
    echo -e "${GREEN}Switching to directory .dotfiles${NOC}"
	cd ~/.dotfiles
fi

# getting stuff

    cd "/home/admin/profile-setup-test"

declare -a files=('.alias' '.functions' '.export' '.programs')
  
for file in "${files[@]}";do
  echo -e "${GREEN}collecting raw file from github: ${file}. Saving to $(pwd)${NOC}"
  local url="https://raw.githubusercontent.com/rogrwhitakr/northern-lights/master/conf/dotfiles/system"
  wget "${url}/${file}" -O "${file}"
done

# setting up .bashrc file in such a way that the files get sourced

# remove old sourcing
# okay apparently sed is at its best when looking at one individual line
# potentially anything not named .* will suffer in the second line command

for file in "${files[@]}";do
  echo -e "removing definition for ${file}"
  sed --in-place "/# Source user ${file} definitions/d" "/home/admin/profile-setup-test/.bashrc"
  sed --in-place "/${file}/d" "/home/admin/profile-setup-test/.bashrc"
  sed --in-place "/fi # <- end source/d" "/home/admin/profile-setup-test/.bashrc"
done  


# put the new sourcing in

# DEFINITION
# # Source user ${file} definitions
# if [[ -f ~/.dotfiles/${file} ]]; then
# 	. ~/.dotfiles/${file}
# fi # <- end sources


for file in "${files[@]}";do
    echo -e "${YELLOW}adding sourcing for ${file}${NOC}"
    echo -e "# Source user ${file} definitions
if [[ -f ~/.dotfiles/${file} ]]; then
	. ~/.dotfiles/${file}
fi # <- end source" >> "/home/admin/profile-setup-test/.bashrc"
done

}
# Make it rain
main "$@"
