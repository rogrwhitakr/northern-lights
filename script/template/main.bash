# TOTO get list of functions

function main() {

	# DESC: the core function of the script
	# ARGS: $@: Arguments provided to the script
	# OUTS: Magic!

	# main seem sto assume some inits first...
	echo -e "${YELLOW}first we check choices${NOC}"
	choice_init "${@}"

	local test="declared testvar"

	echo -e "${script_name}"
	echo -e "${YELLOW}within main${NOC}"
}

# init the helpers
color_init
flags_init
script_init
trap script_finish EXIT INT TERM

# Make it rain
main "$@"
