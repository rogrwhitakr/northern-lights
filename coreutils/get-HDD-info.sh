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
echo -e '\n'"${RED}du (disk usage)${NOC}" '\n\n'"printing 20 biggest files on the system, directory $BASE"'\n'"command:"'\n'"${RED}du -a ${BASE} 2>/dev/null | sort -nr | head -20"${NOC}

du -a ${BASE} 2>/dev/null | sort -nr | head -20

echo -e "'\n'${RED}lvdisplay/pvdisplay/fdisk ${NOC}'\n'"
lvdisplay && pvdisplay && fdisk -l