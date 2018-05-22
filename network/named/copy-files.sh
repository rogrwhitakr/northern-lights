#! /bin/sh
echo "Copying files ..."
sudo cp -v named.conf /etc/named.conf
sudo cp -v * /var/named

echo  "Removing not needed files"
sudo rm -v /var/named/copy-files.sh
sudo rm -v /var/named/named.conf
sudo rm -v /var/named/named.service
sudo rm -v /var/named/named.sh

read

sudo systemctl daemon-reload
systemctl status named.service
