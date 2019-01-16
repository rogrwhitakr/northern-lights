#! /usr/bin/env bash

# Display information about volume groups
lvs

# get pysical volume groups
vgs

# get the partitions available, that the os has detected?
cat /proc/partitions

# get the pysical ... groups ???
pvs

# Initialize physical volume(s) for use by LVM
pvcreate