#! /usr/bin/env bash

# example from stack overflow,
# needs some explainers
# http://wiki.bash-hackers.org/howto/getopts_tutorial
# https://sookocheff.com/post/bash/parsing-bash-script-arguments-with-shopts/

usage() { echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; exit 1; }

while getopts ":s:p:mf:" o; do
    case "${o}" in
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
            echo "Invalid option: -$OPTARG" >&2
            ;;    
        *)
            echo "in *)"
            ;;
    esac
done
shift $((OPTIND-1))

check(){
if [ -z "${s}" ] || [ -z "${p}" ] || [ -z "${m}" ]; then
    usage
fi
}

echo "s = ${s}"
echo "p = ${p}"
echo "m = ${m}"