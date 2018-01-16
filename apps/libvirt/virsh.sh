#! /bin/sh

# manage virtual machine with virsh
which virsh

# execute as sudo because otherwise you cannot see the info

# get help
sudo virsh help domain
sudo virsh help network
sudo virsh help interface

# list all machines
sudo virsh list --all

# lists available networks
sudo virsh net-list --all

# list available interfaces
sudo virsh iface-list --all

# dump xml of machine, network, interfaces

sudo virsh dumpxml dnsmasq > ~/libvirt/dnsmasq.xml
sudo virsh net-dumpxml default > ~/libvirt/network_default.xml

# edit machine, network
# needs to be specified, but defaults to vim
EDITOR=/usr/bin/nano sudo virsh net-edit default

# from an xml dump -> edited xml (worked)
# installed uuid to add to xml, seems to be ok (for now)
sudo virsh net-create /home/admin/libvirt/network_miranda.xml

# renaming a domain
sudo virsh domrename Windows-server IAV.Dortmunder

# paths libvirt lives in
sudo tree /etc/libvirt