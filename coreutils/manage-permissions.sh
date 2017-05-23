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

###	execution

clear
filename=$(`basename "$0"`)

echo $filename

touch ./test.txt
sudo chmod 600 ./test.txt

line
find ! -perm -600
line
ls -lah
line
rm -f ./test.txt
