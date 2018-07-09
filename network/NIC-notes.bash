#! /usr/bin/env bash

# iw 
#   iw - show / manipulate wireless devices and their configuration
#   this seems to be a powerful tool

# list devices
iw list
# -> this does not show the interface name, like enp0s3, wlp4s0 or eth1 

# get the ssid of current network
iw dev wlp4s0 info | grep ssid

# go to 
/sys/class/net

# prints all of a interface
# -s flag omits directory error
grep -s "" /sys/class/net/enp3s0/*