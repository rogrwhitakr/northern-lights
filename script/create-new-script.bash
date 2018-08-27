#! /usr/bin/env bash

# TODOS
#		already exists, maybe use colors?
# DONE
#		if args empty show usage
#		if run without args, just show usage, no specifier

# GLOBAL
#
# DESC: Helper for setting up a new script
# ARGS: name of the future script
# OUTS: copy of the script template in <repo>/script named to specification
#       copy of usage depencency named to specification

version="1.1.0"

quiet=0
verbose=0
force=0
strict=0
debug=0

# DESC: debugging options
# ARGS: Flags debug, strict set
# OUTS: debugging info
# INFO: is called right away

flags_init() {
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
		print "
        Flag settings:
        quiet   =${quiet}
        verbose =${verbose}
        force   =${force}
        strict  =${strict}
        debug   =${debug}"
	fi
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
	LINE)
		separator="-"            # separator default
		line="["                 # adding to a "line" variable
		term_size="$(tput cols)" # get number of columns
		for ((i = 1; i <= "${term_size}-2"; i++)); do # make the line
			line+="${separator}"
		done
		line+="]"
		printf "${line}" # regurgitate to terminal
		;;
	COMMENTLINE)
		separator="-"            # separator default
		line="#"                 # adding to a "line" variable
		term_size="$(tput cols)" # get number of columns
		for ((i = 1; i <= "${term_size}-2"; i++)); do # make the line
			line+="${separator}"
		done
		line+="#"
		printf "${line}" # regurgitate to terminal
		;;
	*)
		printf '\033[0m%s\033[0m\n' "${1}"
		;;
	esac
}

script_init() {

	# DESC: Generic script initialisation
	# ARGS: $@ (optional): Arguments provided to the script
	# OUTS: $exec_path: The current working directory when the script was run
	#       $script_path: The full path to the script
	#       $script_dir: The directory path of the script
	#       $script_name: The file name of the script

	local exec_path="$PWD"
	readonly script_path="${BASH_SOURCE[1]}"
	readonly script=$(readlink -f $0)
	readonly script_dir="$(dirname "$script")"
	readonly script_name="$(basename "$script")"
	readonly script_params="$*"

	if [[ "${verbose}" == "1" ]]; then
		print "
        script settings:
        script_path   		=${script_path}
        script_full_path	=${script}
        script_dir   		=${script_dir}
        script_name  		=${script_name}
        script_params   	=${script_params}"
	fi
}

usage() {

	# DESC: print usage information
	# ARGS: None
	# OUTS: None
	# NOTE: must be customised to script to provide sensible info, duh.

	print RED "./${script_name} [NAME]...[DEPENDENCY OPTION]..."
	print "
# DESC: Helper for setting up a new script
# ARGS: name of the future script
# OUTS: copy of the script template in <repo>/script named to specification
#       copy of usage depencency named to specification

Script Version: ${version}
	"
	print RED "OPTIONS:"
	print "
  -n  future script name			<REQUIRED>
  -e  elements to include			<OPTIONAL>
	init
	choice
	log
	unitfile
	usage

    -t  use dependency template			<OPTIONAL>
    -h  Display help, version and exit		<OPTIONAL>

    Debugging options:
    -s  Exit script with null variables.  i.e 'set -o nounset'
    -v  verbose
    -d  run script in debug-mode (set -x)
	"
	print RED "PREREQUISITES / REQUIREMENTS:"
	print "    - name of future script
    - location is <repo>/script
	"
	print RED "EXAMPLES:"
	print "    - Create a script with dependencies 
        ./${script_name} -n testing-NICs.sh -d
    - Create a script with a single file
        ./${script_name} -n testing-NICs.sh
	"
}

choice_init() {

	# DESC: any and all flags go here for evaluation
	# ARGS: $@: Arguments provided to the script
	# OUTS: go for main

	# if not set, dependency setting is false
	t=false

	while getopts ":n:e:thsvd" opt; do
		case "${opt}" in
		n) # script name
			readonly n=${OPTARG}
			;;
		t) # dependency template or all-in-one template?
			t=true
			;;
		e) # elements (to add to the file, like init but not unit-file, but also logging...)
			elements+=("${OPTARG}") # use array -> ARGS MUST BE -e <thing1> -e <thing2>
			;;
		#		f) # Felements -> # use single variable -> ARGS MUST BE -f "thing1 thing2" separated by space
		#			set -f 					# disable glob
		#            IFS=' ' 				# split on space characters#
		#			felements=($OPTARG) # use the split+glob operator#
		#			;;
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
			print "in *)...\nThis happens, if a flag i spassed that is defined, yet no case..in is available for it"
			;;
		esac
	done

	shift $((OPTIND - 1))
}

choice_null_check() {

	# DESC: null-checks inputs provided to choice_init
	# ARGS: $@: Arguments set in choice_init
	# OUTS: go for main / usage if not

	if [ -z "${n}" ]; then
		usage
		print red "You must provide a name for the new script !!!"
		exit 5
	fi
}

choice_is_valid() {

	# DESC: validity-checks inputs provided to choice_init
	# ARGS: $@: Arguments set in choice_init
	# OUTS: go for main / usage if not

	local name="${name}"
	[[ ${name} =~ ^[a-zA-Z0-9_.\-]{1,255}$ ]] && echo "VALID" || echo "INVALID"
}

