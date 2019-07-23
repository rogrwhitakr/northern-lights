#! /usr/bin/env bash

# add the existing user "admin" to the existing group "ldap" (G!)
sudo usermod -aG ldap admin

# get the groups available for current user
getent group | grep ":$(id -un)"

##########################################################

file=$1

readWrite() {

	file=$1

	if [ -z "$file" ]; then # Is parameter #1 zero length?
		echo "Usage: $0 file"
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

# use install for proper file permissions for example
install -g 0 -o 0 -m 0644 <subject>.1 /usr/local/man/man8/

install create-database.sql \ 
    --target-directory /var/lib/pgsql/scripts \
    --owner=postgres \
    --group=postgres \
    --compare \
    --mode=640