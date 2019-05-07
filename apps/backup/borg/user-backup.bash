#! /usr/bin/env bash


echo "I HAVE BEEN EXPECTING YOU, MISTER BOND!!!"
echo "VERY WELL....!" 
mktemp -p "${BASHPID}"
mktemp "${BASHPID}"/"$(date "+%Y-%m-%d_%H:%M:%S")"

exit 0

# cp -f ~/Scripts/apps/backup/borg/user-backup.* user/ && chmod u+x user/*.bash && systemctl --user daemon-reload