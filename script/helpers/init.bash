##### variables ###

#quiet=0
#verbose=0
#force=0
#strict=0
#debug=0

##### functions ###

flags_init() {

	# DESC: debugging options
	# ARGS: Flags debug, strict set
	# OUTS: debugging info
	# INFO: is called right away

	local quiet=${quiet}
	local verbose=${verbose}
	local force=${force}
	local strict=${strict}
	local debug=${debug}

	# enforce running in debug mode
	# one `COULD` build a unset -x functionality also...
	if [[ "${debug}" == "1" ]]; then
		set -x
	fi
	# Exit on empty variable
	if [[ "${strict}" == "1" ]]; then
		set -o nounset
	fi

	# Bash will remember & return the highest exitcode in a chain of pipes.
	# This way you can catch the error in case mysqldump fails in `mysqldump |gzip`, for example.
	set -o pipefail

	# Exit on error. Append '||true' when you run the script if you expect an error.
	set -o errexit

	if [[ "${verbose}" == "1" ]]; then
		echo -e "
        Flag settings:
        quiet   =${quiet}
        verbose =${verbose}
        force   =${force}
        strict  =${strict}
        debug   =${debug}"
	fi
}

script_init() {

	# DESC: Generic script initialisation
	# ARGS: $@ (optional): Arguments provided to the script
	# OUTS: $exec_path: The current working directory when the script was run
	#       $script_path: The full path to the script
	#       $script_dir: The directory path of the script
	#       $script_name: The file name of the script

	# additional explainer:
	# ${BASH_SOURCE[0]} (or, more simply, $BASH_SOURCE[1] ) contains the (potentially relative) path
	# of the containing script in all invocation scenarios, notably also when the script is sourced,
	# which is not true for $0.
	# integrate ${BASH_SOURCE[1]%/*}

	local exec_path="$PWD"
	readonly script_path="${BASH_SOURCE[1]}"
	readonly script_dir="$(dirname "$script_path")"
	readonly script_name="$(basename "$script_path")"
	readonly script_params="$*"
}

print() {

	# DESC: pretty print text, lines
	# ARGS: 1 -> Color, line
	#		choices are:
	#			RED
	#			YELLOW
	#			BLUE
	#			GREEN
	#			NOC (no color)
	#			LINE
	#
	# ARGS: 2 -> Text, line element
	# OUTS: colorised text, (non-colorised) line
	# LIMITS:
	#		cannot take formatters (newline,tabs,etc...)
	# EXAMPLE:
	#		print RED "text to be printed red"
	#		print "text to be printed without color"
	#		print LINE
	#		print LINE #

	case "${1^^}" in
	RED)
		printf '\033[0;31m%s\033[0m\n' "${2}"
		;;
	YELLOW)
		printf '\e[33m%s\033[0m\n' "${2}"
		;;
	BLUE)
		printf '\e[33m%s\033[0m\n' "${2}"
		;;
	GREEN)
		printf '\e[0;32m%s\033[0m\n' "${2}"
		;;
	LOG)
		printf '%(%F %T)T :: %s\n' -1 "${2}"
		;;

	# this option is for running a script with systemd
	# systemd does not create a terminal (and its size),
	# so the $TERM variable stays empty. using a fixed length
	LOGLINE)
		separator="-" # separator default
		logline="["
		for ((i = 1; i <= 50; i++)); do # make the line
			logline+="${separator}"
		done
		logline+="]"
		printf '%s\n' "${logline}" # regurgitate to terminal
		;;
	LINE)
		separator="-"            # separator default
		line="["                 # adding to a "line" variable
		term_size="$(tput cols)" # get number of columns
		if ([[ ! -z "$2" ]] && [[ "${#2}" == 1 ]]); then # set custom the separator (length must be 1)
			separator="${2}"
		fi
		for ((i = 1; i <= "${term_size}-2"; i++)); do # make the line
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

flags_init
script_init