# debian / older ubuntu

```ini
# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto enp0s3
iface enp0s3 inet static
    address 192.168.150.230
    subnet  255.255.255.0
    gateway 192.168.150.1
	dns-servers 192.168.150.254 83.169.184.161 83.169.184.225 8.8.8.8 8.8.4.4
```

## how-to
### route out from vlan


auto ens192
iface ens192 inet static
    address 192.168.102.13
    subnet  255.255.255.0
    gateway 192.168.102.1
	dns-servers 192.168.102.254 83.169.184.161 83.169.184.225 8.8.8.8 8.8.4.4


## create VLAN link (temporary?)

```sh
ip link add ens192.100 link ens192 type vlan id 100
ip link set ens192.100 up
```