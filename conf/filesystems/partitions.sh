# deleting all on disk
shred -n 5 -vz /dev/sdb

# First, check where there is the unallocated space on your disk.
sudo parted /dev/sda unit s print free
sudo parted [device] print all

# Then, run fdisk in interactive mode.
sudo fdisk /dev/sda

# enter
n
Partition number (4-128, default 4): 4
First sector (209715201-976773134, default 209717248): 209715201
Last sector, +/-sectors or +/-size{K,M,G,T,P} (209715201-976773134, default 976773119): 976773134
# -> Created a new partition 4 of type 'Linux filesystem' and of size 365.8 GiB.
Command (m for help): w
# The partition table has been altered.
# Syncing disks.

# then create a pv from the partition, for example 
lvm pvcreate /dev/sda4

# add this to the volume group
lvm vgextend VM /dev/sda4

# then create a logical volume
lvm lvcreate -n virtual-machines -l100%FREE VM

# you can the see the thingy in the UI