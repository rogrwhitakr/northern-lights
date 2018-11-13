#!/usr/bin/env bash

# import some helpers
source ../script/helpers/init.bash

strict=1
debug=1
flags_init

# we look at video files for this one
source_dir='/mnt/backup/video/'
cd /mnt/backup/video/

# read all files into an array
declare -a files
readarray -t files < <(find "${source_dir}" -mindepth 1 -maxdepth 1 -type f -print)

# declare a resultset array
declare -A result
declare -i counter=1

# populate array
result=([foo]="bar" [foo2]="bar2" [foo3]="bar3")

result+=(["filetype"]="filename1")
result+=(["filetype"]="filename2")
result+=(["filetype"]="filename3")
result+=(["filetypy"]="filename4")
result["filetypy"]+="filename5"
echo "${result[foo2]}"
echo "${result[filetypy]}"
#printf "${result}"

print GREEN "there are ${#files[@]} files in directory $(pwd)"
for file in "${files[@]}"; do
#	print YELLOW "${file}"
	result+=((["$(file -b "${file}")"]="counter++"))
#	result+=(["$(file -b "${file}")"]="1")
#	print RED "$(file -b "${file}")"
#	counter="${result[$(file -b "${file}")]}"
#	print GREEN "from VAR: ${result[$(file -b "${file}")]}"
done

#print RED "${result[avi]}"
print RED "${result[ISO Media, MP4 v2 \[ISO 14496-14\]]}"

# this gets the file types based upon extension
find ${source_dir} -type f | sed -n 's/..*\.//p' | sort | uniq -c
exit 0

# ISO Media, MP4 v2 [ISO 14496-14]
# resolt needed