#! /usr/bin/env bash

# ######################################################################################
# BASH SCRIPT TEMPLATE
#   HISTORY:
#		2018-09-10		Script initially created
#		2018-10-30		moved to systemd logging - using systemd-cat
#						reworked the choice function
#
# ######################################################################################

#   VERSION
version="1.0.1"

source "/home/admin/MyScripts/script/helpers/init.bash"
source "/home/admin/MyScripts/script/helpers/log.bash"

strict=1
debug=0

script_init
flags_init
log_init

# set directory videos sit in
video_dir="/mnt/backup/video"
cd "${video_dir}"

regexp_rename_spec() {
	if ([[ -f "${1}" ]] && [[ ! -z "${2}" ]]); then
		local file="${1}"
		local qualifier="${2}"

		local src="${file}"
		local ext="${file##*.}"

		print "BEFORE: ${file}" | systemd-cat
		# remove extension
		file="${file//.${ext}/}"
		# remove youtube specifier
		if [[ "${qualifier}" == true ]]; then
			file="${file%%-*}"
		elif [[ "${qualifier}" == false ]]; then
			file="${file%-*}"
		fi
		# removing everything that is NOT [A-Za-z0-9]"
		file="${file//[^A-Za-z0-9]/_}"

		# removing doubles and triples and so forth
		file="${file//______/_}"
		file="${file//_____/_}"
		file="${file//____/_}"
		file="${file//___/_}"
		file="${file//__/_}"

		# removing any leftover underscores from end of string
		file="${file%_*}"
		# reappending extension
		file="${file}.${ext}"
		if [[ "${src}" != "${file}" ]]; then
			mv "${src}" "${file}"
		fi
		print "AFTER: ${file}" | systemd-cat
	else
		print "no regular file passed. doing nothing" | systemd-cat
	fi
}

main() {
	for file in *; do
		yt_chars=11
		ac="${file%%-*}"                                       # aggressive_count
		nac="${file%-*}"                                       # non_aggressive_count
		ext="${file##*.}"                                      # extension
		ye="${file:$((${#file} - ${yt_chars} - 2 - ${#ext}))}" # youtube+extension

		print YELLOW "aggressive count: file: ${#file} :: file%%-*: ${#ac} :: ytext: ${#ye}" | systemd-cat
		print YELLOW "aggressive count: file: ${#file} :: file%-*: ${#nac} :: ytext: ${#ye}" | systemd-cat
		if [[ "$((${#file} - ${#ac} - ${#ye}))" == 0 ]]; then
			regexp_rename_spec "${file}" true
		elif [[ "$((${#file} - ${#nac} - ${#ye}))" == 0 ]]; then
			regexp_rename_spec "${file}" false
		else
			print "not renaming file "${file}". Continuing" | systemd-cat
		fi
	done
}

main "${@}"
