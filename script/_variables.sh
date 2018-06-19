#! /usr/bin/env bash

var=23

echo "\$var   = $var"           # $var   = 23
echo "\$\$var  = $$var"         # $$var  = 4570var
echo "\\\$\$var = \$$var"       # \$$var = $23

# Indirect reference.
# eval is said to be not good practice, as its operation can be achived using bash built-ins
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

# shell built-in arithmetic
# Addition
echo "$(( 12 + 5 ))"
# Subtraction
echo "$(( 12 -5 ))"
# Division
echo "$(( 27 / 3 ))"
#Multiplication
echo "$(( 9 * 3 ))"
# Modulo
echo "$(( 5 % 3 ))"
# Exponentiation
echo "$(( 5 ** 3 ))"

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