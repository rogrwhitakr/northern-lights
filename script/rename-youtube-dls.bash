#! /usr/bin/env bash

# ######################################################################################
# BASH SCRIPT TEMPLATE
#   HISTORY:
#		2018-09-10		Script initially created
#		2018-10-30		moved to systemd logging - using systemd-cat
#						reworked the choice function
#		2018-12-04		systemd-cat has another function, really
#						just regurgitate to stout / sterr, that will be in logging
#						added an amount output
#						made script less verbose
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

# set directory videos sit in
video_dir="/mnt/backup/video"
cd "${video_dir}"

regexp_rename_spec() {
	if ([[ -f "${1}" ]] && [[ ! -z "${2}" ]]); then
		local file="${1}"
		local qualifier="${2}"

		local src="${file}"
		local ext="${file##*.}"

		print "BEFORE: ${file}"
		# remove extension
		file="${file//.${ext}/}"
		print "remove extension: ${file}"
		# remove youtube specifier
		if [[ "${qualifier}" == true ]]; then
			file="${file%%-*}"
		elif [[ "${qualifier}" == false ]]; then
			file="${file%-*}"
		fi
		print "removing youtube specifier: ${file}"
		# removing everything that is NOT [A-Za-z0-9]"
		file="${file//[^A-Za-z0-9]/_}"
		print "removing everything that is NOT [A-Za-z0-9]: ${file}"

		# removing doubles and triples and so forth
		file="${file//______/_}"
		file="${file//_____/_}"
		file="${file//____/_}"
		file="${file//___/_}"
		file="${file//__/_}"
		print "removing doubles and triples and so forth: ${file}"

		# removing any leftover underscores from end of string
		#file="${file%_*}"
		#print "removing any leftover underscores from end of string: ${file}"

		# reappending extension
		file="${file}.${ext}"
		if [[ "${src}" != "${file}" ]]; then
			mv "${src}" "${file}"
		fi
		print "AFTER: ${file}"
	fi
}

main() {

	amount="$(find . -mindepth 1 -maxdepth 1 -type f | wc | column --table | cut -d' ' -f1)"
	print LOGLINE
	print GREEN "Start of script ${0}"
	print "There are currently ${amount} files in directory $(pwd)"

	for file in *; do
		yt_chars=11
		ac="${file%%-*}"                                       # aggressive_count
		nac="${file%-*}"                                       # non_aggressive_count
		ext="${file##*.}"                                      # extension
		ye="${file:$((${#file} - ${yt_chars} - 2 - ${#ext}))}" # youtube+extension

		#		print YELLOW "aggressive count: file: ${#file} :: file%%-*: ${#ac} :: ytext: ${#ye}"
		#		print YELLOW "non-aggressive count: file: ${#file} :: file%-*: ${#nac} :: ytext: ${#ye}"

		if [[ "$((${#file} - ${#ac} - ${#ye}))" == 0 ]]; then
			regexp_rename_spec "${file}" true
		elif [[ "$((${#file} - ${#nac} - ${#ye}))" == 0 ]]; then
			regexp_rename_spec "${file}" false
		else
			# do nothing
			#	print "file: ${file}, not renaming. Continuing"
		fi
	done

	print LOGLINE
	print GREEN "all finished :: ${0}"

}

main "${@}"
