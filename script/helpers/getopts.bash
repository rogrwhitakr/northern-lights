usage(){
	echo "usage"
}

# minimalist args provision
while getopts ":s:e:n:th" opt; do
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
	e) # elements (to add to the file, like init but not unit-file, but also logging...)
		elements+=("${OPTARG}") # use array -> ARGS MUST BE -e <thing1> -e <thing2>
		;;
	n) # string input
		readonly n=${OPTARG}
		;;
	t) # boolean. set to false before geopts
		readonly t=true
		;;
	h) # usage output
		usage
		;;
	\?)
		echo "Invalid option: $OPTARG" 1>&2
		;;
	:)
		echo "Invalid option: $OPTARG requires an argument" 1>&2
		;;
	*)
		echo -e "in *)...\nThis happens, if a flag i spassed that is defined, yet no case..in is available for it"
		;;
	esac
done

shift $((OPTIND - 1))
