#! /usr/bin/env bash

rootcheck() {
	if [ "$(id -u)" != "0" ]; then
		echo "This script must be run as root" 1>&2
		exit 1
	fi
}

rootcheck

truncate -s 0 /home/finch/repos/northern-lights/apps/virtualisation/libvirt/vms

# get a list of vms
# RS="\n\n";FS="\n";ORS=",";

virsh list --all | awk 'NR>1 && NF>1 { print $2 }' | while read -r vm ; do
    echo "$vm"
    virsh dominfo "${vm}"
    virsh dominfo "${vm}" | awk -v RS= -v OFS=, '{print $2,$4,$13,$15,$16}' >> /home/finch/repos/northern-lights/apps/virtualisation/libvirt/vms
    virsh dominfo "${vm}" | awk 'BEGIN {RS="\n\n"} {print $2,$4,$14,$16}' >> /home/finch/repos/northern-lights/apps/virtualisation/libvirt/vms
    echo "---"
done

column -s, -t /home/finch/repos/northern-lights/apps/virtualisation/libvirt/vms