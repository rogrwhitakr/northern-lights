# how to make a system boot from a new kernel / reinstall kernel / grub2 actions

## problem
- F43 installed, running kernel from f39
- reinstall did not change the boot 

## solution ATM


```sh
# edit kernel boot install options file
nano /etc/kernel/install.conf

# set
layout=bls

# remove newer definitions and binaries that are ignored
cd /boot/efi/
rm -fr 68a267485fdb4829bd05997a0b70fddd/
<machine-id>

# reinstall the newest kernel
dnf reinstall kernel-core-7.0.12-101.fc43.x86_64

# grub config erneuern
grub2-mkconfig -o /etc/grub2-efi.cfg

# view and remove any boot-into-kernel preferences
grub2-editenv list
grub2-editenv - set saved_entry=0
```

