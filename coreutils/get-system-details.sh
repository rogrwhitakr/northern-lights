#! /bin/sh

####################################################################
# get system details
####################################################################

#################
### functions ###
#################

printline() {

	echo -e '\n'
	echo [------------------------------------------]
	echo -e '\n'

}

# this function could be greatly expanded to use other checks also
# https://www.ostechnix.com/check-linux-system-32-bit-64-bit/

is64bit() {

	if [[ "$(uname -m)" = "x86_64" ]]; then

		echo "64 bit system"

	else 

		echo "32 bit system"
	fi
}

# this function one also
HYPERVISOR=0

isVirtualised() {

	if [[ $(dmesg | grep "Booting paravirtualized kernel on bare hardware") ]]; then
		HYPERVISOR=0
	fi
	
	if [[ $(dmesg | grep "Hypervisor detected") ]]; then
		HYPERVISOR=1
	fi		
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
echo -e "${GREEN}check if:\nsystem is running 32bit or 64bit Linux,\nis virtualised,\n....to-be-continued${NOC}"

### 32/64 bit ###
echo -e "${NOC}Architecture:${NOC}"
is64bit
echo -e "${YELLOW}COMMAND: lscpu${NOC}"
lscpu
echo -e "${YELLOW}COMMAND: echo \$HOSTTYPE ${NOC}"
echo $HOSTTYPE

### hypervisor ###
echo -e "${YELLOW}Check if running virtualised${NOC}"

if [[ isVirtualised = 1 ]]; then

	echo -e "${NOC}this machine is virtualised${NOC}"
	echo -e "${YELLOW}COMMAND: dmesg | grep "Hypervisor detected"${NOC}"
else

	echo -e "${NOC}this machine is running on bare hardware${NOC}"
	echo -e "${YELLOW}COMMAND: dmesg | grep "Booting paravirtualized kernel on bare hardware"${NOC}"
fi

echo -e "${YELLOW}COMMAND: hostnamectl ${NOC}"
hostnamectl
hostnamectl | grep "Chassis"

echo -e "${YELLOW}COMMAND: systemd-detect-virt ${NOC}"
systemd-detect-virt