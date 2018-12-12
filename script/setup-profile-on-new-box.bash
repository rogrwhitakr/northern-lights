#! /usr/bin/env bash

# ######################################################################################
# BASH PROFILE SETUP
#   HISTORY:
#
#   2018-06-23 - v0.0.1  -  First Creation
#   2018-06-23 - v0.1.1  -  add one-shot service for pulling files
#
# ######################################################################################

# VARIABLES
version="0.7.0"
quiet=0
verbose=0
force=0
strict=1
debug=1

# SOURCES
# these may need to be downloaded on first execution, yes???!
source '/home/admin/MyScripts/script/helpers/vars.bash'
source '/home/admin/MyScripts/script/helpers/init.bash'

flags_init
vars_init
script_init

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
	if [[ "${ERROR_CODE}" == 0 ]]; then
		print "exit green, no errors"
		echo -e "ERROR CODE: ${ERROR_CODE}"
	else
		echo -e "${RED}exit RED"
		echo -e "ERROR CODE: ${ERROR_CODE}"
	fi
	echo -e "${YELLOW}trap::script_finish::handler -> ${ERROR_CODE}"
}

# DESC: the core function of the script
# NOTE: main
# ARGS: $@: Arguments provided to the script
# OUTS: Magic!

function main() {

	usage
	trap script_finish EXIT INT TERM

	print RED 'all is well'
	print LINE
	exit 0

	# we start out in the executing users home dir
	cd ~

	# we create .bashrc if it doesn't exist
	# TODO correct path
	# we create in the home of the user excuting the unit file!

	declare -a sources=('.bashrc' '.bash_profile')
	for source in "${sources[@]}"; do
		if [[ ! -f ~/"${source}" ]]; then
			print "creating ${source}"
			touch ~/"${source}"
		fi
	done

	# setting up directory
	# -> parentheses here DO NOT WORK
	# they hinder expansion of ~
	if [[ ! -d ~/.bashrc.d ]]; then
		print "Creating directory ~/.bashrc.d"
		mkdir ~/.bashrc.d && cd ~/.bashrc.d
	else
		cd ~/.bashrc.d
	fi

	# getting stuff
	cd ~/.bashrc.d

	# i guess this `could' be handled by curl. 
	# what if the amount of files changes?
	declare -a files=('.alias' '.functions' '.export' '.programs')

	for file in "${files[@]}"; do
		print "collecting raw file from github: ${file}. Saving to $(pwd)"
		local url="https://raw.githubusercontent.com/rogrwhitakr/northern-lights/master/conf/bashrc.d/system"
		wget "${url}/${file}" -O "${file}"
	done

	# setting up .bashrc file in such a way that the files get sourced

	# remove old sourcing
	# okay apparently sed is at its best when looking at one individual line
	# potentially anything not named .* will suffer in the second line command

	for file in "${files[@]}"; do
		echo -e "removing definition for ${file}"
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
		echo -e "${YELLOW}adding sourcing for ${file}"
		echo -e "# Source user ${file} definitions
if [[ -f ~/.dotfiles/${file} ]]; then
	. ~/.dotfiles/${file}
fi # <- end source" >>~/.bashrc
	done

}

# Make it rain
main "$@"
