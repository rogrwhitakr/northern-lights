#! /usr/bin/env bash

# example from stack overflow,
# needs some explainers
# http://wiki.bash-hackers.org/howto/getopts_tutorial
# https://sookocheff.com/post/bash/parsing-bash-script-arguments-with-shopts/

usage() { echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; exit 1; }

while getopts ":s:p:mf:" opt; do
    case "${opt}" in
        s)
            s=${OPTARG}
            ((s == 45 || s == 90)) || usage
            echo "s = ${s}"
            ;;
        p)
            p=${OPTARG}
            echo "p = ${p}"
            ;;
        m)
            m=${OPTARG}
            echo "m = ${m}"
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
            echo "in *)"
            ;;
    esac
done

# The variable OPTIND holds the number of options parsed by the last call to getopts. 
# It is common practice to call the shift command at the end of your processing loop
# to remove options that have already been handled from $@.
shift $((OPTIND -1))

check(){
if [ -z "${s}" ] || [ -z "${p}" ] || [ -z "${m}" ]; then
    usage
fi
}

echo "s = ${s}"
echo "p = ${p}"
echo "m = ${m}"