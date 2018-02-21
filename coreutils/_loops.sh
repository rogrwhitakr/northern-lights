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

ls -l | awk '{print $1}'

# looping through given variables
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

# pushd / popd within a loop
for d1 in $(ls -d *)
do
  pushd "$d1"
  for d2 in $(ls  -d */)
  do
    pushd "$d2"
    # Do something
	echo "we are in $d2"
    popd
  done
  popd
done