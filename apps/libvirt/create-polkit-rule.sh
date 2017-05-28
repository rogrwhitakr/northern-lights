#! /bin/sh

####################################################################
# create polkit rule
####################################################################

#################
### functions ###
#################

printline() {

	echo [------------------------------------------]

}

#################
### variables ###
#################

NOC='\033[0m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'

user=$(id -un) 
rules_file=/etc/polkit-1/rules.d/80-libvirt.rules

#################
### execution ###
#################

echo -e "${RED}$0 - libvirt${NOC}"
printline

if [ ! -f $rules_file ]; then
	sudo touch $rules_file

	sudo tee $rules_file > /dev/null <<EOF
polkit.addRule(function(action, subject) {
  if (action.id == "org.libvirt.unix.manage" && subject.local && subject.active && subject.isInGroup("wheel")) {
      return polkit.Result.YES;
  }
});
EOF
	sudo chmod 644 $rules_file
	echo -e "${GREEN}created file $rules_file${NOC}"
	printline
	exit 0
else 
	echo -e "${GREEN}$rules_file already exists:${NOC}"
	sudo cat $rules_file
	printline
	exit 0
fi