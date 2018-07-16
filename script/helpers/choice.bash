# PROVIDES: choice_init
# PROVIDES: choice_check
# PROVIDES: choice_verify

choice_init() {

	# DESC: any and all flags go here for evaluation
	# ARGS: $@
	#       default flags (with sourcing)
	#       -f  force, skip all user interaction.  Implied 'Yes' to all actions.
	#       -q  Quiet (no output)
	#       -l  Print log to file
	#       -h  Display help, version and exit
	#       -s  set strict
	#       -v  verbose
	#       -d  run in debug-mode
	# OUTS: go for main

	# set any bools
	t=false

	# FLAGS ->                fqlhsvd
	while getopts ":s:u:p:n:thfqlhsvd" opt; do
		case "${opt}" in
		s) # in-choice-eval
			# both methods work. One is a little wordier
			s=${OPTARG}
			#1
			((s == 45 || s == 90)) || usage
			(("${OPTARG#*.}" == "service" || "${OPTARG#*.}" == "timer")) || usage
			#2
			if ([[ "${OPTARG#*.}" == "service" ]] || [[ "${OPTARG#*.}" == "timer" ]]); then
				s=${OPTARG}
			else
				usage
			fi
			;;
		u) # user
			readonly u=${OPTARG}
			id -u "${u}" &&
				echo "success!" ||
				return "${ERROR_USER_UNKNOWN}"
			;;
		p) # password
			readonly p=${OPTARG}
			if [[ -z "${OPTARG}" ]]; then
				echo -e "no value provided for password!"
				usage
			fi
			echo "-p was triggered, Parameter: $OPTARG" >&2
			;;
		n) # string input
			readonly n=${OPTARG}
			;;
		t) # boolean. set to false before choice loop...
			readonly t=true
			;;
		h) # usage output
			usage
			;;
		f) # force -> this seems a bit difficult / or needs to be handled with care.
			# anytime "read" or sudo command occurs, i will need to pass the thngy provided
			# read is probably easy, but needs to be incorporated into the script then
			# sudo, hm. i will need to look at that one....
			f=${OPTARG}
			;;
		q) # quiet
			q=${OPTARG}
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
		l) # log output to script
			l=${OPTARG}
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

# DESC: null-checks inputs provided to choice_init
# ARGS: $@: Arguments set in choice_init
# OUTS: go for main / usage if not
# TODO: check if we can get a list of the flags
#       sed the file for getopts flags, maybe..
#       otherwise its a manual set everytime. probably better

choice_check() {
	# multiple check
	# if [ -z "${s}" ] || [ -z "${p}" ] || [ -z "${m}" ]; then
	# single check
	if [[ -z "${n}" ]]; then
		echo -e "${RED}You must provide this and that!${NOC}
        "
		usage
		exit 0
	fi
}

choice_is_valid() {

	# DESC: validity-checks inputs provided to choice_init
	# ARGS: $@: Arguments set in choice_init
	# OUTS: VALID / INVALID flags

	local name="${name}"
	[[ ${name} =~ ^[a-zA-Z0-9_.\-]{1,255}$ ]] && echo "VALID" || echo "INVALID"
}
