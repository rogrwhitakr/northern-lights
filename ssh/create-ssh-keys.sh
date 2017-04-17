#! /bin/sh

key_name=$1

# function to create rsa keys for ssh

function createKey {

if [ -z "$key_name" ];then                           # Is parameter #1 zero length?
   echo "Usage: $0 ssh-key-name";
   echo "No parameter passed. Exiting."
   exit 1
fi

	user=$(id -un)

	if [ ! -d ~/.ssh ]; then
		mkdir ~/.ssh/
		sudo chown -c $user ~/.ssh/ 
		sudo chmod 700 ~/.ssh/
	fi

	ssh-keygen -t rsa -b 4096 -f ~/.ssh/$1

	sudo cat ~/.ssh/$key_name
	sudo cat ~/.ssh/$key_name.pub

	exit 0
}

createKey $key_name