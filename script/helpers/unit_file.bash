user_unit_file_var_init() {

	# DESC: initalise variables for unit file
	# NOTE: main
	# ARGS: none
	# OUTS: unit file name
	#		user and group to run it as
	#		executable location
	#		this is a TODO!
	#		where to bes put these scripts? some systemd recommended place?

	readonly unit_file="${BASH_SOURCE[1]}"
	readonly user="$(whoami)"
	readonly group="$(id --group --name ${user})"
	readonly executable="$(find /home/${user} -name profile-generator.sh -executable)"
}

verify_unit_file_syntax() {

	# DESC: verify unit file syntax
	# ARGS: unit
	# OUTS: verification bits

	unit="$1"

	if [[ -z "$1" ]]; then
		echo -e "no unit provided"
		return 12 # need to be defined globally
	else
		# this only works if it already is a service?
		systemd-analyze verify "${unit}"
	fi

}

verify_unit_file_extension() {

	# DESC: check if file has a service extension
	# ARGS: unit-file name
	# OUTS: none

	unit_file="$1"
	if [[ -z "$1" ]]; then
		echo -e "no unit file provided"
		return 12
	fi

	# yes, there are more unit file types, but
	# i do not think i create a lot of targets and whatnot.

	if [[ "${unit_file#*.}" == "service" ]]; then
		return 0
	elif [[ "${unit_file#*.}" == "socket" ]]; then
		return 0
	elif [[ "${unit_file#*.}" == "timer" ]]; then
		return 0
	else
		return 13
	fi
}

create_unit_file() {

	# DESC: create a one-shot unit file for executing bash script
	# NOTE: executed as user (non-root)
	# ARGS: $@: Arguments provided to the script
	# OUTS: unitfile creation

	local unit_file="$1"
	local user="$2"
	local group="$3"
	touch "${unit_file}"
	tee >>/dev/null "${unit_file}" <<EOF
# created on $(date +%Y-%m-%d)
Description=BASH Profile Generation and Update
After=network.target
Requires=network.target

[Service]
Type=one-shot
User=${user}
Group=${group}
ExecStart=$(which bash) /home/${user}/.dotfiles/profile-generator.sh

[Install]
WantedBy=multi-user.target
EOF
}
