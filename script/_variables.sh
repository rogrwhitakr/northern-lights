#! /bin/usr/env bash

var=23

echo "\$var   = $var"           # $var   = 23
echo "\$\$var  = $$var"         # $$var  = 4570var
echo "\\\$\$var = \$$var"       # \$$var = $23


a=letter_of_alphabet   # Variable "a" holds the name of another variable.
letter_of_alphabet=z

echo "a = $a"

# Indirect reference.
eval a=\$$a

# declare built-in
# with the "declare" statement, we can limit the value assignment to variables

declare -i number=12
#Option	Meaning
#-a	Variable is an array.
#-f	Use function names only.
#-i	The variable is to be treated as an integer; arithmetic evaluation is performed when the variable is assigned a value (see Section 3.4.6).
#-p	Display the attributes and values of each variable. When -p is used, additional options are ignored.
#-r	Make variables read-only. These variables cannot then be assigned values by subsequent assignment statements, nor can they be unset.
#-t	Give each variable the trace attribute.
#-x	Mark each variable for export to subsequent commands via the environment.

# using shell built-in RANDOM

echo -e $RANDOM
echo -e "$(( ( RANDOM % 10 )  + 1 ))"
echo -e "$(( RANDOM % 100 ))"
echo -e "$(( RANDOM % 20 ))"

exit 0

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