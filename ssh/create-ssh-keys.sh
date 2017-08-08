#! /bin/sh

# function to create rsa keys for ssh
function createKey {

	local RED='\033[0;31m'
	local YELLOW='\e[33m'
	local NOC='\033[0m'

	# check prerequisites
	if [ -z "$key_name" ];then
	   echo -e "Usage:\n$0 [ssh-key-name]";
	   echo -e "No parameter passed."
	   exit 1
	fi

	# make sure the script is not run as root
	if [ "$(id -u)" == "0" ]; then
	   echo "This script must not be run as root" 1>&2
	   exit 1
	fi

	# get login user
	user=$(id -un)

	# create dir if not exist
	if [ ! -d ~/.ssh ]; then
		mkdir ~/.ssh/
		chown -c $user ~/.ssh/ 
		chgrp $user ~/.ssh/
		chmod 700 ~/.ssh/
	fi

	# generate a ssh key
	# maybe we can do some parameterizing later...
	ssh-keygen -t rsa -b 4096 -f ~/.ssh/$1

	# show what has been created
	echo -e "${RED}the contents of public key ${key_name}.pub${NOC}"
	cat ~/.ssh/$key_name.pub
	exit 0
}

#variable assigned
key_name=$1

# execute function
createKey $key_name