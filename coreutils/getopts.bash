#! /usr/bin/env bash

# example from stack overflow,
# needs some explainers
# http://wiki.bash-hackers.org/howto/getopts_tutorial
# https://sookocheff.com/post/bash/parsing-bash-script-arguments-with-shopts/

usage() { echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; exit 1; }

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