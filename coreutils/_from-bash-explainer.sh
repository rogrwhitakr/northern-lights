# says: always use
#! /usr/bin/env sh

# use parameter expansions instead of sed or cut to manipulate simple strings in Bash. 
# remove the extension from a filename

for file in $(ls); do
    echo ${file%.*} 
done

# Use $(...) instead of `which <programme>
`
# Use built-in math instead of expr to do simple calculations, especially when just incrementing a variable.
# If the script you're reading uses x=`expr $x + 1` then it's not something you want to mimic.

# "Word Splitting is the demon inside Bash that is out to get unsuspecting newcomers"
# means DO NOT EVER FORGET "QUOTES" AROUND "VARIABLES"?
# "EVERYTHING MUST BE QUOTED THAT I DONT WANT TO BE PASSED AS INDIVIDUAL ARGUMENTS?"

# Arrays are friends....
friends=( "Marcus The Rich" "JJ The Short" "Timid Thomas" "Michelangelo The Mobster" )
for friend in "${friends[@]}";do
    echo "$friend is my friend";
done

