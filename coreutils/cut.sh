#! /bin/sh

#ping -i 2 google.de | cut -d= -f4 
#ping -i 2 google.de | cut -d= -f1

sudo cut -dT -f1 /var/log/dnf.log
sudo cut -dT -f1 /var/log/dnf.log | grep -E '[0-9]{4}\-[0-9]{2}\-[0-9]{2}'

