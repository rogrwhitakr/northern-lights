#! /usr/bin/env bash

source ../../scripts/helpers/init.bash

user=$(id -un) 

print RED "$0 tests firefall settings"
print GREEN "checking firewall status on $(cat /etc/hostname)"

sudo systemctl status firewalld

print RED "Zones"
firewall-cmd --get-active-zones
print RED "Services"
firewall-cmd --get-services

firewall-cmd --zone=public --list-all