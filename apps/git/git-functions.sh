#! /usr/bin/env bash

git_finish() {

	# DESC: traps the main function `get_git_repo_dir`
	# ARGS: exitcode
	# OUTS: exit of script

# we exit on any error
set -e

	local ERROR_CODE="$?"
	if [[ "${ERROR_CODE}" == 0 ]]; then
		echo "exit green, no errors"
		exit 0
#	elif [[ "${ERROR_CODE}" == 20 ]]; then
#		print RED "name check: ${name} contains disallowed characters!"
#		print "\tallowed characters: [a-zA-Z0-9_-.]"
#		print LINE
#	elif [[ "${ERROR_CODE}" == 5 ]]; then
#		print YELLOW "no script created, exiting"
#		print LINE
#	elif [[ "${ERROR_CODE}" == 6 ]]; then
#		print YELLOW "Invalid name choice, exiting"
#		print LINE
#	elif [[ "${ERROR_CODE}" != 0 ]]; then
#		print GREEN "all OK"
	else
		echo "somesin is up, errorcode = '${ERROR_CODE}'"
		exit "${ERROR_CODE}"
	fi
}

get_git_repo_dir() {

	# DESC: sets the remote 
	# ARGS: path to repository
	# OUTS: gitconfig?

	# trapping any errors and exit function
   trap git_finish INT TERM EXIT

local repository="${1}"

# first we validate that we are in a directory containing a git repository 
cd "${repository}"
cd "${repository:-~}"
git status

# show if the name provided matches a remote
# at the moment we assume the path and repository name are the same!
git remote show "${repository}"

   # remove the trap at the end
   echo "we at the end"
 #  trap - INT TERM EXIT
}

# call the function correctly 
get_git_repo_dir "/home/benno/northern-lights"
get_git_repo_dir "/home/benno/cube-lights"

# call it falsely
get_git_repo_dir "/home/benno/gna"

exit 0
# select yo editor
git config --global core.editor nano


# show remote's info
git remote show <repository-name>

# name and set-url the remote; then and set the remote the master
git remote add <repository-name> https://github.com/<github-user>/<repository-name>

git remote set-url <repository-name> git@github.com:<github-user>/<repository-name>.git

# allow track so that you can push changes
git branch --set-upstream-to <repository-name>/master

	# this function is called:
	# - after cloning the repository from repo  master (github in my case)
	git_dir=$(find ~/ -name .git )
	echo "$git_dir"	
trap 
trap 
   # remove the trap at the end
   trap - INT TERM EXIT
}

check_git_status() {
	status=$(git status | grep 'nothing to commit, working tree clean')

	if [[ -n $status ]]; then
		return 0
	else	
		return 1
	fi
}

get_git_repo_dir
cd get_git_repo_dir