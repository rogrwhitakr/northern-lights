
#! /bin/bash

# edit grub boot loader
sudo nano /etc/default/grub

# contains
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="rd.lvm.lv=fedora_hankscorpio/root rd.lvm.lv=fedora_hankscorpio/swap rhgb quiet video=hyperv_fb:1920x1080"
GRUB_DISABLE_RECOVERY="true"

# edit GRUB_CMDLINE_LINUX
# to contain 
# video=hyperv_fb:1920x1080
# HyperV CANNOT display any higher, limitation within hypervisor

# update the config to be written somewhere
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# reboot will display the video=hyperv_fb:1920x1080 line