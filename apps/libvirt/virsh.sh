#! /bin/sh

# manage virtual machine with virsh
which virsh

# execute as sudo because otherwise you cannot see the info

# list all machines
sudo virsh list --all

# lists available networks
sudo virsh net-list --all

# dump xml of machine, network
sudo virsh dumpxml dnsmasq > ~/libvirt/dnsmasq.xml
sudo virsh net-dumpxml default > ~/libvirt/network_default.xml

# edit machine, network
# needs to be specified, but defaults to vim
$EDITOR=/usr/bin/nano sudo virsh net-edit default

# from an xml dump -> edited xml (worked)
# installed uuid to add to xml, seems to be ok (for now)
sudo virsh net-create /home/admin/libvirt/network_miranda.xml

# paths libvirt lives in
sudo ls -l /etc/libvirt/qemu
sudo tree /etc/libvirt

sudo subl /etc/libvirt/qemu/*.xml
sudo subl /etc/libvirt/qemu/networks/*.xml
sudo subl /etc/libvirt/libvirt.conf
sudo subl /etc/libvirt/qemu.conf