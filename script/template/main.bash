
main() {

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
