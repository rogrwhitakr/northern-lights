#! /usr/bin/env bash

####################################################################
# How to setup a hard disk 
####################################################################

# return partition table
cat /proc/partitions

# alternatively list the directory contents of /dev
ls /dev/sd*

# command: mount without args displays all mounted drives
mount

# see what drives the init system loads on startup
cat /etc/fstab

# get blockid of device
sudo blkid

# add line to fstab 
# example ATM:
# UUID=021ac4d0-dc15-43f8-a3a3-6a87202533af /var/lib/libvirt	ext4	defaults	1	2

# test if the entry is valid: (root)
mount --all
mount -a

