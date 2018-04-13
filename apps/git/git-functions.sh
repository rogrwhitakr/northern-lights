#! /bin/sh

get_git_repo_dir() {
	
	git_dir=$(find ~/ -name .git )
	echo "$git_dir"	

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