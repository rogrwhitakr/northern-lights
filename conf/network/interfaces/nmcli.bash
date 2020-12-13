#! /usr/bin/env bash

# The nmcli (NetworkManager Command Line Interface) command-line utility is used for controlling NetworkManager and reporting network status. 
# nmcli is used to create, display, edit, delete, activate, and deactivate network connections, as well as control and display network device status.

# list what is there
nmcli

# list active connections
nmcli connection show