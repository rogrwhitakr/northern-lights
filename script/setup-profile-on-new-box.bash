#!/usr/bin/env bash

# ######################################################################################
# BASH PROFILE SETUP
#   HISTORY:
#
#   2018-06-23 - v0.0.1  -  First Creation
#   2018-06-23 - v0.1.1  -  add one-shot service for pulling files
#
# ######################################################################################

# global vars
readonly version="0.7.0"

function usage {
	cat <<EOF
${0} [OPTION]... [FILE]...

this script sets up sourcing of:
	.bash_profile
	.bashrc
	.bashrc.d/*.bash

it creates a subdirectory "$HOME"/.bashrc.d/, which is in turn populated with distinct files containing:
	alias.bash => holding aliases
	functions.bash => folding function definitions
	application specifics => (TBD)

these are then referenced in the bashrc file.

templates are sourced from github.com:	
	github.com/rogrwhitakr/northern-lights/conf/dotfiles/.bashrc.d

PREREQUISITES / REQUIREMENTS:
	network connectivity

VERSION:
	Version ${version:-' not defined'}
EOF
}

function script_finish {

	# DESC: Trap exits with cleanup function
	# ARGS: exit code -> trap <script_finish> EXIT INT TERM
	# OUTS: None (so far)
	# INFO: ERROR_CODE is put in local var, b/c otherwise one gets the return code
	#       of the most recently completed command
	#       (and i dont care for knowing "echo" ran successfully...)

	local ERROR_CODE="$?"
	if [[ "${ERROR_CODE}" != 0 ]]; then
		printf "ERROR"
		usage
		# remove directory .bashrc.d ?
		rm -fr "$HOME"/.bashrc.d
	fi
}

function add_to_file {
	local destination="${1}"
	local file="${2}"
	local directory="${3}"

	echo -e "
# BEGIN SOURCE ${file^^} DEFINITION
if [[ -f ~/${directory}/${file} ]]; then
	. ~/${directory}/${file}
fi 
# END SOURCE ${file^^} DEFINITION" >>"$HOME/${destination}"
}

function main {
	# DESC: the core function of the script
	# NOTE: main
	# ARGS: $@: Arguments provided to the script
	# OUTS: Magic!

	# vars
	readonly _directory=".bashrc.d"
	readonly url="https://raw.githubusercontent.com/rogrwhitakr/northern-lights/master/conf/dotfiles/.bashrc.d"

	declare -a sources=('.bashrc' '.bash_profile')
	declare -a files=('alias.bash' 'function.bash' 'export.bash' 'program.bash')

	trap script_finish EXIT INT TERM

	# we start out in the executing users home dir
	# we create in the home of the user excuting the unit file!
	cd "$HOME"

	# we create .bashrc if it doesn't exist
	for source in "${sources[@]}"; do
		if [[ ! -f "$HOME"/"${source}" ]]; then
			printf "\ncreating ${source}"
			touch "$HOME"/"${source}"
		fi
	done

	# setting up directory
	# -> parentheses here DO NOT WORK
	# they hinder expansion of "$HOME"
	if [[ ! -d "$HOME"/"${_directory:-.bashrc.d}" ]]; then
		printf "\nCreating directory "$HOME"/${_directory:-.bashrc.d}"
		mkdir "$HOME"/"${_directory:-.bashrc.d}"
		cd "$HOME"/"${_directory:-.bashrc.d}"
	else
		cd "$HOME"/"${_directory:-.bashrc.d}"
	fi

	for file in "${files[@]}"; do
		printf "\ncollecting raw file from github: ${file}, saving to $(pwd)"
		wget "${url}/${file}" --output-document="${file}" --quiet
	done

	printf "\nremove old sourcing, if applicable"
	for source in "${sources[@]}"; do
		for file in "${files[@]}"; do
			sed -i "/SOURCE ${file^^} DEFINITION/,+5d" "$HOME"/"${source}"
		done
	done

	printf "\nadd sourcing to bash sources"
	for source in "${sources[@]}"; do
		for file in "${files[@]}"; do
			add_to_file "${source}" "${file}" "${_directory}"
		done
	done

	printf "\nCompleted."
	printf "\n"
}

# Make it rain
main "$@"
