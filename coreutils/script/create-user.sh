# /usr/bin/env bash

####################################################
#variables

NOC='\033[0m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'

DATE=`date +%Y-%m-%d`
DISABLE_DATE=`date -d '-6 months ago' +%Y-%m-%d`

####################################################
# functions

display_help(){

local RED='\e[1;31m'  
local YELLOW='\e[33m'
local NOC='\033[0m'
local BLUE='\e[34m'

if ([[ "$1" = "-h" ]] || [[ "$1" = "--help" ]]); then
    echo -e "${RED}USAGE:$0${NOC}"
    echo -e "\tcreate a new user and his / her home directory"
    echo -e "\tassign some shit"
    echo -e "\tuser must renew password after 6 months"
    echo -e "${RED}PREREQUISITES${NOC}"
    echo -e "\tuser does not yet exist"
    exit 0

elif ([[ "$1" = "-p" ]] || [[ "$1" = "--pid" ]]); then
    echo -e "$BASHPID"
fi
}
display_help $1

rootcheck(){
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
}

userExists(){
if [ id "$1" >/dev/null 2>&1 ]; then
	echo "user "${login_user}" already exists"
	return 1
fi
}

more_user_exists(){
	# we fetch all user names into array
	local user=( $( getent passwd | cut -d: -f 1 ) )
	echo "the system has ${#user[@]} users. Checking new user against this set"
	echo "$1"
	for (( i=0; i<${#user[@]}; i++ )); do
		echo "checking user ${user[$i]}"
		if [[ "${1}" == "${user[$i]}" ]];then
			echo "if-somesin"
			return 0
		else
			echo "else-somesin"
			return 1
		fi
	done
}


####################################################
# execution


clear

echo -e "$DISABLE_DATE ${YELLOW} $DISABLE_DATE ${GREEN} $DISABLE_DATE ${NOC}"

echo -e "this script creates a new user and home directory. \nalso, permissions and groups.\n${RED}usage: FIRST_NAME LAST_NAME${NOC}"

read -p "enter new user name: " FIRST_NAME LAST_NAME

if [ -z $LAST_NAME ]; then
	LOGIN_USER="default_"$FIRST_NAME
else
	LOGIN_USER=$LAST_NAME
fi

echo -e "the new user is $LAST_NAME, $FIRST_NAME.\nThe user-ID will be "${login_user}""

more_user_exists "${LOGIN_USER}"

exit 0
# TODO input validation and such
#sed -er '[A-Z]' $FIRST_NAME
#sed -er '' $FIRST_NAME

if [[ userExists != 1 ]]; then
#	echo -e "Add a validity time frame for the User-ID \nSelect the time period (in months), in which the User-ID will be valid.\n${RED}usage: FLAG TIME_PERIOD (in months, e.g. 6) ${NOC}"
#	read -p $'enter flag (Y/N) and time period (6): ' -ei $'Y' FLAG TIME_PERIOD
	
	read -rp "set PASSWORD_EXPIRY (in days): " -ei $'360' -N3 PASSWORD_EXPIRY
	if [[ $PASSWORD_EXPIRY == "360" ]]; then
		echo -e "${YELLOW}$PASSWORD_EXPIRY${NOC}"
		read -rp "set FLAG: " -ei $'Y' FLAG
		if [[ $FLAG = "Y" ]]; then
			echo -e "${YELLOW}$FLAG${NOC}"
			read -rp "set DISABLE_DATE: " -ei $"6" DISABLE_DATE
			if [[ $DISABLE_DATE =~ ^-?[0-9]+$ ]]; then
				_DATE=`date -d '-`$DISABLE_DATE months ago' +%Y-%m-%d`
				echo -e "${YELLOW}$DISABLE_DATE${NOC}\n command: useradd -e $_DATE -f $PASSWORD_EXPIRY "${login_user}""
			else
				echo -e "${RED}$DISABLE_DATE${NOC}\n no valid input given"
			fi
		else
			echo -e "${RED} no flag set $FLAG${NOC}\n command: useradd -f $PASSWORD_EXPIRY "${login_user}""
		fi
	else
		echo -e "${RED}Maaa $PASSWORD_EXPIRY${NOC}\n command: useradd "${login_user}""
	fi

exit 0	
	
	read -p "" -ei $'Y' FLAG TIME_PERIOD
	if ([[$FLAG -eq "Y" && $TIME_PERIOD ==~ ^-?[0-9]+$ ]]); then
		sudo useradd -e $DISABLE_DATE -f $PASSWORD_EXPIRY "${login_user}"
		sudo useradd -e $DISABLE_DATE "${login_user}"
	else
		sudo useradd -e "${login_user}"
	fi
	echo -e "need something?"
	sudo passwd "${login_user}"
	cd /
	mkdir /home/"${login_user}"
	chown "${LOGIN_USER}"."${LOGIN_USER}" /home/"${login_user}"

else
	exit 1
fi

exit 0
	
getent group

#TODO spinner for group

echo -e "
specify groups this user belongs to.
${RED}usage: GROUP_ONE GROUP_ONE GROUP_N${NOC}, space acts as a delimiter
"

read -p "enter new user name: " GROUP_ONE GROUP_ONE

sudo usermod -a -G groupName "${login_user}"