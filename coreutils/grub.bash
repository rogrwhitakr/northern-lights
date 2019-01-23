# grub config file is in
/etc/default/grub

# values one can have:
GRUB_TIMEOUT=15
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="rd.lvm.lv=fedora_iavalexander/root rd.lvm.lv=fedora_iavalexander/swap rhgb quiet"
GRUB_DISABLE_RECOVERY="true"

# image can be added, must be png
GRUB_BACKGROUND="/boot/grub2/FireIce.png"
# UNCOMMENT the GRUB_TERMINAL_OUTPUT line !!!

# ->  GRUB_DEFAULT references the file GRUBENV,
#     that defines to load the newest kernel on startup
#     find puts it here:
/boot/grub2/grubenv

# get all menu entries (they are in the grub2 config file)
awk -F\' '$1=="menuentry " {print $2}' /etc/grub2.cfg

# changes may be written to the grub definition using grub2-mkconfig
# using /etc/grub2.conf
# which is a symlink to the "real" file (differences if UEFI or BIOS)
ls -lah /etc/grub2.cfg -> ../boot/grub2/grub.cfg

# meaning, changes need to be written to the right config file
grub2-mkconfig -o /boot/grub2/grub.cfg

# somehow, the renamed vg is not referenced. something grub2-probe canonical error...
# so updating fstab & default/grub is easy, making config fails.

# another try: generate new ini?
# path is output of df 
grub2-install /dev/vda1
