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

# DESC: verify unit file syntax 
# ARGS: unit
# OUTS: none

verify_unit_file_syntax(){
  unit="$1"

  if [[ -z "$1" ]]; then
    echo -e "no unit provided"
    return 112 # okay dont know if this works
  else
    # this only works if it already is a service?
    systemd-analyze verify "${unit}"
  fi

}

# DESC: check if file has a service extension
# ARGS: unit-file name
# OUTS: none

verify_unit_file_extension(){
  unit_file="$1"

  if [[ -z "$1" ]]; then
    echo -e "no unit file provided"
    ERROR_CODE=112 # okay dont know if this works
  fi

  # yes, there are more unit file types, but 
  # i do not think i create a lot of targets and whatnot. 

  if [[ "${unit_file#*.}" = "service" ]]; then 
    return 0
  elif [[ "${unit_file#*.}" = "socket" ]]; then 
    return 0
  elif [[ "${unit_file#*.}" = "timer" ]]; then 
    return 0
  else 
    return 113
  fi
}

# DESC: create a one-shot unit file for executing bash script
# NOTE: executed as user (non-root)
# ARGS: $@: Arguments provided to the script
# OUTS: unitfile creation

create_unit_file(){

  local unit_file="$1"
  local user="$2"
  local group="$3"
  touch "${unit_file}"
  tee >> /dev/null "${unit_file}" <<EOF
Description=BASH Profile Generation and Update
After=network.target
Requires=network.target

[Service]
Type=one-shot
User=${user}
Group=${group}
ExecStart=$(which bash) /home/${user}/.dotfiles/profile-generator.sh

[Install]
WantedBy=multi-user.target
EOF
}

# DESC: Generic script initialisation
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: $exec_path: The current working directory when the script was run
#       $script_path: The full path to the script
#       $script_dir: The directory path of the script
#       $script_name: The file name of the script

function unit_file_init() {
    readonly unit_file="${BASH_SOURCE[1]}"
    readonly user="$(whoami)"
    readonly group="$(id --group --name ${user})"
    readonly executable="$(find /home/${user} -name profile-generator.sh -executable )"
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
  create_unit_file setup-profile.service admin admin
  check_unit_file_extension test.service
  exit 0
# create .bashrc if it doesn't exist
# TODO correct path

}
# Make it rain
main "$@"
