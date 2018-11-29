#!/usr/bin/env bash

set -x

# this is crude, but works: two down, and then...

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__dir="$(cd "$(dirname "${__dir}")" && pwd)"
source "${__dir}/script/helpers/init.bash"

set +x
#ping -i 2 google.de | cut -d= -f4 
#ping -i 2 google.de | cut -d= -f1

sudo cut -dT -f1 /var/log/dnf.log
sudo cut -dT -f1 /var/log/dnf.log | grep -E '[0-9]{4}\-[0-9]{2}\-[0-9]{2}'

# get the dates (does not work yet)
# journalctl --list-boots | cut --fields=4,5,7,8

echo -e "$(find . -mindepth 1 -maxdepth 1 -type f | wc | cut -f1) files"
# get some files from current directory, word-count that
ls | wc \
    cut --fields=1

print LINE
# a tutorial
# we create a demo file
__cutfile="$(dirname ${BASH_SOURCE[0]})/cut-me.txt"
touch "${__cutfile}" 

echo "
cat command for file oriented operations:done:this:thus
cp command for copy files or directories:done:that:thurr
ls command to list out files and directories with its attributes:doing:now:marshall" > "${__cutfile}"

# get the second column
cut -c2 "${__cutfile}"

# get a range
cut -c1-3 "${__cutfile}"

# Select Column of Characters using either Start or End Position
cut -c3- "${__cutfile}"
cut -c-8 "${__cutfile}"
cut -c1-4,18- "${__cutfile}"

# cut based on delimiter, with new delimiter:
cut -d':' -f1,2 --output-delimiter='#' "${__cutfile}"

# possible to filter and display only the lines that
# contains the specified delimiter using -s option.
cut -d':' -s -f2,3 --output-delimiter=$'\n' "${__cutfile}"

cut -d' ' -s -f2-4 "${__cutfile}"

# remove file again...
rm "${__cutfile}" 