
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
