#!/bin/bash

### functions

function line() {
	echo [------------------------------------------]
}

function start() {
	echo $1
}

function stop() {
	echo $2
}

###	variables

var1=GAY
var2=LORD

###	execution

rm -f ./test.txt

line
for i in $( ls ); do
	echo item: $i
done

line
start $var1 $var2
stop $var1 $var2
line

ls -l
ls -l | awk '{print $1}'

line
find . ! -perm -600
line

if [[ "ls -l | awk '{print $1}'" != '-rw-------.' ]]; then
	echo nei
	touch ./test.txt
	chmod 600 ./test.txt
else
	echo jei
fi	


ls -lah

OC='\033[0m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'

SQL="select claim_id from claim;"

SQL=$(sed -e "s/claim/setting/g" <<< $SQL)

echo -e "${RED}SQL${NOC}"

# loopinhg through given variables

VARIABLES=( one two three four )
for VARIABLE in $( VARIABLES[@] ); do
	echo -e "$VARIABLE\n"
	sleep 2
done

# using seq
 
range=$(( RANDOM % 20 ))
for i in $( seq 1 $range ); do
	echo -e "$i"
	sleep 0.2
done

# The seq method is the simplest, but Bash has built-in arithmetic evaluation.

END=5
for ((i=1;i<=END;i++)); do
	echo $i
done