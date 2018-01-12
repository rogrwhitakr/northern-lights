
# add repository
echo "deb http://download.proxmox.com/debian jessie pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list

# add key
wget -O- "http://download.proxmox.com/debian/key.asc" | apt-key add -

# refresh installation
apt-get update && apt-get dist-upgrade

# install PROXMOX
apt-get install proxmox-ve ntp ssh postfix ksm-control-daemon open-iscsi systemd-sysv