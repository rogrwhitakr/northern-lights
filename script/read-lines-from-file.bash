#! /usr/bin/env bash

file=/etc/jwhois.conf

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
scriptfile="${dir}/$(basename "${BASH_SOURCE[0]}")"

source "${dir}/helpers/init.bash"

file="${dir}/list_of_youtube_URLs.txt"

# If file exists
if [[ -f "${file}" ]]; then
	echo "${#file}"
	# read it
	# we have cleaned the file to read. but it is possible to get only certain elements...
	while IFS= read rline; do
		print ABSCHLUSS "processing line ${#rline} of ${#file} lines"
		if [[ -f "$(which youtube-dl)" ]]; then
		# replace with yt-dl executable
			echo "youtube-dl${rline}"
		fi
	done
fi <"${file}"
