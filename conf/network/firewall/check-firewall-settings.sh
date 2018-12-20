#conf

# get the service status
sudo systemctl status firewalld

# get active Zones
firewall-cmd --get-active-zones

# get services
firewall-cmd --get-services

# get zone that are/ is active
sudo firewall-cmd --get-active-zones

# get available zones
sudo firewall-cmd --permanent --get-zones

# list everything of a zone (here: Public)
firewall-cmd --zone=public --list-all

# get ports
firewall-cmd --zone=FedoraWorkstation --permanent --list-ports

# add a port to a zone (postgres here)
firewall-cmd --zone=FedoraWorkstation --permanent --add-port 5432/tcp