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
declare -a files
readarray -t files < <(find "${source_dir}" -mindepth 1 -maxdepth 1 -type f -print)

# declare a resultset array and a placeholder
declare -A result
declare placeholder="[ASCII text]"

# helper function
get_them_results() {
	echo "${result[@]}"
	# Accessing the array
	print YELLOW '# Returns all items'
	echo "${result[*]}" # Returns all items
	print YELLOW '# Returns all indizes'
	echo "${!result[*]}" # Returns all indizes
	print YELLOW '# Number elements'
	echo "${#result[*]}" # Number elements
	print YELLOW '# Length of $nth item, n is 1'
	echo "${#result[${n-1}]}" # Length of $nth item
}

# this one may need a *
file "${source_dir}"

# iterate
print GREEN "there are ${#files[@]} files in directory $(pwd)"
for file in "${files[@]}"; do
	print YELLOW "${file}"

	# populate array
	info="$(file -b ${file})"

	# THEN, we do array stuff....
	# add the info, if null or empty add the placeholder instead
	result+=(["[${info:-$placeholder}]"]="${file:-$placeholder}")
done

# display reuslt
get_them_results


# this gets the file types based upon extension
find ${source_dir} -type f | sed -n 's/..*\.//p' | sort | uniq -c
exit 0

# ISO Media, MP4 v2 [ISO 14496-14]
# resolt needed
