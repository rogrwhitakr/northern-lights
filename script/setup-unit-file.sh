#! /usr/bin/env bash

# global vars
readonly version="0.7.0"
readonly unit_file="${1}"

function usage() {
	cat <<EOF
${script_name} ... [FILE]...
this script creates a system service based upon passed unit file

REQUIREMENTS:
    file has a *.service, *.timer extension

VERSION:
	Version ${version:-' not defined'}
EOF
	exit 1
}

while getopts ":u:s:t:" opt; do
	case "${opt}" in
	s)
		script=${OPTARG}
		((s == 45 || s == 90)) || usage
		echo "s = ${s}"
		;;
	u)
		if [[ "${OPTARG#*.}" == "service" ]]; then
			printf "\nno service file with extension *.service provided!\Exiting"
			usage
			exit 1
		fi
		;;
	t)
		if [[ "${OPTARG#*.}" == "timer" ]]; then
			printf "\nno service file with extension *.timer provided!\Exiting"
			usage
			exit 1
		fi
		;;
	\?)
		echo "Invalid option: $OPTARG" 1>&2
		;;
	:)
		echo "Invalid option: $OPTARG requires an argument" 1>&2
		;;
	*)
		echo -e "in *)...\nThis happens, if a pass a flag that is defined, yet no case..in is available for it"
		;;
	esac
done

shift $((OPTIND - 1))

# check if file has a service extension
if ([[ ! "${unit_file#*.}" == "service" ]] || [[ ! "${unit_file#*.}" == "service" ]]); then
	printf "\nERROR:\n\tthe passed file has no \"*.service\" or \"*.timer\" extension!\n"
	usage
fi

###############################################
# if the unit_file variable is empty,
# we stop here
# else, we copy it to the directory

if [[ -n "${unit_file}" ]]; then
	printf "\ncreating service with unit file ${unit_file}"
	read -rp $'Continue with this unit file? (Y/n) : ' -ei $'n' continue_key

	if [[ "${continue_key}" == "Y" ]]; then
		sudo install "${unit_file}" --target-directory /etc/systemd/system/ --mode=622 --compare
	fi
else
	echo -e "ERROR:\nno unit file provided! $1 not found!"
fi

###############################################
# we could, of course do a lot of
# checking of the file is indeed a unit file
# todo: HOW?
###############################################

# - add a enabler / starter
add_to_systemd() {
	sudo systemctl enable "${unit_file##*/}" || systemctl status "${unit_file##*/}"
	sudo systemctl start "${unit_file##*/}" || systemctl status "${unit_file##*/}"
	sudo systemctl daemon-reload
}
add_to_systemd

exit 0
