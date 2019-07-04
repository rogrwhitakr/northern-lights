gs() {

	# DESC: set repository directory
	#       gets the status of the repository
	# ARGS: repository directory
	# OUTS: git status

	# vars
	local repository="$1"
	local current="$(/usr/bin/pwd)"

	# we trap errors and such
	trap "echo 'No repository directory given' && cd ${current}" ERR

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
	trap "echo 'samsing rong' && cd ${current}" ERR

	# we switch to repository directory, if not give3n we assume current directory
	cd "${repository:-$current}"

	# validate git directory
	# todo: if changed / unversioned files present, go to read
	if [ -n "$(git status --porcelain)" ]; then
		echo "there are changes"

		# read a commit message
		# to do limit amount of chars
		read -rp $'Enter commit message here: ' -e commit_message

		echo "commiting fing"
		# commit
		git add .
		git commit -m "${commit_message}"

	else
		echo "no changes"
	fi
}
