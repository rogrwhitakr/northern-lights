#! /usr/bin/env bash

# vars
network_file=network.northern-lights.one

# we trap the removal of the created file
trap "rm -f ${network_file}" EXIT

sudo nmap 192.168.0.0/24 -oN "${network_file}" -sn > /dev/null 2>&1

# delete lines that have "host is up" 
sed -i '/Host is up/d' "${network_file}"

cat "${network_file}"