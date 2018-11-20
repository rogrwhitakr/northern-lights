#! /usr/bin/env bash

source ../script/helpers/init.bash

strict=0
debug=0
flags_init

# okay, couple of things:
# works, but on screen formatting could be better / more uniform / needs a guideline
# TODO:
# - add the getopts thing
# functions

choice_init() {

	# DESC: any and all flags go here for evaluation
	# ARGS: $@
	#       default flags (with sourcing)
	#       -q  Quiet (no output)
	#       -h  Display help, version and exit
	#       -s  set strict
	#       -d  run in debug-mode
	# OUTS: go for main

	# set any bools
	t=false
    validate=false

	# FLAGS ->                fqlhsvd
	while getopts ":s:u:p:n:thfqlhsvd" opt; do
		case "${opt}" in
		u) # in-choice-eval
			if ([[ "${OPTARG#*.}" == "service" ]] || [[ "${OPTARG#*.}" == "timer" ]]); then
				u=${OPTARG}
			else
				usage
			fi
			;;
		s) # scipt used / called
			s=${OPTARG}
			;;
		p) # password
			readonly p=${OPTARG}
			if [[ -z "${OPTARG}" ]]; then
				echo -e "no value provided for password!"
				usage
			fi
			echo "-p was triggered, Parameter: $OPTARG" >&2
			;;
		v) # we enable validation. system-analyse does this for us
			readonly validate=true          
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
		# debugging options
		d) # debug
			debug=1
			flags_init ${debug}
			;;
		s) # strict
			strict=1
			flags_init ${strict}
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
}



usage() {

	if ([[ "$1" == "-h" ]] || [[ -z "$1" ]]); then
		print RED "USAGE:$0"
		print "copies passed unit file to proper folder"
		print "chmod 622 for this file"
		print RED "PREREQUISITES"
		print "file is passed as an argument"
		print "file is one of *.service, (*.timer)"
		exit 0

	elif ([[ "$1" == "-p" ]] || [[ "$1" == "--pid" ]]); then
		echo -e "$BASHPID"
	fi
}

choice_init "${@}"
###############################################
# check if file has a service extension
###############################################
unit_file="${u}"

if [[ "${unit_file#*.}" != "service" ]]; then
	echo -e "\nERROR:\n\tthe passed variable has no \"*.service\" extension!\n"
	if [[ "${unit_file#*.}" != "timer" ]]; then
		echo -e "\nERROR:\n\tthe passed variable has no \"*.timer\" extension!\n"
		display_help
	fi
	display_help
fi

###############################################
# check if file is located within $HOME
# get the full path
# what to do if there is more then one?
###############################################

unit_file=$(find $HOME -name "${unit_file}")

###############################################
# if the unit_file variable is empty,
# we stop here
# else, we copy it to the directory
###############################################

if [[ -n "${unit_file}" ]]; then
	echo -e "Found unit file for \n\t${unit_file} at\n\t${unit_file}"
	read -rp $'Continue with this unit file? (Y/n) : ' -ei $'n' continue_key

	if [[ "${continue_key}" == "Y" ]]; then
		echo -e "\texecuting..."
		sudo cp -i "${unit_file}" /etc/systemd/system/
		sudo chmod 622 /etc/systemd/system/"${unit_file##*/}"
		echo -e "\tunit file ${unit_file##*/} copied"
		sudo ls -lah /etc/systemd/system/"${unit_file##*/}"

	else
		echo -e "user choice: ${continue_key}\nExiting..."
		exit 0
	fi
else
	echo -e "ERROR:\nno unit file with the name $1 found in $HOME!"
fi

###############################################
# we could, of course do a lot of
# checking of the file is indeed a unit file
# todo: HOW?
###############################################

# - add a enabler / starter
add_to_systemd() {
	sudo systemctl enable "${unit_file##*/}" || systemctl status "${unit_file##*/}"
	sudo systemctl start "${unit_file##*/}" || systemctl status "${unit_file##*/}"
	sudo systemctl daemon-reload
}
add_to_systemd

exit 0
