#! /usr/bin/env bash

readonly RED='\033[0;31m'
readonly YELLOW='\e[33m'
readonly GREEN='\e[0;32m'
readonly NOC='\033[0m'

remote_user="admin"
vm="IAV.Cortez"
service=false
connect=false

echo -e "${RED}Checking virtual machine availability. VM: ${vm}${NOC}"
# query virt machine service status
systemctl status virtual-machines.service 2>&1 >/dev/null
[[ "$?" == "0" ]] && service=true

ping -c1 ${vm} 2>&1 >/dev/null
[[ "$?" == "0" ]] && connect=true

if [[ ${service} == true ]] && [[ ${connect} == true ]]; then
	# copy bulk / whole directories
	echo -e "${GREEN}virtual machine $vm available. starting copy-job...${NOC}"
	scp -r ~/MyScripts ${remote_user}@${vm}:~/ 2>/dev/null
	echo -e "${GREEN}copy complete${NOC}"
fi
