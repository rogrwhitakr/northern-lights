#! /usr/bin/env bash

# TODOS
#		if args empty show usage
#		if run without args, just show usage, no specifier
#		make usage contain info required:recomendend:optional flags and params
#		already exists, maybe use colors?
# DONE

# GLOBAL
#
# DESC: Helper for setting up a new script
# ARGS: name of the future script
# OUTS: copy of the script template in <repo>/script named to specification
#       copy of usage depencency named to specification

version="1.0.0"

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
	*)
		printf '\033[0m%s\033[0m\n' "${1}"
		;;
	esac
}

# DESC: Generic script initialisation
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: $exec_path: The current working directory when the script was run
#       $script_path: The full path to the script
#       $script_dir: The directory path of the script
#       $script_name: The file name of the script

function script_init() {
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

# DESC: print usage information
# ARGS: None
# OUTS: None
# NOTE: must be customised to script to provide sensible info, duh.

usage() {

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

# DESC: Trap exits with cleanup function
# ARGS: exit code -> trap <script_finish> EXIT INT TERM
# OUTS: None (so far)

script_finish() {
	local ERROR_CODE="$?"
	local name="${name}"
	local directory="${script_dir}"

	if [[ "${ERROR_CODE}" == 25 ]]; then
		print RED "name check: ${name} contains disallowed characters!"
		print "\tallowed characters: [a-zA-Z0-9_-.]"
	elif [[ "${ERROR_CODE}" == 5 ]]; then
		print YELLOW "no script created, exiting"
	elif [[ "${ERROR_CODE}" != 0 ]]; then
		# if "${directory}/${name}.sh" exists, we delete
		if [[ -f "${directory}/${name}.sh" ]]; then
			rm -f "${directory}/${name}.sh"
			rm -f "${directory}/${name}.usage.sh"
		fi
	else
		print "new script ${name} created. Exiting."
	fi
}

# DESC: Initialise colour variables
# ARGS: None
# OUTS: Read-only variables with ANSI control codes
# NOTE: If --no-colour was set the variables will be empty

color_init() {
	readonly RED='\033[0;31m'
	readonly YELLOW='\e[33m'
	readonly NOC='\033[0m'
	readonly BLUE='\e[34m'
	readonly GREEN='\e[0;32m'
}

# DESC: any and all flags go here for evaluation
# ARGS: $@: Arguments provided to the script
# OUTS: go for main

# if array variable exists do nothing
if [[ -z "${e}" ]]; then
	declare -a e="init"
fi

choice_init() {

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
			e+=" "
			e+="${OPTARG}"
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
			print "in *)...\nThis happens, if a flag i spassed that is defined, yet no case..in is available for it"
			;;
		esac
	done

	shift $((OPTIND - 1))
}

# DESC: null-checks inputs provided to choice_init
# ARGS: $@: Arguments set in choice_init
# OUTS: go for main / usage if not

choice_check() {
	if [ -z "${n}" ]; then
		usage
		print red "You must provide a name for the new script !!!"
		exit 0
	fi
}

# DESC: validity-checks inputs provided to choice_init
# ARGS: $@: Arguments set in choice_init
# OUTS: go for main / usage if not

choice_is_valid() {
	local name="${name}"
	[[ ${name} =~ ^[a-zA-Z0-9_.\-]{1,255}$ ]] && echo "VALID" || echo "INVALID"
}

# DESC: copies template from set directory
#		renames template to set name
# ARGS: name
#		dependency yes/no
#		template location
#		usage location
# OUTS: renamed and copied template file
#[[ -ef is path comparison]]

build_from_template() {

	local directory=${script_dir}
	local name=${1}
	local dependency=${2}
	local helper_dir="/home/admin/MyScripts/script/helpers"
	local helpers="/home/admin/MyScripts/script/helpers/*.sh"
	local template_dir="/home/admin/MyScripts/script/template"
	local ext="sh"

	print "creating template in ${directory}, name ${name}.${ext}"
	# get an array of the files to be added, may enable ordering
	# this is somewhat problematic. i amy have to revert to manual sequence selection of files to source
	# ATM the unit file one is the first, that is not sensible
	# i could reverse the array, ba this rests entirely on the naming of the source files
	# on the other hand "find" has a somewhat dynamic element to it....

	readarray features < <(find ${helper_dir} -type f)

	if [[ "${dependency}" == false ]]; then

		# create file with name
		if [[ -f "${directory}/${name}.${ext}" ]]; then
			print "file ${directory}/${name}.${ext} already exists. Remove and start from scratch?"
			rm -vi "${directory}/${name}.${ext}"
		fi
		touch "${directory}/${name}.${ext}"

		# add it the main header, maybe setting the version and stuff along the way..
		cat ${template_dir}"/main.header.bash" >>"${directory}/${name}.${ext}"

		# add featured tie-ins
		for feature in "${features[@]}"; do
			echo  -e "\n#####\n" >>"${directory}/${name}.${ext}"
			cat $feature >>"${directory}/${name}.${ext}"
		done

		# get the init functions
		# grep -h 'init() {' ${helpers} | sed 's/() {//g' >>"${directory}/${name}.${ext}"
		# finally, add it the main header
		cat ${template_dir}"/main.bash" >>"${directory}/${name}.${ext}"

	else

		# create file with name
		if [[ -f "${directory}/${name}.${ext}" ]]; then
			print "file ${directory}/${name}.${ext} already exists. Remove and start from scratch?"
			rm -vi "${directory}/${name}.${ext}"
		fi
		touch "${directory}/${name}.${ext}"

		# add it the main header, maybe setting the version and stuff along the way..
		cat ${template_dir}"/main.header.bash" >>"${directory}/${name}.${ext}"

		# add empty line
		print "\n" >>"${directory}/${name}.${ext}"

		# add sourcing
		for feature in "${features[@]}"; do
			echo "source ${feature}" >>"${directory}/${name}.${ext}"
		done

		# get the init functions
		grep -h 'init() {' ${helpers} | sed 's/() {//g' >>"${directory}/${name}.${ext}"

		# finally, add it the main header
		cat ${template_dir}"/main.bash" >>"${directory}/${name}.${ext}"

		# copy necessary files
		#		cp "${helper_dir}" "${directory}/${name}.${ext}"
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
}

readonly ERROR_CHOICE_INVALID=35

main() {

	print line -
	local name="${n}"
	local dependency="${t}"
	declare -a elements=("${e}")

	for element in "${elements[@]}"; do
		echo "$element is my friend"
	done

	print line -
	local elements=("init" "choice" "log")
	for element in "${elements[@]}"; do
		echo "$element is my friend"
	done

	choice_check "${name}"
	# retrurning the code does not work this way....
	# -> this gets me straight to 'the' trap
	if [[ $(choice_is_valid) == 'INVALID' ]]; then
		echo "hmmm"
		exit 0
	fi
	print "${elements}"
	print "name: ${name}.sh, build with dependencies: ${dependency}"

	read -rp $'Continue (Y/n)? ' -ei $'Y' key
	if [[ "${key}" == "Y" ]]; then
		build_from_template "${name}" "${dependency}"
	else
		print RED "script creation aborted by user."
		exit 5
	fi
}

# init the helpers
choice_init "${@}"
script_init
color_init

trap script_finish EXIT INT TERM

# Make it rain
main "$@"
