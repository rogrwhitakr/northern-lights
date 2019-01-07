# mount
# mount is somewhat legacy. man page says: use findmnt, especially for scripts!

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
