#!/bin/bash

# http://www.davidpashley.com/articles/writing-robust-shell-scripts/

# Signal Description
# get all by executing 
#  kill -l
# INT    Interrupt – This signal is sent when someone kills the script by pressing ctrl-c.
# TERM   Terminate – this signal is sent when someone sends the TERM signal using the kill command.
# EXIT   Exit – this is a pseudo-signal and is triggered when your script exits, either through reaching the end of the script,
#        an exit command or by a command failing when usingset -e.

section(){
	range=$(( RANDOM % 30 ))
	for i in $( seq 1 $range ); do
		echo -e "$i out of $range"
		sleep 0.5
	done
}

lockfile=$0.log

if [ ! -e $lockfile ]; then

   # trap the command rm, exit on a sent INTerupt and TERMination
   trap "rm -f $lockfile; exit" INT TERM EXIT
   touch $lockfile

   # does the lockfile exist?
   ls -lah "$lockfile"
   # critical-section
   section

   # we remove the lock file and the trap
   rm $lockfile

   # remove the trap at the end
   trap - INT TERM EXIT

else
   echo "critical-section is already running"
fi

# trap an error
trap "echo false_error" ERR
false      