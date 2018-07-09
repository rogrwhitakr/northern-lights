#! /usr/bin/env bash
# source me !!

# DESC: print usage information
# ARGS: None
# OUTS: None
# NOTE: must be customised to script to provide sensible info, duh.

usage(){

echo -e "./${RED}${script_name} [OPTION]... [FILE]...${NOC}

script template: what does it do? what is its function that is beyond the
comprehension of the filename?

Script Version: ${version}

${RED} OPTIONS:${NOC}
    -n  Name
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
