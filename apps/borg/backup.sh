#!/usr/bin/env bash - 

# Skriptvorlage BorgBackup
# https://wiki.ubuntuusers.de/BorgBackup/
# https://borgbackup.readthedocs.io/en/stable/
# https://blog.andrewkeech.com/posts/170718_borg.html
# should:
# -> create user specific for this task?
# -> if yes, what are the benefits?
# -> 

# Route the normal process logging to journalctl
2>&1

#####################################################################################
# set variables

# path to backup target
backup_target="/mnt/backup"

# name of backup repository / one level down
repository="borg"

# combined path
backup_path="$backup_target"/"$repository"

# also possible
export REPOSITORY="$backup_target"/"$repository"
export BORG_REPO="$backup_target"/"$repository"

# empty for now
export BORG_PASSPHRASE=""

# list of 
# ->  files / dirs to backup
# ->  files / dirs to exclude from within these lists
# includes="/home/peter/Bilder /home/peter/Videos --exclude *.tmp"
includes="
/home/admin/MyScripts  
/home/admin/html 
/home/admin/libvirt 
/home/admin/.ssh 
/home/admin/aurora 
/home/admin/bin 
/home/admin/docker 
/home/admin/Dokumente 
"
excludes="
'/home/admin/.*'
"
# mode of encryption / options = "none, ???"
encryption="none"

# mode of compression / options = "none, lz4, ???"
compression="lz4"

###################################################################################################

echo -e "directories to be archived: $incldes\n"

/usr/bin/env | grep BORG
###################################################################################################
# execution

# Init borg-repo if absent
if [ ! -d $backup_path ]; then
  borg init --encryption=$encryption $backup_path 
  echo "created borg repository in $backup_path"
fi

# backup data
SECONDS=0
echo "Start of backup on $(date)."

borg create --compression $compression --exclude-caches --one-file-system -v --stats --progress \
  $backup_path::'{hostname}-{now:%Y-%m-%d-%H%M%S}' $includes --exclude $excludes

# If there is an error backing up, reset password envvar and exit
if [ "$?" = "1" ] ; then
    export BORG_PASSPHRASE=""
    exit 1
fi

echo "Backup finished for $(date). duration: $SECONDS Seconds"

# prune archives
echo "Pruning Archives:"

# Hier angeben nach welchem Schema alte Archive gelöscht werden sollen.
# Die Vorgabe behält alle sicherungen des aktuellen Tages. Zusätzlich das aktuellste Archiv der 
# letzten 7 Tage, der letzten 4 Wochen sowie der letzten 12 Monate.
borg prune -v --list $backup_path \
    --prefix '{hostname}-' \
    --keep-within=1d \
    --keep-daily=7 \
    --keep-weekly=4 \
    --keep-monthly=12

# Include the remaining device capacity in the log
echo -e "\nremaining device capacity:"
df -hl | grep --color=never "$backup_target"

# list archives for log
# borg list $REPOSITORY

# Unset the password
export BORG_PASSPHRASE=""
exit 0