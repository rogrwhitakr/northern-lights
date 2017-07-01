#! /bin/sh

find_git_repository() {
	# assuming it resides in ~
	# get current dir ?, neccesary ???
	
	echo 'first command'	
	find ~ -type d -name .git 
	echo 'next command'	
	cd $(find ~ -type d -name .git) 

}

check_git_status() {
	status=$(git status | grep 'nothing to commit, working tree clean')

	if [[ -n $status ]]; then
		return 0
	else	
		return 1
	fi
}

find_git_repository
check_git_status