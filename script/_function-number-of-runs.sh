#!/bin/bash

scriptname="${0}"
runs=0

if [[ $runs -eq 0 ]]; then
  echo "I have never run before."
elif [[ $runs -eq 1 ]]; then
  echo "I have ran $runs time before."
elif [[ $runs -gt 1 ]]; then
  echo "I have ran $runs times before."
fi

# Set variable for sed
current_run=$runs
# Increment for each run
((runs++))
# Sed to change the runs variable inside the script
sed -i "s/^runs=$current_run/runs=$runs/" $scriptname