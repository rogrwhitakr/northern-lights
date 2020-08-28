# how to use (client) a webdav server

# install the filesystem
dnf install davfs2

# mount the filesystem
sudo mount -t davfs https://<url> /mnt