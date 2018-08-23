#! /usr/bin/env bash

source "../MyScripts/script/helpers/init.bash"

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

cd ~/Videos
#file='Ansible - an absolute basic overview-MfoAb50Br94.mp4'
pwd
# get the files

files=()
for file in *.webm; do
	print GREEN "processing file ${file}"
	src="${file}"
	print YELLOW "removing the trailing part, that youtube-dl creates."
	file="${file%-*.mp4}.mp4"
	print YELLOW "removing dashes,commas,etc"
	file="${file//-/}"
	file="${file//,/}"
	file="${file//(/}"
	file="${file//)/}"
	print YELLOW "replacing all spaces with dashes"
	file="${file// /-}"
	print RED "renaming file ${src} to ${file}"
	mv "${src}" "${file}"
	print GREEN "processed file: ${file}"
	print LINE
done
echo ${files[@]}
echo ${#files[@]}
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
