#! /usr/bin/env bash

# example from stack overflow,
# needs some explainers

usage() { echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; exit 1; }

while getopts ":s:p:mf:" o; do
    case "${o}" in
        s)
            s=${OPTARG}
            ((s == 45 || s == 90)) || usage
            ;;
        p)
            p=${OPTARG}
            ;;
        m)
            m=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${s}" ] || [ -z "${p}" ] || [ -z "${mf" ]; then
    usage
fi

echo "s = ${s}"
echo "p = ${p}"
echo "m = ${m}"