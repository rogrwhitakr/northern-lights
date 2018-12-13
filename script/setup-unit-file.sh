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
	printf "\ncreating service with unit file ${unit_file}\n"
	sudo install "${unit_file}" --target-directory /etc/systemd/system/ --mode=622 --compare

	# we enable
	sudo systemctl enable "${unit_file}"
	# we verify
	systemd-analyze verify "${unit_file}" || printf "\nshit dont werk hoe! exiting...\n" && exit 1
	# we start if all goes well
	sudo systemctl start "${unit_file}" || printf "\nshit dont werk wit dat starter! exiting..." && exit 1
	# now we are done
	sudo systemctl daemon-reload
	systemctl status "${unit_file}"
else
	printf "\nERROR:\nno unit file provided! $1 not found!"
	exit 1
fi

exit 0