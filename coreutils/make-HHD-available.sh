#! /bin/sh

####################################################################
# How to setup a hard disk on fedora
####################################################################

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


ls /dev/sd*

mount

sudo cat /etc/fstab 

ls /dev/sd*

sudo cat /etc/fstab 
