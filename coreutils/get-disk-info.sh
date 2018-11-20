#!/usr/bin/env bash

# check all things regarding disk size
source /home/admin/MyScripts/script/helpers/init.bash

BASE=$(basename /)

get_directory_file_usage(){

	# DESC: returns sorted list of files based upon size
	# ARGS: directory, defaults to /
    #       amount of items to be returned, defaults to "10"
	# OUTS: list 

    _base="${1}"
    _output="${2}"
    print YELLOW "getting the ${_output:-10} largest files in directory ${_base:-"/"}"
    du -a "${_base:-"/"}" 2>/dev/null | sort -nr | head -"${_output:-10}"
}
dir="/home/admin"
get_directory_file_usage "${dir}" 35
get_directory_file_usage 
get_directory_file_usage /var

#check user

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


print RED "df (disk free), and file system type (-T flag)" 
df -hT

print RED "du (disk usage)"
print "printing 20 biggest files on the system, directory $BASE"

du -a ${BASE} 2>/dev/null | sort -nr | head -20

print RED "lvdisplay/pvdisplay/fdisk "
lvdisplay && pvdisplay && fdisk -l

print RED "list the contents of /dev/disk "
print "displayed are disks by identifier:
\tby-id
\tby-label
\tby-partlabel
\tby-partuuid
\tby-path
\tby-uuid
"
ls -l /dev/disk

print RED "uuids of hard disks"
ls -l /dev/disk/by-uuid/ | awk -F' ' '{ print $10,$9,$10,$11 }' 

print RED "sudo blkid /dev/<device> also works"
print YELLOW "command: sudo blkid /dev/sdb1"
sudo blkid /dev/sdb1
