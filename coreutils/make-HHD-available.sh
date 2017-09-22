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

echo -e "${RED}$0 - HOW-TO${NOC}"
echo -e "${GREEN}add a hard disk,\nformat,\ncreate file system,\ncreate logical partitions${NOC}"


echo -e "${YELLOW}Listing contents of ${RED}/dev/sd*${NOC}"
ls /dev/sd*

echo -e "${YELLOW}mounts${NOC}"
echo -e "${RED}command:\nmount -no args\ndisplays all mounted drives${NOC}"
mount

echo -e "${YELLOW}Listing contents of ${RED}/etc/fstab${NOC}"
sudo cat /etc/fstab 

# get blockid of device
sudo blkid
