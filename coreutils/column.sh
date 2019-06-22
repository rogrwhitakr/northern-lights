#! /usr/bin/env bash

echo "column command"
echo "-----"

# create a table using a delimiter
getent passwd | column -s: -t 

echo "-----"
# can also be done on a file
column -s: -t /etc/passwd

echo "-----"
# name columns
getent passwd | column -s: -t --table-columns USERNAME,PASS,UID,GID,NAME,HOMEDIR,SHELL

echo "-----"
# can also be used to generate json files (-j)
# putorius: Using JSON output requires the –table-columns ( -N ) option and column recommends having the –table-name ( -n ) set.
getent passwd | column -s: -n system\ users -J -t --table-columns USERNAME,PASS,UID,GID,NAME,HOMEDIR,SHELL

# see https://www.putorius.net/column-command-usage-examples.html