#! /usr/bin/env bash

# Display information about volume groups
lvs

# get pysical volume groups
vgs

# get the partitions available, that the os has detected?
cat /proc/partitions

# get the layout
# depricated: lvmdiskscan
pvs --all

# Initialize physical volume(s) for use by LVM
pvcreate

# i checked /proc/partitions for a name  
cat /proc/partitions
# is there a command for this? or is this the command to use

# create a pysical volume (aka register the partition ???)
pvcreate /dev/vdb

# VARIABLES
#   PV  - Pysical volume
#   VG  - Volume Group name.  See lvm(8) for valid names.
#   LV  - Logical Volume name.  See lvm(8) for valid names.  An LV positional arg generally includes the VG name and LV name, e.g. VG/LV.

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
 
# create a volume group. you must specify a PV (pysical colume) for this
lvm vgcreate browncoats /dev/vdc 

# create a demo file of given size in tree
fallocate -l 250M /tmp/test.img

# next: try pvcreate !!!!

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