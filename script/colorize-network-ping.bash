#! /usr/bin/env bash

# this function colorizes the time the ICMP protocol using Ping returns

# get the time from ping
# ping localhost | cut -d= -f4

# i could also use bash to do the regex comparison:

analyse_time() {

	# DESC: analyses the input regarding time range
	# 		using bash to do the regex comparison (there are probably a hundred other ways)
	# ARGS: time value
	# OUTS: numeric specifier

	local time="${1}"
	echo "time arg: ${time}"

	[[ ${time} =~ ^[0-9]{1,2}\.[0-9]{1,3}$ ]] && echo 0
	[[ ${time} =~ ^[1-4]{1}[0-9]{2}$ ]] && echo 1
	[[ ${time} =~ ^[5-9]{1}[0-9]{2}$ ]] && echo 2
	[[ ${time} =~ ^[1-4]{1}[0-9]{3}$ ]] && echo 3
	[[ ${time} =~ ^[5-9]{1}[0-9]{3}$ ]] && echo 4
	[[ ${time} =~ ^[0-9]{5}$ ]] && echo 5
}

analyse_time "99.122"
analyse_time "199"
analyse_time "799"
analyse_time "799 ms"
analyse_time "1799"
analyse_time "5799"
analyse_time "15799"

# this does not what i intend
analyse_time "$(ping localhost -c 1 | cut -d= -f4)"