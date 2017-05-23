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
