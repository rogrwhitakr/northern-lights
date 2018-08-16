#! /usr/bin/env sh

echo "
this script ($0) is used to
->  set up BORG backup script 
->  set up systemd unit files (service and timer)
    using files found in this directory
"

# if the files cannot be found i am not in the right directory
if [[ $(ls borg-backup.timer 2> /dev/null) != 0 ]] || \
    [[ $(ls borg-backup.service 2> /dev/null) != 0 ]]; then
    echo "systemd unit files not found in current directory"
    readonly dir=$(readlink "$0")
    echo "current location:"
    pwd
    echo "Exiting $0, process-id $$"
    exit 1
fi    

# NON-POSIX COMPLIANT SOLUTION
SCRIPT=$(readlink -f $0)

echo "$SCRIPT" | grep -E '/apps/borg/' && echo "ya"

read -rp $'Continue (Y/n) : ' -ei $'Y' continue_key;
echo "$continue_key"

if [[ "$continue_key" != "Y" ]]; then
    echo "user-terminated. exiting..."
    exit 0
fi

# moving unit files to correct directory

sudo cp borg-backup.timer /etc/systemd/system/borg-backup.timer
sudo cp borg-backup.service /etc/systemd/system/borg-backup.service

sudo chmod 622 /etc/systemd/system/borg-backup.timer 
sudo chmod 622 /etc/systemd/system/borg-backup.service
 
echo -e "the files!"
ls -l /etc/systemd/system/borg-backup.*
# after copy of unit files, we must reload daemon
sudo systemctl daemon-reload

# we check the status of the service
sleep 3
systemctl status borg-backup

exit 0