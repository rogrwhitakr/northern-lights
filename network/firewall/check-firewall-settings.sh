#! /bin/sh

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

echo -e "${RED}$0 tests firefall settings${NOC}"
echo -e "${GREEN}checking firewall status on $(cat /etc/hostname)${NOC}"

sudo systemctl status firewalld

echo -e "${RED}Zones${NOC}"
firewall-cmd --get-active-zones
echo -e "${RED}Services${NOC}"
firewall-cmd --get-services

firewall-cmd --zone=public --list-all