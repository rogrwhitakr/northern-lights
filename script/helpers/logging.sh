# DESC: Generic logging initialisation
#		logging to /var/log/>script_name>
# ARGS: script name
#		user name
# OUTS: log file creation

create_log_file() {

	# we cut of the sh / or whatever part
	local log_file="/var/log/${script_name%%.*}.log"

	# create the file if it doesnt exit
	if [[ ! -f "${log_file}" ]]; then
		sudo touch "${log_file}"
		if [[ $(stat -c '%U' "${log_file}") == "root" ]]; then
			sudo chown $(id -un).$(id -un) "${log_file}"
			sudo chmod 644 "${log_file}"
		fi
	fi
}
