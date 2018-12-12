#! /usr/bin/env bash

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

usage() {
	cat <<EOF
${script_name} [OPTION]... [FILE]...

this script sets up sourcing of:
	.bash_profile
	.bashrc
	.bashrc.d/*.bash

it creates a subdirectory ~/.bashrc.d/, which is in turn populated with distinct files containing:
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

script_finish() {

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
		# rm -fr ~/.bashrc.d
	fi
}

function main() {

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
	cd ~

	# we create .bashrc if it doesn't exist
	for source in "${sources[@]}"; do
		if [[ ! -f ~/"${source}" ]]; then
			printf "\ncreating ${source}"
			touch ~/"${source}"
		fi
	done

	# setting up directory
	# -> parentheses here DO NOT WORK
	# they hinder expansion of ~
	if [[ ! -d ~/"${_directory:-.bashrc.d}" ]]; then
		printf "\nCreating directory ~/${_directory:-.bashrc.d}"
		mkdir ~/"${_directory:-.bashrc.d}"
		cd ~/"${_directory:-.bashrc.d}"
	else
		cd ~/"${_directory:-.bashrc.d}"
	fi

	# i guess this `could' be handled by curl.
	# what if the amount of files changes?

	for file in "${files[@]}"; do
		printf "\ncollecting raw file from github: ${file}. Saving to $(pwd)"
		wget "${url}/${file}" -O "${file}"
	done

	# setting up .bashrc file in such a way that the files get sourced

	# remove old sourcing
	# okay apparently sed is at its best when looking at one individual line
	# potentially anything not named .* will suffer in the second line command

	# source might also work!
	# why is this not a default??????

	for file in "${files[@]}"; do
		printf "\nremoving definition for ${file}"
		sed --in-place "/# Source user ${file} definitions/d" ~/.bashrc
		sed --in-place "/${file}/d" ~/.bashrc
		sed --in-place "/fi # <- end source/d" ~/.bashrc
	done

	# put the new sourcing in

	# DEFINITION
	# # Source user ${file} definitions
	# if [[ -f ~/.dotfiles/${file} ]]; then
	# 	. ~/.dotfiles/${file}
	# fi # <- end sources

	for file in "${files[@]}"; do
		printf "adding sourcing for ${file}"
		echo -e "# Source user ${file} definitions
if [[ -f ~/.dotfiles/${file} ]]; then
	. ~/.dotfiles/${file}
fi # <- end source" >>~/.bashrc
	done

	printf "\nCompleted."
	printf "\n"

}

# Make it rain
main "$@"
