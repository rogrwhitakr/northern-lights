#! /usr/bin/env bash

source "/var/home/benno/northern-lights/script/helpers/printer.bash"

print LINE

git_finish() {

	# DESC: traps the main function `get_git_repo_dir`
	# ARGS: exitcode
	# OUTS: exit of script

	# we exit on any error
#	set -e

	local ERROR_CODE="$?"
	if [[ "${ERROR_CODE}" == 0 ]]; then
		echo "exit green, no errors"
		exit 0
	elif [[ "${ERROR_CODE}" == 1 ]]; then
		echo "directory ${repository} does not exist, exiting!"
		exit 1
	elif [[ "${ERROR_CODE}" == 128 ]]; then
		echo "No Git Repository in directory ${repository}!"
		exit 128
	else
		echo "somesin is up, errorcode = '${ERROR_CODE}'"
		exit "${ERROR_CODE}"
	fi
}

get_git_repo_dir() {

	# DESC: sets the remote 
	# ARGS: path to repository
	# OUTS: gitconfig?

	local repository="${1}"

	# we trap errors and such
	trap git_finish ERR

	# first we validate that we are in a directory containing a git repository 
	cd "${repository}"
	git status

	# show if the name provided matches a remote
	# at the moment we assume the path and repository name are the same!
	git remote show "${repository}"

	exit 0
	# this should require some before check i think

	# select nano as editor
	git config --global core.editor nano

	# name and set-url the remote; then and set the remote the master
	git remote add "${repository}" https://github.com/<github-user>/"${repository}"

	git remote set-url "${repository}" git@github.com:<github-user>/"${repository}".git

	# allow track so that you can push changes
	git branch --set-upstream-to "${repository}"/master
}

print LINE

# call the function correctly 
get_git_repo_dir "/home/benno/cube-lights"
print LINE

# call it falsely
get_git_repo_dir "/home/benno/gna"
print LINE


# call it on a valid pah without repository in it
get_git_repo_dir "/home/benno/no-repo"
print LINE

# trap error
trap "echo false_error" ERR
false   