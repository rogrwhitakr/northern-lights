#! /usr/bin/env bash

get_git_repo_dir() {

	# DESC: sets the remote  analyses the input regarding time range
	# ARGS: path to repository
	# OUTS: gitconfig?

   trap "echo 'exit prematurely'" INT TERM EXIT

local repository="${1}"
git status

}

# call the function
get_git_repo_dir

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