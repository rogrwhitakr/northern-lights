# mount
# mount is somewhat legacy. man page says: use findmnt, especially for scripts!

# these two mount the windows shares
sudo mount -t cifs -o user=JohnReese,password=***,domain=WORKGROUP //192.168.0.6/Musik /home/admin/Musik
sudo mount -t cifs -o user=JohnReese,password=***,domain=WORKGROUP //192.168.0.6/E$ /home/admin/Videos
