#! /usr/bin/env sh

echo "this script is used to
->  set up BORG backup script 
->  set up systemd unit files (service and timer)
using files found in this directory"

ls *.sh
ls *.timer
ls *.service

read -rp $'Continue (Y/n) : ' -ei $'Y' continue_key;
echo "$continue_key"

if [[ "$continue_key" != "Y" ]]; then
    echo "user-terminated. exiting..."
    exit 0
fi

# moving unit files to correct directory

sudo cp borg-backup.timer /etc/systemd/system/borg-backup.timer
sudo cp borg-backup.service /etc/systemd/system/borg-backup.service

# after copy of unit files, we must reload daemon
sudo systemctl daemon-reload

# we check the status of the service
sleep 3
systemctl status borg-backup

exit 0