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
