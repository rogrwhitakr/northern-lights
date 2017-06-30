#! /bin/sh

#find_git_repository() {
	# TODO
#}

check_git_status() {
	status=$(git status | grep 'nothing to commit, working tree clean')
	echo $status
	sleep 2

	if [ -n $status ]; then
		echo 'nothing to commit'
	else	
		git status
	fi
}

check_git_status