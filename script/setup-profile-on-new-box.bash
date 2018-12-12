#! /usr/bin/env bash

# ######################################################################################
# BASH PROFILE SETUP
#   HISTORY:
#
#   2018-06-23 - v0.0.1  -  First Creation
#   2018-06-23 - v0.1.1  -  add one-shot service for pulling files
#
# ######################################################################################

# SOURCES
# these may need to be downloaded on first execution, yes???!
source '/home/admin/MyScripts/script/helpers/vars.bash'
source '/home/admin/MyScripts/script/helpers/init.bash'

vars_init
script_init

# VARIABLES
version="0.7.0"
quiet=0
verbose=0
force=0
strict=1
debug=0

usage() {

	cat <<EOF
${script_name} [OPTION]... [FILE]...

this script sets up sourcing of:
    .bash_profile
    .bashrc
it creates a subdirectory ~/.bashrc.d/, which is in turn populated with distinct files containing:
	alias.bash => holding aliases
	functions.bash => folding function definitions
	application specifics => (TBD) 
these templates are sourced from github.com:	
    github.com/rogrwhitakr/templates/

PREREQUISITES / REQUIREMENTS:
    - network connectivity

EOF
}

# DESC: Trap exits with cleanup function
# ARGS: exit code -> trap <script_finish> EXIT INT TERM
# OUTS: None (so far)
# INFO: ERROR_CODE is put in local var, b/c otherwise one gets the return code
#       of the most recently completed command
#       (and i dont care for knowing "echo" ran successfully...)

script_finish() {

	local ERROR_CODE="$?"
	if [[ "${ERROR_CODE}" == 0 ]]; then
		echo -e "${GREEN}exit green, no errors${NOC}"
		echo -e "ERROR CODE: ${ERROR_CODE}"
	else
		echo -e "${RED}exit RED${NOC}"
		echo -e "ERROR CODE: ${ERROR_CODE}"
	fi
	echo -e "${YELLOW}trap::script_finish::handler -> ${ERROR_CODE}${NOC}"
}

# DESC: the core function of the script
# NOTE: main
# ARGS: $@: Arguments provided to the script
# OUTS: Magic!

function main() {

	script_init
	color_init
	usage
	trap script_finish EXIT INT TERM

	# create .bashrc if it doesn't exist
	# TODO correct path

	declare -a sources=('.bashrc' '.bash_profile' '.bash_logout')

	for source in "${sources[@]}"; do
		if [[ ! -f ~/"${source}" ]]; then
			echo -e "${GREEN}creating ${source}${NOC}"
			touch ~/"${source}"
		fi
	done

	# setting up directory
	# -> parentheses here DO NOT WORK
	# they hinder expansion of ~
	if [[ ! -d ~/.dotfiles ]]; then
		echo -e "${GREEN}Creating directory .dotfiles${NOC}"
		mkdir ~/.dotfiles && cd ~/.dotfiles
	else
		echo -e "${GREEN}Switching to directory .dotfiles${NOC}"
		cd ~/.dotfiles
	fi

	# getting stuff

	cd ~/.dotfiles

	declare -a files=('.alias' '.functions' '.export' '.programs')

	for file in "${files[@]}"; do
		echo -e "${GREEN}collecting raw file from github: ${file}. Saving to $(pwd)${NOC}"
		local url="https://raw.githubusercontent.com/rogrwhitakr/northern-lights/master/conf/dotfiles/system"
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
		echo -e "${YELLOW}adding sourcing for ${file}${NOC}"
		echo -e "# Source user ${file} definitions
if [[ -f ~/.dotfiles/${file} ]]; then
	. ~/.dotfiles/${file}
fi # <- end source" >>~/.bashrc
	done

}
# Make it rain
main "$@"
