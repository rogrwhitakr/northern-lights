#! /usr/bin/env bash

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

		print RED "BEFORE: ${file}"
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
		print GREEN "AFTER: ${file}"
	else
		print RED "no regular file passed. doing nothing"
	fi
}

main() {
	for file in *; do
		yt_chars=11
		ac="${file%%-*}"                                       # aggressive_count
		nac="${file%-*}"                                       # non_aggressive_count
		ext="${file##*.}"                                      # extension
		ye="${file:$((${#file} - ${yt_chars} - 2 - ${#ext}))}" # youtube+extension

		#	print YELLOW "aggressive count: file: ${#file} :: file%%-*: ${#ac} :: ytext: ${#ye}"
		#	print YELLOW "aggressive count: file: ${#file} :: file%-*: ${#nac} :: ytext: ${#ye}"
		if [[ "$((${#file} - ${#ac} - ${#ye}))" == 0 ]]; then
			regexp_rename_spec "${file}" true
		elif [[ "$((${#file} - ${#nac} - ${#ye}))" == 0 ]]; then
			regexp_rename_spec "${file}" false
		else
			print "not renaming file "${file}". Continuing"
		fi
	done
}

main "${@}"
