#! /usr/bin/env bash

# okay, couple of things:
# works, but on screen formatting could be better / more uniform / needs a guideline
# TODO:
# - add the getopts thing
# - see if the color thing can be improved (maybe with the existing functions, those are not that bad)
# - learn python already!

display_help(){

local RED='\e[1;31m'  
local YELLOW='\e[33m'
local NOC='\033[0m'
local BLUE='\e[34m'

if ([[ "$1" = "-h" ]] || [[ "$1" = "--help" ]] || [[ -z "$1" ]]); then
    echo -e "${RED}USAGE:$0${NOC}"
    echo -e "\tcopies passed unit file to proper folder"
    echo -e "\tchmod 622 for this file"
    echo -e "\tusing somesin somesin"
    echo -e "${RED}PREREQUISITES${NOC}"
    echo -e "\tfile is located within home directory"
    echo -e "\tfile is one of *.service, (*.timer)"
    exit 0

elif ([[ "$1" = "-p" ]] || [[ "$1" = "--pid" ]]); then
    echo -e "$BASHPID"
fi
}
display_help $1

###############################################
# check if file has a service extension
###############################################
unit_file=$1

if [[ ! "${unit_file#*.}" = "service" ]]; then 
    echo -e "\nERROR:\n\tthe passed variable has no \"*.service\" extension!\n"
    display_help
fi

###############################################
# check if file is located within $HOME
# get the full path
# what to do if there is more then one?
###############################################

unit_file=$(find $HOME -name "${unit_file}")

###############################################
# if the unit_file variable is empty,
# we stop here
# else, we copy it to the directory
###############################################

if [[ -n "${unit_file}" ]]; then
    echo -e "Found unit file for \n\t${unit_file} at\n\t${unit_file}" 
    read -rp $'Continue with this unit file? (Y/n) : ' -ei $'n' continue_key
    
    if [[ "${continue_key}" = "Y" ]]; then
        echo -e "\texecuting..."
        sudo cp -i "${unit_file}" /etc/systemd/system/
        sudo chmod 622 /etc/systemd/system/"${unit_file##*/}"
        echo -e "\tunit file ${unit_file##*/} copied"
        sudo ls -lah /etc/systemd/system/"${unit_file##*/}"
    
    else
        echo -e "user choice: ${continue_key}\nExiting..."
        exit 0
    fi
else
    echo -e "ERROR:\nno unit file with the name $1 found in $HOME!" 
fi    

###############################################
# we could, of course do a lot of 
# checking of the file is indeed a unit file
# todo: HOW?
###############################################

# - add a enabler / starter
add_to_systemd(){
    sudo systemctl enable "${unit_file##*/}" || systemctl status "${unit_file##*/}" 
    sudo systemctl start "${unit_file##*/}" || systemctl status "${unit_file##*/}"
    sudo systemctl daemon-reload
}
add_to_systemd

exit 0        