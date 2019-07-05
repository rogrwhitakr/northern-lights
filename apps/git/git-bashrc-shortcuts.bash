gitfinish() {

	# DESC: it seems it is not possible to use trap locally, i.e. limited to a specific function
	#       As these functions are sourced by bashrc, whenever I get a return error on ANY command,
	#		the traps are called. maybe adding to function limits this behaviour???
	# ARGS: directory
	# OUTS: return

	trap "echo 'directory is not a git repository, exiting' && cd ${current} && return 1" ERR

	echo "illegal"
}
# todo extract func trion for path setting
set_git_path() {

	# DESC: set repository directory
	#       and exits on wrong path
	# ARGS: repository directory
	# OUTS: return code

	# vars
	local repository="$1"
	local current="$(/usr/bin/pwd)"

	# we trap errors and such
	#	trap "echo 'directory is not a git repository, exiting' && cd ${current} && return 1" ERR

	# we switch to repository directory, if not give3n we assume current directory
	cd "${repository:-$current}"
	git status 2 &>1 >/dev/null
}

gs() {

	# DESC: set repository directory
	#       gets the status of the repository
	# ARGS: repository directory
	# OUTS: git status

	# vars
	local repository="$1"
	local current="$(/usr/bin/pwd)"

	# we trap errors and such
	#	trap "echo 'No repository directory given' && cd ${current}" ERR

	# we go to provide directory, if not given we use current
	cd "${repository:-$current}"
	git status 2>/dev/null

	# return to parent
	cd "${current}"
}

gc() {

	# DESC: set repository directory
	#       adds and commits the given changes
	# ARGS: repository directory
	# OUTS: committed files

	# vars
	local repository="$1"
	local current="$(/usr/bin/pwd)"

	# we trap errors and such
	#	trap "echo 'git commit failed, exiting' && cd ${current}" ERR

	# we switch to repository directory, if not give3n we assume current directory
	cd "${repository:-$current}"

	# validate git directory
	if [ -n "$(git status --porcelain)" ]; then
		echo "there are changes:"
		git diff

		# read a commit message
		# to do limit amount of chars
		read -rp $'Enter commit message here: ' -e commit_message

		# commit
		git add .
		git commit -m "${commit_message}"

	else
		echo "no changes"
	fi

	# return to source directory
	cd "${current}"
}

gpull() {

	# DESC: set repository directory
	#       adds and commits the given changes
	# ARGS: repository directory
	# OUTS: committed files

	# vars
	local repository="$1"
	local current="$(/usr/bin/pwd)"

	# we trap errors and such
	#	trap "echo 'git pull rebase failed, exiting' " ERR INT TERM EXIT

	# we set the path
	set_git_path "${repository}"

	# we assume changes have happenend on the remote
	# rebase
	git pull $(git remote show | head -n1) master --rebase
}
