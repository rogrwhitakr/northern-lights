#! /usr/bin/env sh

# DESC: Generic logging initialisation
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: logging to /var/log/>script_name>

create_log() {
	if [[ ! -n "${script_name}" ]]; then
		log="/var/log/$(script_name)"
	fi

	echo $log
	# create if it doesnt exit
	if [[ ! -f "${log}" ]]; then
		sudo touch "${log}"
	fi

	# own if it is not owned
	stat -c '%U' "${log}"
	check who owns...
	# make usable by allowing reading / writing to the file
	if [[ "${log}" ]]; then
		sudo chmod 644
	fi
}
