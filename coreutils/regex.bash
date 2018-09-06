#! /usr/bin/env bash

source "/home/admin/MyScripts/script/helpers/init.bash"

strict=0
debug=1

flags_init
# from stackoverflow:
# check validity of a date, format yyyymmdd
date="20180212"
date="20180s12"

[[ $date =~ ^[0-9]{4}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$ ]] && echo "yes" || echo "no"
#           |^^^^^^^^ ^^^^^^ ^^^^^^  ^^^^^^ ^^^^^^^^^^ ^^^^^^ |
#           |   |     ^^^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^^^^^ |
#           |   |          |                   |              |
#           |   |           \                  |              |
#           | --year--   --month--           --day--          |
#           |          either 01...09      either 01..09     end of line
# start of line            or 10,11,12         or 10..29
#                                              or 30, 31

# ATM there are some downloaded youtube videos in ~/Videos
# named like so:
#   'Ansible - an absolute basic overview-MfoAb50Br94.mp4'
# todo:
#   replace spaces with dashes
#   remove trailing whatevers

cd "/mnt/backup/video/regex.1"
#file='Ansible - an absolute basic overview-MfoAb50Br94.mp4'
pwd
# get the files

regexp_rename() {
	if [[ ! -z "${1}" ]]; then

		print YELLOW "BEFORE: ${file}"
		src="${file}"
		ext="${file#*.}"

		# remove extension
		file="${file//.${ext}/}"
		# remove youtube specifier
		file="${file%%-*}"
		# removing everything that is NOT [A-Za-z0-9]"
		file="${file//[^A-Za-z0-9]/_}"

		# removing doubles and triples and so forth
		# this should work better. why cant I do [asderf]{2,3}?
		file="${file//____/_}"
		file="${file//___/_}"
		file="${file//__/_}"

		regex="[äüö]"      # this works
		regex="[äüö]{1,3}" # this does not seem to work
		regex="---"           # this does not seem to work

		# reappending extension
		file="${file}.${ext}"
		if [[ "${src}" != "${file}" ]]; then
			mv "${src}" "${file}"
		fi
		print GREEN "AFTER: ${file}"
	else
		print RED "no file passed. exiting"
		exit 0
	fi
}

# do something depedning on extension (or any other part of the name, really...)
for file in *; do
	case "${file#*.}" in
	mp4)
		extension=MP4
		print LINE
		regexp_rename "${file}"
		#		stat "${file}"
		;;
	webm)
		extension=WEBEM
		print LINE
		print GREEN "renaming ${extension} file ${file}"
		regexp_rename "${file}"
		;;
	*)
		print RED "${file}"
		print RED "Unexpected expression '${file#*.}'"
		;;
	esac
done

exit 0
# You can parameterize the substrings.
substring='a.C'

# remove the trailing part
print YELLOW "removing the trailing part"
file="${file%-*.mp4}.mp4"
echo "file is now: ${file}"

# ${string//pattern/replacement}
# ${string/#pattern/replacement} replace beginning
# ${string/%pattern/replacement} replace end
# ${string//replacement} remove all occurences of replacement

# remove dash
file="${file//-/}"
# replace all spaces with dashes
file="${file// /-}"

# remove with offset:
# number of characters in string
# - offset of  characters at the end
# - dot separating ext and file name, dash at the end.. (-2)
# - extension
# two :: mean offset from end?

file="${file::$((${#file} - ${yt_id_chars} - 2 - ${#ext}))}"
file="${file:$((${#file} - ${yt_id_chars} - 2 - ${#ext}))}"

# replacing all stars with dashes
file="${file//\*/-}"

# removing a bunch of things
file="${file//[,/(/)]/}"
file="${file//[,/(/)_]/}"
