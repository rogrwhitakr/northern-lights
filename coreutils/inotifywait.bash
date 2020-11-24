#! /usr/bin/env bash

directory=/home/finch/backups


print() {
   	case "${1^^}" in
	LINE)
		separator="-"            # separator default
		line="[---[$(date +"%Y-%m-%d %H:%M:%S")]"                 # adding to a "line" variable
		term_size="$(tput cols)" # get number of columns
		if ([[ ! -z "$2" ]] && [[ "${#2}" == 1 ]]); then # set custom the separator (length must be 1)
			separator="${2}"
		fi
		for ((i = 1; i <= "${term_size}-26"; i++)); do # make the line
			line+="${separator}"
		done
		line+="]"
		printf '%s\n' "${line}" # regurgitate to terminal
		;;
	*)
		printf '\033[0m%s\033[0m\n' "${1}"
		;;
	esac
}



while inotifywait --recursive --event modify,create,delete,move "${directory:-~}"; do
    print line
done