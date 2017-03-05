# bin/sh
#variables

RED='\033[0;31m'
NOC='\033[0m' 
DATE=`date +%Y-%m-%d`
DISABLE_DATE=`date -d '-6 months ago' +%Y-%m-%d`

# functions

rootcheck(){
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
}

usercheck(){
if [ id "$1" >/dev/null 2>&1 ]; then
	echo "user $LOGIN_USER already exists"
	return 1
fi
}

# execution

rootcheck

clear

echo -e "
this script removes a user and home directory.
also, permissions and groups.
${RED}usage: FIRST_NAME LAST_NAME${NOC}, space acts as a delimiter
"

read -p "enter user to be removed: " FIRST_NAME LAST_NAME

LOGIN_USER=$LAST_NAME

echo -e "
the user is $LAST_NAME, $FIRST_NAME.
the user-ID is ${RED}TODO first letter $FIRST_NAME${NOC}$LAST_NAME
"
# TODO validation and such
#sed -er '[A-Z]' $FIRST_NAME
#sed -er '' $FIRST_NAME

sleep 5

if [[ usercheck != 1 ]]; then
	echo -e "
	creating user ..."
	sudo useradd -e $DISABLE_DATE $LOGIN_USER
	echo -e "
	needs something?"
	sudo passwd $LOGIN_USER
	cd /
	mkdir /home/$LOGIN_USER

else
	exit 1
fi
	
getent group

#TODO spinner for group

echo -e "
specify groups this user belongs to.
${RED}usage: GROUP_ONE GROUP_ONE GROUP_N${NOC}, space acts as a delimiter
"

read -p "enter new user name: " GROUP_ONE GROUP_ONE

sudo usermod -a -G groupName $LOGIN_USER