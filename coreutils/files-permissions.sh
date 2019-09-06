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

# quit after first line
sed 1q "${file:-$(cat /etc/passwd)}"
# nly print first line, but read everything
sed -n 1p "${file:-$(cat /etc/passwd)}"
awk 'FNR == 1' "${file:-$(cat /etc/passwd)}"


# owning a directory tree to current user, may reqire sudo (if root owned)
chown "$(id -un):$(id -un)" . -R