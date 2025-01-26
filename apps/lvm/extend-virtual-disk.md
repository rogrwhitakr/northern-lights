# extend virt disk

https://www.tech-island.com/kb/linux/lvm-physical-volume-vergoessern

1. after adding hdd space via hypervisor, you can view the unallocated space in lvm

```
df -h
pvdisplay
```

2. see hat is in use

```
lvdisplay
```

3. extend the logical volume to use all of the space
    take the lv name from the lv command obvi...

```
lvm lvextend -l +100%FREE --resizefs /dev/fedora/root
```
