# nmcli (NetworkManagerCli -> sysconfig stuff is depricated)

# gives you the name
nmcli con show 

# set a static ip
nmcli con mod "ens18"
  ipv4.addresses "192.168.178.25/24"
  ipv4.gateway "192.168.178.1"
  ipv4.dns "192.168.178.10"
  ipv4.dns-search "fritz.box"
  ipv4.method "manual"
  ipv6.method "disabled"

nmcli con mod "ens18"  ipv4.addresses "192.168.178.25/24"  ipv4.gateway "192.168.178.1"  ipv4.dns "192.168.178.10"  ipv4.dns-search "fritz.box"  ipv4.method "manual" ipv6.method "disabled"

