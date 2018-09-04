#! /usr/bin/env bash

source "/home/admin/MyScripts/script/helpers/init.bash"

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

cd ~/Downloads
cd "/mnt/backup/video/regex.1"
#file='Ansible - an absolute basic overview-MfoAb50Br94.mp4'
pwd
# get the files

# do something depedning on extension (or any other part of the name, really...)
for file in *; do
	case "${file#*.}" in
	mp4)
		extension=MP4
		print GREEN "${extension}"
		#		stat "${file}"
		;;
	webm)
		extension=WEBEM
		print YELLOW "${extension}"
		;;
	*)
		print RED "${file}"
		print RED "Unexpected expression '${file#*.}'"
		;;
	esac
done

##for file in *; do
#	print GREEN "processing file ${file}"
#	yt_id_chars=11
#	src="${file}"
#	ext="${file#*.}"
#
#	# this has issues. cannot be executed repeatedly, b/c i named the separator character "-"!
#	# when excuting this it simply removes the trailing part, making the string shorter every time
#	#	file="${file%-*.${ext}}.${ext}"
#
#	print GREEN "removing $((${yt_id_chars} + 2 + ${#ext})) characters from end-of-string"
#	# number of characters in string
#	# - offset of youtube characters at the end
#	# - dot separating ext and file name, dash at the end.. (-2)
#	# - extension
#	# reappending extension
#
#	file="${file::$((${#file} - ${yt_id_chars} - 2 - ${#ext}))}"
#	file="${file}.${ext}"
#
#	print YELLOW "removing dashes,commas,etc"
#	file="${file//[,/(/)_]/}"
#	print GREEN "processed file: ${file}, has ${#file} characters"
#	print YELLOW "replacing all spaces with dashes"
#	file="${file// /-}"
#	print RED "renaming file ${src} to ${file}"
#	mv "${src}" "${file}"
#	print GREEN "processed file: ${file}"
#	print LINE
#done
read -rp $'Continue (Y/n) : ' -ei $'Y' key
[ "${key}" != "Y" ] && exit 0

for file in *; do
	print GREEN "processing file ${file}"
	src="${file}"
	ext="${file#*.}"
	yt_id_chars=11

	print YELLOW "removing dashes,commas,etc"
	file="${file//[,/(/)]/}"
	file="${file//_/}"
	file="${file//\-.*/-}"
	print RED "${file}"

	# if the file has been processed before it will have dashes in it
	# so we check for FIRST dash available. that is  still not tha awesome...
	#	file="${file::$((${#file} - ${yt_id_chars} - 2 - ${#ext}))}"
	#	print RED "${file:$((${#file} - ${yt_id_chars} - 2 - ${#ext}))}"
	#	print RED "${file::$((${#file} - ${yt_id_chars} - 2 - ${#ext}))}"
	#	[[ "${file#*-}" =~ "-" ]] && echo "${file#*-}"
	print YELLOW "replacing all spaces with *"
	file="${file// /*}"
	print YELLOW "replacing all dashes with *"
	file="${file//-/*}"

	# we could remove all with dash separator
	# measured against a set length parameter that we know

	print YELLOW "removing all dash separated bits and pieces from the end"
	file="${file%%-*.${ext}}"

	print YELLOW "replacing all stars with dashes"
	file="${file//\*/-}"
	print YELLOW "reappending extension ${ext}"
	file="${file}.${ext}"
	#	print RED "renaming file ${src} to ${file}"
	#	mv "${src}" "${file}"
	print GREEN "processed file: ${file}"
	print LINE
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

echo "file is now: ${file}"
