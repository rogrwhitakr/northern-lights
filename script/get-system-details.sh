#! /usr/bin/env bash

####################################################################
# get system details
####################################################################

# source helpers

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__dir="$(cd "$(dirname "${__dir}")" && pwd)"

source "${__dir}/script/helpers/init.bash"
print RED "${_dir}"

# this function could be greatly expanded to use other checks also
# https://www.ostechnix.com/check-linux-system-32-bit-64-bit/

is64bit() {

	if [[ "$(uname -m)" == "x86_64" ]]; then

		echo "64 bit system"
		return true
	else
		return false
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

user=$(id -un)

print RED "$0 - HOW-TO"
print GREEN "check if:\nsystem is running 32bit or 64bit Linux,\nis virtualised,\n....to-be-continued"
print LINE

### 32/64 bit ###
print "Architecture:"
is64bit
print YELLOW "COMMAND: lscpu"
lscpu
print YELLOW "COMMAND: echo \$HOSTTYPE "
echo $HOSTTYPE

### hypervisor ###
print LINE
print YELLOW "Check if running virtualised"

if [[ isVirtualised == 1 ]]; then

	print "this machine is virtualised"
	print YELLOW "COMMAND: dmesg | grep "Hypervisor detected""
else

	print "this machine is running on bare hardware"
	print YELLOW "COMMAND: dmesg | grep "Booting paravirtualized kernel on bare hardware""
fi

print YELLOW "COMMAND: hostnamectl "
hostnamectl
hostnamectl | grep "Chassis"
hostnamectl | grep "Virtualization"

print YELLOW "COMMAND: systemd-detect-virt "
systemd-detect-virt
