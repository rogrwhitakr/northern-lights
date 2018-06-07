#! /usr/bin/env bash 

${parameter:-word}

Use Default Value. If 'parameter' is unset or null, 'word' (which may be an expansion) is substituted. Otherwise, the value of 'parameter' is substituted.

${parameter:=word}

Assign Default Value. If 'parameter' is unset or null, 'word' (which may be an expansion) is assigned to 'parameter'. The value of 'parameter' is then substituted.

${parameter:+word}

Use Alternate Value. If 'parameter' is null or unset, nothing is substituted, otherwise 'word' (which may be an expansion) is substituted.

${parameter:offset:length}

Substring Expansion. Expands to up to 'length' characters of 'parameter' starting at the character specified by 'offset' (0-indexed). If ':length' is omitted, go all the way to the end. If 'offset' is negative (use parentheses!), count backward from the end of 'parameter' instead of forward from the beginning. If 'parameter' is @ or an indexed array name subscripted by @ or *, the result is 'length' positional parameters or members of the array, respectively, starting from 'offset'.

${#parameter}

The length in characters of the value of 'parameter' is substituted. If 'parameter' is an array name subscripted by @ or *, return the number of elements.

${parameter#pattern}

The 'pattern' is matched against the beginning of 'parameter'. The result is the expanded value of 'parameter' with the shortest match deleted. 
If 'parameter' is an array name subscripted by @ or *, this will be done on each element. Same for all following items.

${parameter##pattern}

As above, but the longest match is deleted.

${parameter%pattern}

The 'pattern' is matched against the end of 'parameter'. The result is the expanded value of 'parameter' with the shortest match deleted.

${parameter%%pattern}

As above, but the longest match is deleted.

${parameter/pat/string}

Results in the expanded value of 'parameter' with the first (unanchored) match of 'pat' replaced by 'string'. Assume null string when the '/string' part is absent.

${parameter//pat/string}

As above, but every match of 'pat' is replaced.

${parameter/#pat/string}

As above, but matched against the beginning. Useful for adding a common prefix with a null pattern: "${array[@]/#/prefix}".

${parameter/%pat/string}

As above, but matched against the end. Useful for adding a common suffix with a null pattern.


#fetch into array using find
src=( $(find ~/html -mindepth 1 -maxdepth 1 -type d) )

# make use of the number
echo "threre are ${#src[@]} ROOT folders"

function_bypass(){
# here wo omit the quitation marks to be able to iterate through the array...
for destination in ${dest}; do 
    for source in ${src}; do
        echo "comparing source "$source" to destination "$destination":"
#        find_in_target $source $destination

        # we compare the "filename" portion
        #   "${destination##*/}"
        #   "${source##*/}"
    
        if [[ "${source##*/}" = "${destination##*/}" ]]; then
            echo "copying source "$source" to destination "$destination":"
            
            # we copy to the parent directory

            sudo cp --recursive "$source" "${destination%/*}"
        fi
    done
done    
}

# bash has built-in String Variable Manipulation
# bash built-in
VAR='HEADERMy voice is my passwordFOOTER'
PASS="${VAR#HEADER}"
PASS="${PASS%FOOTER}"
echo $PASS

# The # means ‘match and remove the following pattern from the start of the string’
# The % means ‘match and remove the following pattern from the end of the string

# defaults.sh
FIRST_ARG="${1:-no_first_arg}"
SECOND_ARG="${2:-no_second_arg}"
THIRD_ARG="${3:-no_third_arg}"
echo ${FIRST_ARG}
echo ${SECOND_ARG}
echo ${THIRD_ARG}

# get extension with: 
"${unit_file#*.}" 

FILE=archive.tar.gz

echo "${FILE%%.*}"
echo "${FILE%.*}"
echo "${FILE#*.}"
echo "${FILE##*.}"
