#!/usr/bin/env bash

# import some helpers
source ../script/helpers/init.bash

strict=1
debug=0
flags_init

# we look at video files for this one
source_dir='/mnt/backup/video/'
cd /mnt/backup/video/

# read all files into an array
readarray files < <(find "${source_dir}" -mindepth 1 -maxdepth 1 -type f -print)

#print LINE
print GREEN "there are ${#files[@]} files in directory $(pwd)"
for file in "${files[@]}"; do
	print GREEN "${file}"
	#   stat "${file}"
done

sample='/mnt/backup/video/arrays_vs_lists_binary_search.mp4'
resultset=@()

get-file-stats() {

}
