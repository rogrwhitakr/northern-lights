# how to use (client) a webdav server

# install the filesystem
dnf install davfs2

# mount the filesystem
sudo mount -t davfs https://<url> /mnt

# mount a nextcloud instance directory
davs://storage.northern-lights.one/nextcloud/remote.php/dav/files/USER/

# dolphin
webdav://example.com/nextcloud/remote.php/dav/files/USERNAME/

# nautilus
davs://example.com/nextcloud/remote.php/dav/files/USERNAME/