# ######################################################################################
# BASH SCRIPT TEMPLATE
#   HISTORY:
#		XXXX-XX-XX		Script initially created
#
# ######################################################################################

#   VERSION
version="0.0.1"

script_finish() {

	# DESC: Trap exits with cleanup function
	# ARGS: exit code -> trap <script_finish> EXIT INT TERM
	# OUTS: None (so far)
	# INFO: ERROR_CODE is put in local var, b/c otherwise one gets the return code
	#       of the most recently completed command
	#       (and i dont care for knowing "echo" ran successfully...)
	# INFO: sourcing this DOES NOT WORK!
	#       any assigned return codes will be overwritten by the "sourcing" retrun code,
	#       so this is useless!!!

	local ERROR_CODE="$?"
	if [[ "${ERROR_CODE}" == 0 ]]; then
		print GREEN "exit green, no errors"
	elif [[ "${ERROR_CODE}" == 20 ]]; then
		print RED "name check: ${name} contains disallowed characters!"
		print "\tallowed characters: [a-zA-Z0-9_-.]"
		print LINE
	elif [[ "${ERROR_CODE}" == 5 ]]; then
		print YELLOW "no script created, exiting"
		print LINE
	elif [[ "${ERROR_CODE}" == 6 ]]; then
		print YELLOW "Invalid name choice, exiting"
		print LINE
	elif [[ "${ERROR_CODE}" != 0 ]]; then
		print GREEN "all OK"
	else
		echo "somesin"
	fi
}