script_finish() {

	# DESC: Trap exits with cleanup function
	# ARGS: exit code -> trap <script_finish> EXIT INT TERM
	# OUTS: None (so far)

	local ERROR_CODE="$?"
	local name="${n}"
	local directory="${script_dir}"

	if [[ "${ERROR_CODE}" == 25 ]]; then
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
		# if "${directory}/${name}.sh" exists, we delete
		if [[ -f "${directory}/${name}" ]]; then
			rm -f "${directory}/${name}"
		fi
		print LINE
	else
		print "new script ${name} created. Exiting."
		print LINE
	fi
}

build_from_template() {

	# DESC: copies template from set directory
	#		renames template to set name
	# ARGS: name
	#		dependency yes/no
	#		template location
	#		usage location
	# OUTS: renamed and copied template file
	#[[ -ef is path comparison]]

	local directory=${script_dir}
	local name=${1}
	local dependency=${2}
	local helper_dir=${directory}"/helpers"
	local template_dir=${directory}"/template"

	print "creating template in ${directory}, name ${name}"

	local new_script="${directory}/${name}"

	if [[ "${dependency}" == false ]]; then

		# create file with name
		if [[ -f "${new_script}" ]]; then
			print "file ${new_script} already exists. Remove and start from scratch?"
			rm -vi "${new_script}"
		fi
		touch "${new_script}"

		# add it the main header, maybe setting the version and stuff along the way..
		cat ${template_dir}"/main.header.bash" >>"${new_script}"

		# change date to today
		version_date="$(date +%Y-%m-%d)"
		sed -i 's/XXXX-XX-XX/${version_date}/g' "${new_script}"

		# add featured tie-ins
		for element in "${elements[@]}"; do
			print YELLOW "adding element \"$element\" to new script"
			echo -e "" >>"${new_script}"
			echo -e "###### \"$element\" element #####" >>"${new_script}"
			echo -e "" >>"${new_script}"
			find "${helper_dir}" -name "${element}.bash" -exec cat {} \; >>"${new_script}" ||
				print RED "element ${element}.bash not found! Continuing..."
		done

		# add main
		cat ${template_dir}"/main.bash" >>"${new_script}"
		print GREEN "added all elements"

		print YELLOW "adding function calls"
		grep '^[a-z].*()' "${new_script}" | sed 's/() {//' >>"${new_script}" || echo "njet"
		print YELLOW "taking care of special functions"
		sed -i 's/^choice_init$/choice_init \"${@}\"/g' "${new_script}"
		sed -i 's/^main$/main \"${@}\"/g' "${new_script}"
		sed -i 's/^script_finish$/trap script_finish EXIT INT TERM/g' "${new_script}"

	else

		# create file with name
		if [[ -f "${new_script}" ]]; then
			print "file ${new_script} already exists. Remove and start from scratch?"
			rm -vi "${new_script}"
		fi
		touch "${new_script}"

		# add it the main header, maybe setting the version and stuff along the way..
		cat ${template_dir}"/main.header.bash" >>"${new_script}"

		# add empty line
		print "\n" >>"${new_script}"

		# add sourcing
		for feature in "${features[@]}"; do
			echo "source ${feature}" >>"${new_script}"
		done

		# get the init functions
		grep -h 'init() {' ${helpers} | sed 's/() {//g' >>"${new_script}"

		# finally, add it the main header
		cat ${template_dir}"/main.bash" >>"${new_script}"

		# copy necessary files
		#		cp "${helper_dir}" "${new_script}"
		#		cp "${USAGE}" "${directory}/${name}.usage.sh"

		# for the depenedncy one we need to copy the usage file
		# amend the usage file sourcing

		#		sed -i "s/source .\/helpers\/usage.sh/source .\/${name}.usage.sh/g" "${directory}/${name}.sh"
		#	elif [[ "${dependency}" == false ]]; then
		#		local directory=${script_dir}
		#		cp "${TEMPLATE_NO_DEPENDENCY}" "${directory}/${name}.sh"
		#	else
		#		print RED "something went wrong while copying / modifiying the template files"
		#		exit 5
		print GREEN "went here, all okay"
	fi

	print GREEN "making script executable..."
	chmod u+x "${new_script}"
}

main() {

	local name="${n}"
	local dependency="${t}"
	local extension=".sh"

	# start
	print line
	print GREEN "${script_name}: Building a new script from template(s)"

	# checking name
	choice_null_check "${name}"
	if [[ $(choice_is_valid) == 'INVALID' ]]; then
		exit 6
	fi

	# append ext if not passed
	if [[ "${name#*.}" != "bash" ]]; then
		if [[ "${name#*.}" != "sh" ]]; then
			print YELLOW "appending name: extension \"${extension}\""
			local name=${name}${extension}
		fi
	fi

	# intro
	print "name: ${name}, build with dependencies: ${dependency}"
	print "using ${#elements[@]} dependency elements:"
	for element in "${elements[@]}"; do
		print "	- $element"
	done

	# user callback
	read -rp $'Continue (Y/n)? ' -ei $'Y' key
	if [[ "${key}" == "Y" ]]; then
		print line
		build_from_template "${name}" "${dependency}"
	else
		print RED "script creation aborted by user."
		exit 5
	fi
}

# init the helpers
choice_init "${@}"
script_init

trap script_finish EXIT INT TERM

# Make it rain
main "$@"
