#! /bin/sh

file=$1


function readWrite {

if [ -z "$file" ];then                           # Is parameter #1 zero length?
   echo "Usage: $0 file";
   echo "No file passed. Exiting."
   exit 1
fi
if [ $(id -un) == 'root' ]; then
	echo "not to be used as root."
	echo "Exiting"
fi	
	user=$(id -un)
	perm=$(find $file ! -perm 600)

	if [ ! -z $perm ]; then
		sudo chown $user $file
		sudo chmod 600 $file
	fi
}

readWrite $file