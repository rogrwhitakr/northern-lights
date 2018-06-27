#! /usr/bin/env bash
# source me !!

# current flags available

#    -u  Username for script
#    -p  User password
#    -f  force, skip all user interaction.  Implied 'Yes' to all actions.
#    -q  Quiet (no output)
#    -l  Print log to file
#    -s  Exit script with null variables.  i.e 'set -o nounset'
#    -d  run script in debug-mode (set -x)
#    -h  Display help, version and exit

usage(){

echo -e "${RED}${script_name} [OPTION]... [FILE]...${NOC}

Script Version: ${version}

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
    -h  Display help, version and exit

${RED} PREREQUISITES / REQUIREMENTS:${NOC}
    - network connectivity

${RED} EXAMPLES:${NOC}
    - Create a timer 
        ${script_name} borg-backup.timer
    - Create a Service
        ${script_name} virtual-machines.service
"
}

while getopts ":as:p:u:t:" opt; do
    case "${opt}" in
        s)
            s=${OPTARG}
            ((s == 45 || s == 90)) || usage
            echo "s = ${s}"
            ;;
        p)
            echo "-p was triggered, Parameter: $OPTARG" >&2
            ;;
        u)
        
        # both methods (u and t) work. 
        # one is a little wordier

            (( "${OPTARG#*.}" == "service" || "${OPTARG#*.}" == "timer" )) || \
                usage
            echo "$OPTARG"
            ;;
        t)
            if ([[ "${OPTARG#*.}" = "service" ]] || \
                [[ "${OPTARG#*.}" == "timer" ]]) || \; 
            then
                echo "$OPTARG"
                echo "nah $OPTARG ${OPTARG#*.}"
            else
                usage
            fi    
            ;;
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
            echo -e "in *)...\nThis happens, if a pass a flag that is defined, yet no case..in is available for it"
            ;;
    esac
done

# The variable OPTIND holds the number of options parsed by the last call to getopts. 
# It is common practice to call the shift command at the end of your processing loop
# to remove options that have already been handled from $@.
shift $((OPTIND -1))

# a null check, why?
# they all seem to be doin it though....
check(){
if [ -z "${s}" ] || [ -z "${p}" ] || [ -z "${m}" ]; then
    usage
fi
}