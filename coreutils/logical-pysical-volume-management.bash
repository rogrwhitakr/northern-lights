#! /usr/bin/env bash

# Display information about volume groups
lvs

# get pysical volume groups
vgs

# get the layout
# depricated: lvmdiskscan
pvs --all

# VARIABLES
#   PV  - Pysical volume
#   VG  - Volume Group name.  See lvm(8) for valid names.
#   LV  - Logical Volume name.  See lvm(8) for valid names.  An LV positional arg generally includes the VG name and LV name, e.g. VG/LV.

# get the partitions / device names available, that the os has detected?
# is there a command for this? or is this the command to use
cat /proc/partitions

# Initialize physical volume(s) for use by LVM
# create a pysical volume (aka register the partition ???)
lvm pvcreate /dev/vdb
lvm pvcreate [device]

# create a volume group. you must specify a PV (pysical colume) for this
lvm vgcreate browncoats /dev/vdc 

# register to a new VG
lvm vgcreate alliance /dev/vdc /dev/vdd
lvm vgcreate browncoats /dev/vde /dev/vdf

# register with existing VG
lvm vgextend fedora_iavalexander /dev/vdb

# do a check with lvs / pvs, etc 
# display device types
lvm devtypes

# display information
lvm pvdisplay
lvm vgdisplay

# rename a volume group
lvm vgrename [old] [new]
lvm vgrename fedora_iavalexander alliance

# after issue tried again, with this
lvm vgrename fedora_iavalexander alliance --autobackup y -dddddd -vvvv
# man page suggests to ALWAYS autobackup, output shown at maximum debug / verbosity level
 
# create a demo file of given size in tree
fallocate -l 250M /tmp/test.img

# issue: after renaming the root VG, the box does not start any more
# trying:
# edit /etc/fstab
sed --in-place 's/fedora_iavalexander/alliance/g' /etc/fstab 
# edit grub.conf
sed --in-place 's/fedora_iavalexander/alliance/g' /etc/fstab /etc/default/grub 
# there are multiple grub files avaliable, unsure if correct one.
# i know i need to rebuild the config, searching for command...
find / -name *grub* -executable

#   remove references to old vgname
# create new LV (logical volume) using the new VG 
lvm lvcreate --size 9G browncoats

#############################################
# remove a PV from a VG
lvm vgreduce alliance /dev/vdd

# i purposefully referenced the wrong PV, this simply returns, no change
lvm vgreduce browncoats /dev/vdc

# splitting a VG
lvm vgsplit alliance independents /dev/vdc

# merge it again
lvm vgmerge alliance independents

# create a LV smaller then the VG
lvm lvcreate --size 7G browncoats  --type linear