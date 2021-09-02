#! /usr/bin/env bash

# add user to sublemental group like libvirt / kvm / qemu
sudo usermod -a -G libvirt admin

# get the name of the user
getent passwd "$(id -un)" | cut -d ':' -f 5