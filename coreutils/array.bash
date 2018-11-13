#! /usr/bin/env bash

# Arrays are friends....
friends=( "Marcus The Rich" "JJ The Short" "Timid Thomas" "Michelangelo The Mobster" )
for friend in "${friends[@]}";do
    echo "$friend is my friend";
done

# also possible:
# get length of an array
echo ${#friends[@]}
length=${#friends[@]}
 
# use for loop to read all names
for (( i=0; i<${length}; i++ ));
do
  echo ${friends[$i]}
done

# read all files into an array WITHOUT NEWLINE
declare -a files
readarray -t files < <(find "${source_dir}" -mindepth 1 -maxdepth 1 -type f -print)

readarray myarray < file_pathname # Include newline.
readarray -t myarray < file_pathname # Exclude newline.

# read into array
readarray arr < <( echo a; echo b; echo c )
echo "${#arr[@]}"
echo "${arr[1]}"

# users and groups
# seems annoyingly hackish
user=( $( getent passwd | cut -d: -f 1 ) )
echo "${#user[@]}"
echo "${user[1]}"
echo "${user[2]}"
echo "${user[3]}"

# Reversing an array.
# It’s possible to reverse an array in bash without using any external programs or looping by making use of extdebug.
# When extdebug is enabled the array BASH_ARGV is made available and it contains the function’s arguments in reverse order.

reverse_array() {
    # Reverse an array.
    # Usage: reverse_array "array"

    shopt -s extdebug
    f(){ printf "%s " "${BASH_ARGV[@]}"; }; f "$@"
    shopt -u extdebug

    printf "\\n"
}

# ADD FILES TO AN ARRAY. THE RIGHT WAY
files=()
for file in *.mp4; do
	print RED "${file}"
    [[ -e ${file} ]] && files+=("${file}") || echo "WHAT"
done
echo ${files[@]}
echo ${#files[@]}
