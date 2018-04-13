#!/bin/sh -

# check all things regarding disk size

RED='\033[0;31m'
NOC='\033[0m' 	# No Color

BASE=$(basename /)

#check user

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

clear

echo -e '\n'"${RED}df (disk free)${NOC}" '\n' 
df

echo -e '\n'"${RED}du (disk usage)${NOC}" '\n\n'"printing 20 biggest files on the system, directory $BASE"
echo -e "\n${RED}du -a ${BASE} 2>/dev/null | sort -nr | head -20${NOC}"
du -a ${BASE} 2>/dev/null | sort -nr | head -20

echo -e "'\n'${RED}lvdisplay/pvdisplay/fdisk ${NOC}'\n'"
lvdisplay && pvdisplay && fdisk -l

echo -e "\n${RED}list the contents of /dev/disk ${NOC}\n"
echo -e "\n${NOC}displayed are disks by identifier:
\tby-id
\tby-label
\tby-partlabel
\tby-partuuid
\tby-path
\tby-uuid
${NOC}\n"
ls -l /dev/disk

echo -e "\n${RED}uuids of hard disks${NOC}\n"
ls -l /dev/disk/by-uuid/ | awk -F' ' '{ print $10,$9,$10,$11 }' 
