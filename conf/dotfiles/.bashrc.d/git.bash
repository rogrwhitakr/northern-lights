#!/usr/bin/env bash

export gits='git status';

# shorthand for the northern-lights repository
export pull_nl="git pull northern-lights --rebase";
export push_nl='git push northern-lights master';

# shorthand for the ambient-lights repository
export pull_nl="git pull origin master --rebase";
export push_nl='git push origin master';

# shorthand for the docker repository
export pull_nl="git pull cube-lights --rebase";
export push_nl='git push cube-lights master';

check_repository() {
	local repository='$1'
	if [[ -z "$@" ]]; then
		echo -e "no input given to append to ${repository}"
		break
	fi