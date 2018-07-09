#! /usr/bin/env sh

# DESC: Generic logging initialisation
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: logging to /var/log/>script_name>

if [[ -n "${script_name}"]]; then
log="/var/log/$(script_name)"

echo $log
# create if it doesnt exit
if [[ ! -f "$log" ]]; then
    touch "$log"
fi

# own if it is not owned

# make usable by allowing reading / writing to the file
if [[ ! -r ! -w "$log" ]]; then
    chmod 
    fi