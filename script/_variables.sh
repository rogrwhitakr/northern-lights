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

t=table_cell_3
table_cell_3=24
echo "\"table_cell_3\" = $table_cell_3"            # "table_cell_3" = 24
echo -n "dereferenced \"t\" = "; eval echo \$$t    # dereferenced "t" = 24
# In this simple case, the following also works (why?).
#         eval t=\$$t; echo "\"t\" = $t"

t=table_cell_3
NEW_VAL=387
table_cell_3=$NEW_VAL
echo "Changing value of \"table_cell_3\" to $NEW_VAL."
echo "\"table_cell_3\" now $table_cell_3"
echo -n "dereferenced \"t\" now "; eval echo \$$t
# "eval" takes the two arguments "echo" and "\$$t" (set equal to $table_cell_3)

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