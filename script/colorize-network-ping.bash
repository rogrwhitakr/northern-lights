#! /usr/bin/env bash

# this function colorizes the time the ICMP protocol using Ping returns

# get the time from ping 
# ping localhost | cut -d= -f4

# grep
grep -E '(^[0-9]{1,2}\.[0-9]{1,3})' ~/ping-time

# works for < 100
export GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
grep -E '^[0-9]{1,2}\.[0-9]{1,3}' ~/ping-time

# everything > 100 < 500
grep -E '^[1-4]{1}[0-9]{2}\s' ~/ping-time

# everything higher then 500
grep -E '^[5-9]{1}[0-9]{2}\s' ~/ping-time

# i could also use bash to do the regex comparison:

analyse_time() {

	# DESC: analyses the input regarding time range
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

