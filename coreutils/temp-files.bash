#! /usr/bin/env bash


echo "I HAVE BEEN EXPECTING YOU, MISTER BOND!!!"
echo "VERY WELL....!" 
export TMPDIR="/tmp"
mktemp "$(date "+%Y-%m-%d_%H:%M:%S")".XXXXXXXX
mktemp "${BASHPID}".XXXXXXX
exit 0

# cp -f ~/Scripts/apps/backup/borg/user-backup.* user/ && chmod u+x user/*.bash && systemctl --user daemon-reload