#!/usr/bin/env bash

# Create a new directory and enter it
mkd() {
	if [[ -z "$@" ]]; then
		echo -e "no input given"
		break
	fi
	mkdir -p "$@" && cd "$_"
}

# append a todo to the README.md of the "default" repository
todo() {
	local repository=~/MyScripts/README.md
	if [[ -z "$@" ]]; then
		echo -e "no input given to append to ${repository}"
		break
	fi
	if [[ ! -r "${repository}" ]]; then
		echo -e "no file to write to found!"
		break
	else
		echo -n -e "\n- $@" >>"${repository}"
		echo "added \"$@\" to "${repository##*/}""
	fi
}

# get entries of ssh config
remotes() {
	if [[ ! -r ~/.ssh/config ]]; then
		printf "no ssh-config-file found! Exiting"
		break
	else
		awk '/Host / { print $2 }' ~/.ssh/config | nl -w 2
	fi
}

# colorise man pages

man() {
	env \
		LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
		LESS_TERMCAP_md="$(printf "\e[1;31m")" \
		LESS_TERMCAP_me="$(printf "\e[0m")" \
		LESS_TERMCAP_se="$(printf "\e[0m")" \
		LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
		LESS_TERMCAP_ue="$(printf "\e[0m")" \
		LESS_TERMCAP_us="$(printf "\e[1;32m")" \
		man "${@}"
}

# list all and only hidden files in directory
hidden() {
	if [ -z "$@" ]; then
		directory=$(pwd)
	else
		directory="$@"
	fi
	ls -ld "${directory}"/.*
}

# universal extract, stolen from github somewhere
function extract() {
	if [ -z "$1" ]; then
		echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
	else
		if [ -f $1 ]; then
			# NAME=${1%.*}
			# mkdir $NAME && cd $NAME
			case $1 in
			*.tar.bz2) tar xvjf $1 ;;
			*.tar.gz) tar xvzf $1 ;;
			*.tar.xz) tar xvJf $1 ;;
			*.lzma) unlzma $1 ;;
			*.bz2) bunzip2 $1 ;;
			*.rar) unrar x -ad $1 ;;
			*.gz) gunzip $1 ;;
			*.tar) tar xvf $1 ;;
			*.tbz2) tar xvjf $1 ;;
			*.tgz) tar xvzf $1 ;;
			*.zip) unzip $1 ;;
			*.Z) uncompress $1 ;;
			*.7z) 7z x $1 ;;
			*.xz) unxz ../$1 ;;
			*.exe) cabextract ../$1 ;;
			*) echo "extract: '$1' - unknown archive method" ;;
			esac
		else
			echo "$1 - file does not exist"
		fi
	fi
}

# compress common compressed Filetypes
function compress() {
	if [[ -z "$1" ]]; then
		echo "Usage: compress <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
	else
		file=$1
		shift
		case "${file}" in
		*.tar.bz2) tar cjf "${file}" "$@" ;;
		*.tar.gz) tar czf "${file}" "$@" ;;
		*.tgz) tar czf "${file}" "$@" ;;
		*.zip) zip "${file}" "$@" ;;
		*.rar) rar "${file}" "$@" ;;
		*) echo "filetype not recognized" ;;
		esac
	fi
}

# Create a data URL from a file
# unsure what this is useful for, i will just try it out
# why do these functions not have in input chcek, at least for null???????
dataURL() {
	local mimeType=$(file -b --mime-type "$1")
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8"
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

function test_function() {
	echo -e "i dont do anything!!!"
}
