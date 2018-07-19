#! /usr/bin/env sh

parameter_set(){
    echo "$1"
    echo "$1" "$2"
    echo "$*"

    # Expands to all the words of all the positional parameters. Double quoted, 
    # it expands to a single string containing them all, separated by the first character 
    # of the IFS variable 

    for i in "$*"; do
        echo "$i"
    done

    # Expands to all the words of all the positional parameters. 
    # Double quoted, it expands to a list of them all as individual words.
    for j in "$@"; do
        echo "$j"
    done
    echo "$@"
    echo "$?"
    echo "$$"
    echo "$!"
    echo "$_"
}

parameter_set "eins" "zwei" "three" "yo momma" "which column"