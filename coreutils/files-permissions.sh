#! /usr/bin/env bash

file=$1

readWrite() {

	file=$1
	user=$(id -un)
	perm=$(find ${file} ! -perm 600)

	if ( [[ -z "${file}" ]] || [[ "$(id -un)" == 'root' ]] ); then
		echo "Usage: $0 <file>"
		echo "Do not execute as root. Exiting."
		exit 1
	fi

	if [ ! -z $perm ]; then

		# doing something permissions-based, i.e.
		#		owning the file
		#		setting permissions to user-read-write-only

		echo "changing permissions and ownership"
		chown $user ${file}
		chmod 600 ${file}

		# display
		ls -lah ${file}

	else
		echo "no changes"
	fi

}

readWrite ${file}

# how to read the first line of a file / command
head -n 1 "${file:-$(cat /etc/passwd)}"
