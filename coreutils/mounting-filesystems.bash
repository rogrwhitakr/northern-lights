###############################################################################
# mount
# mount is somewhat legacy. man page says: use findmnt, especially for scripts!
###############################################################################

# these two mount the windows shares
sudo mount -t cifs -o user=JohnReese,password=***,domain=WORKGROUP //192.168.0.6/Musik /home/admin/Musik
sudo mount -t cifs -o user=JohnReese,password=***,domain=WORKGROUP //192.168.0.6/E$ /home/admin/Videos

# backup thingy
sudo mount -t cifs -o user=JohnReese,password=***,domain=WORKGROUP //192.168.0.6/Netzlaufwerk/Sicherung/SERENITY /home/admin/backup

# get the mounts systemd-fstab-generator creates at/for runtime
systemctl --type mount

# mount a sftp over ssh session
sudo sshfs -o allow_other jaynecobb@cortez:/home/jaynecobb/ /mnt/backup/remotes

# using a ssh-key
sudo sshfs -o allow_other,IdentityFile=~/.ssh/"${ident_file}"

# check the mount points
df -hT

# add to fstab
sshfs#jaynecobb@cortez:/home/jaynecobb/ /mnt/backup/remotes fuse.sshfs defaults 0 0
# this will probably create a runtime unit file that cannot resolve, 
# as the target is a virtual machine on the same machine, its host.... how to delay?

# unmounting:
sudo umount /mnt/backup/remotes

# TODOS:
# -> how to mount cifs as root with a non-privileged scope, i.e. do file writes as a regular user
# -> reading the file works okay

# what is the way forward? fstab or systemd unit files?
# in case of systemd: things to consider:
#   1.  name convention:
#       resolve path to mount point using a systemd-specific tool:
systemd-escape --suffix=mount --path /home/admin/MyScripts/apps/ansible

#   2.  unit file syntax:
#       example rendered from fstab entry

[Unit]
SourcePath=/etc/fstab
Documentation=man:fstab(5) man:systemd-fstab-generator(8)
Before=local-fs.target
Requires=systemd-fsck@dev-sdb2.service
After=systemd-fsck@dev-sdb2.service

[Mount]
Where=/mnt/backup
What=/dev/sdb2
Type=ext4

# other example:
[Mount]
What=10.10.10.10:/nfs-share
Where=/mnt/nfs
Type=nfs4
