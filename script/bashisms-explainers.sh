
# Bypassing shell aliases
# alias ls='ls -Z'
ls
# only ls command
\ls

#execute on remote box
ssh srv 'bash -s' < ~/<path>/setup-profile-on-new-box.bash


# always use
#! /usr/bin/env sh

# use built-ins as much as possible
printf '%d\t' {1..10}
printf '\n'
# Use $(...) instead of `which <programme>`

# Use built-in math instead of expr to do simple calculations, especially when just incrementing a variable.
# If the script you're reading uses x=`expr $x + 1` then it's not something you want to mimic.

# "Word Splitting is the demon inside Bash that is out to get unsuspecting newcomers"
# means DO NOT EVER FORGET "QUOTES" AROUND "VARIABLES"?
# "EVERYTHING MUST BE QUOTED THAT I DONT WANT TO BE PASSED AS INDIVIDUAL ARGUMENTS?"

# ALWAYS use double [[ ]] brackets, they are saver
# -> [ is the test command

simple_var="rubarb"
less_simple_var="123Gak48$"

[[ "$simple_var" = "rubarb" ]] && echo True || echo False

# pattern matching (NO QUOTES THIS TIME!!)
[[ $simple_var = ru* ]] && echo True || echo False
[[ $less_simple_var =~ \d\d\d.+ ]] && echo True || echo False