#! /bin/sh

####################################################################
# manage virtual machine
####################################################################

#################
### functions ###
#################

printline() {

	echo -e '\n'
	echo [------------------------------------------]
	echo -e '\n'

}

#################
### variables ###
#################

NOC='\033[0m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'

user=$(id -un) 

#################
### execution ###
#################

echo -e "${RED}$0 - HOW-TO${NOC}"
echo -e "${GREEN}run a virtual machine using libvirt${NOC}"

printline
sudo virsh list --all
printline

sudo ls -l /etc/libvirt/qemu

#sudo cat /etc/libvirt/qemu/server-demo.xml