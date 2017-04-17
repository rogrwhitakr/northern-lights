# bin/sh

cd ~/

mkdir MyScripts

cd MyScripts
read 
servicename=update-linux

touch /etc/systemd/system/$servicename.service
chmod 664 /etc/systemd/system/$servicename.service

cd /etc/systemd/system/

systemctl daemon-reload
systemctl start $servicename.service