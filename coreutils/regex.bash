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

cd "/mnt/backup/video/regex.2"
#file='Ansible - an absolute basic overview-MfoAb50Br94.mp4'
pwd
# get the files

regexp_rename() {
	if [[ -f "${1}" ]]; then

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
		print RED "no regular file passed. exiting"
		exit 0
	fi
}

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
		print RED "no regular file passed. exiting"
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
		# stat "${file}"
		;;
	webm)
		extension=WEBEM
		print LINE
		print GREEN "renaming ${extension} file ${file}"
		regexp_rename "${file}"
		;;
	*)
		print RED "${file}"
		print RED "Unexpected extension '${file#*.}'. it is not defined!"
		;;
	esac
done

print RED "now to the new stuff"
src="/mnt/backup/video/Adam Jacob + Chef Automate demo by Seth Falcon & Dominik Richter  - ChefConf 2017 Keynote-r7_f8fIn-Yo.mp4"
file="/mnt/backup/video/Adam Jacob + Chef Automate demo by Seth Falcon & Dominik Richter  - ChefConf 2017 Keynote-r7_f8fIn-Yo.mp4"
ext="${file#*.}"
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

# removing a bunch of things. unsure if works
file="${file//[,/(/)]/}"
file="${file//[,/(/)_]/}"

# remove with offset:
# number of characters in string
# - offset of  characters at the end
# - dot separating ext and file name, dash at the end.. (-2)
# - extension
# two :: mean offset from end?
#file="/mnt/backup/video/Adam Jacob + Chef Automate demo by Seth Falcon & Dominik Richter  - ChefConf 2017 Keynote-r7_f8fIn-Yo.mp4"
file=""
file="/mnt/backup/video/Impulse/Impulse - Ep 2 'State of Mind'-dNJMI92NZJ0.mp4"

print LINE

cd "/mnt/backup/video"

for file in *.mp4; do
	print GREEN "${file}"
	yt_chars=11
	ac="${file%%-*}"                                       # aggressive_count
	nac="${file%-*}"                                       # non_aggressive_count
	ye="${file:$((${#file} - ${yt_chars} - 2 - ${#ext}))}" # youtube+extension

	print YELLOW "aggressive count: file: ${#file} :: file%%-*: ${#ac} :: ytext: ${#ye}"
	print YELLOW "aggressive count: file: ${#file} :: file%-*: ${#nac} :: ytext: ${#ye}"
	if [[ "$((${#file} - ${#ac} - ${#ye}))" == 0 ]]; then
		echo 'first'
		echo "file should be:"
		print RED "${ac}"
		regexp_rename_spec "${file}" true
	elif [[ "$((${#file} - ${#nac} - ${#ye}))" == 0 ]]; then
		echo 'segundo'
		echo "file should be:"
		print RED "${nac}"
		regexp_rename_spec "${file}" false
	else
		echo 'thirto. maybe do nothing'
		echo "$((${#file} - ${#nac} - ${#ye}))"
		echo "$((${#file} - ${#ac} - ${#ye}))"
	fi
done

# https://stackoverflow.com/questions/19737675/shell-script-how-to-extract-string-using-regular-expressions

validate_ip(){

	if [ -z "$1" ]; then
		echo 'validate_ip: no input provided'
		exit 1
	fi
	
	ip_regex=^[0-2]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$

	if [[ $1 =~ $ip_regex ]]; then
		echo 'valid'
		echo needs range limits ! only 255.255.255.255 as max!

	else 
		echo 'doesnt work yet'
	fi
}

read -rp $'Enter an IP address:\n' ip_address

echo $ip_address

validate_ip $ip_address

exit 0