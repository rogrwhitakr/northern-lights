#! /usr/bin/env bash

# The nmcli (NetworkManager Command Line Interface) command-line utility is used for controlling NetworkManager and reporting network status. 
# nmcli is used to create, display, edit, delete, activate, and deactivate network connections, as well as control and display network device status.

# list what is there
nmcli

# list active connections
nmcli connection show

# add bridge
nmcli connection add type bridge ifname br0 stp no
nmcli connection add type bridge ifname br0 con-name stp no

# Making interface LAN a slave to the bridge:
nmcli connection add type bridge-slave ifname <ifname lan> master br0
nmcli connection add type bridge-slave ifname enp3s0 master br0

# nmcli from networkmanager can create bridges. 
# Creating a bridge with STP disabled (to avoid the bridge being advertised on the network):

nmcli connection add type bridge ifname br0 stp no

# Making interface enp30s0 a slave to the bridge:
nmcli connection add type bridge-slave ifname enp30s0 master br0

# Setting the existing connection as down:
nmcli connection down <connection-UUID>

# Setting the new bridge as up:
nmcli connection up bridge-br0