#! /usr/bin/env bash

# ######################################################################################
# BASH SCRIPT TEMPLATE
#   HISTORY:
#
#   2018-07-11 - v0.0.1  -  First Creation
#
# ######################################################################################

# VARIABLES
#   VERSION
version="0.0.1"

EXIT_SUCCESS=0
EXIT_FAILURE=1
EXIT_ERROR=2
EXIT_BUG=10
ERROR_USER_UNKNOWN=20
ERROR_DIRECTORY_UNKNOWN=30

# DESC: sourcing of helper scripts
# ARGS: none
# OUTS: some variables, usage
# INFO: copy and append sourcing of "usage"
#       edit "<yo-scripts-name>.usage.sh" to fit your script

source "${BASH_SOURCE[1]%/*}/log-dependency-test.usage.sh"
source "${BASH_SOURCE[1]%/*}/helpers/initialisation.sh"
source "${BASH_SOURCE[1]%/*}/helpers/logging.sh"
USAGE=${BASH_SOURCE[1]%/*}/log-dependency-test.usage.sh
echo -e "${USAGE}"
source ${USAGE}
echo -e "${BASH_SOURCE[1]}"
# this is it!!
echo -e "new souring nigga!!!!"
echo -e "${BASH_SOURCE[1]%/*}"

# DESC: Trap exits with cleanup function
# ARGS: exit code -> trap <script_finish> EXIT INT TERM
# OUTS: None (so far)
# INFO: ERROR_CODE is put in local var, b/c otherwise one gets the return code
#       of the most recently completed command
#       (and i dont care for knowing "echo" ran successfully...)
# INFO: sourcing this DOES NOT WORK!
#       any assigned return codes will be overwritten by the "sourcing" retrun code,
#       so this is useless!!!

script_finish() {

	local ERROR_CODE="$?"
	if [[ "${ERROR_CODE}" == 0 ]]; then
		echo -e "${GREEN}exit green, no errors${NOC}"
		echo -e "ERROR CODE: ${ERROR_CODE}"
	elif [[ "${ERROR_CODE}" == 20 ]]; then
		echo -e "${RED}user is unknown to the system!${NOC}"
	else
		echo -e "${RED}exit RED${NOC}"
		echo -e "ERROR CODE: ${ERROR_CODE}"
	fi
	echo -e "${YELLOW}trap::script_finish::handler -> ${ERROR_CODE}${NOC}"
}

choice_init() {

	# if not set, dependency setting is false
	l=false

	while getopts ":n:p:lfqlhsvd" opt; do
		case "${opt}" in
		u) # user
			u=${OPTARG}
			id -u "${u}" &&
				echo "success!" ||
				return "${ERROR_USER_UNKNOWN}"
			;;
		p) # password
			p=${OPTARG}
			if [[ -z "${OPTARG}" ]]; then
				echo -e "no value provided for password!"
				usage
			fi
			echo "-p was triggered, Parameter: $OPTARG" >&2
			;;
		n) # script name
			readonly n=${OPTARG}
			;;
		l) # create log or not?
			l=true
			;;
		q)
			q=${OPTARG}
			;;
		l)
			l=${OPTARG}
			;;
		h)
			usage
			;;

		# debugging options
		d) # debug
			debug=1
			flags_init ${debug}
			;;
		v) # verbose
			verbose=1
			flags_init ${verbose}
			;;
		s) # strict
			strict=1
			flags_init ${strict}
			;;
		#p) -> pid would be something...
		\?)
			echo "Invalid option: $OPTARG" 1>&2
			;;
		:)
			# If no argument is provided getopts will set opt to :.
			# recognize this error condition by catching the : case
			# and printing an appropriate error message.
			echo "Invalid option: $OPTARG requires an argument" 1>&2
			;;

		*)
			echo -e "in *)...\nThis happens, if a flag i spassed that is defined, yet no case..in is available for it"
			;;
		esac
	done

	shift $((OPTIND - 1))
}

# DESC: the core function of the script
# ARGS: $@: Arguments provided to the script
# OUTS: Magic!

function main() {

	# main seem sto assume some inits first...
	echo -e "${YELLOW}first we check choices${NOC}"
	choice_init "${@}"

	local log="${l}"
	echo -e "${YELLOW}within main${NOC}"

	echo "${script_name%%.*}"
	echo "${script_name%.*}"
	if [[ "${log}" == true ]]; then
		log_init
		echo "logging something to the file. "
		echo 'mr'
	fi

	echo "logging something to the file. "

	range=$((RANDOM % 20))
	for i in $(seq 1 $range); do
		echo -e "$i ninjas on the prowl"

	done

	# The seq method is the simplest, but Bash has built-in arithmetic evaluation.
	END=5
	for ((i = 1; i <= END; i++)); do
		echo $i
	done
}

# init the helpers
color_init
flags_init
script_init
trap script_finish EXIT INT TERM

# Make it rain
main "$@"
