#!/usr/bin/env bash

# Skriptvorlage BorgBackup
# https://wiki.ubuntuusers.de/BorgBackup/
# https://borgbackup.readthedocs.io/en/stable/
# should:
# -> create user specific for this task?
# -> if yes, what are the benefits?
# -> 

#####################################################################################
# set variables

# path to backup target
backup_target="/mnt/backup"

# name of backup repository / one level down
repository="borg"

# combined path
backup_path="$backup_target"/"$repository"

# list of 
# ->  files / dirs to backup
# ->  files / dirs to exclude from within these lists
# includes="/home/peter/Bilder /home/peter/Videos --exclude *.tmp"
includes="/home/admin/MyScripts /home/admin/html /home/admin/named@dns /home/admin/libvirt /home/admin/.ssh --exclude '/home/admin/.*'"

# mode of encryption / options = "none, ???"
encryption="none"

# mode of compression / options = "none, lz4, ???"
compression="lz4"

# before execution check for user rights?
# must we be root? / options = "true" , "false"
_root="true"

# Hier angeben nach welchem Schema alte Archive gelöscht werden sollen.
# Die Vorgabe behält alle sicherungen des aktuellen Tages. Zusätzlich das aktuellste Archiv der 
# letzten 7 includesstage, der letzten 4 Wochen sowie der letzten 12 Monate.
prune="--keep-within=1d --keep-daily=7 --keep-weekly=4 --keep-monthly=12"

###################################################################################################
# lets have some functions, like a root check and a directory validator

# check for root
_root_check() {
if [ $(id -u) -ne 0 ] && [ "$_root" == "true" ]; then
  echo -e "backup must be executed as the root user. \nExiting..."
  exit 1
fi
}

# check if directory exists
_dir_check(){
if [ -n "$1" ] && [ -d "$1" ]; then
  return 0
else
  return 1
fi
}

_dir_check "$backup_target" 
_dir_check "$backup_path"
if [ _dir_check "$backup_target" == "0" ]; then
  echo "success"
fi
if [ $(_dir_check "$backup_path") -eq 0 ]; then
  echo "more success"
fi

echo -e 'exiting, because its , you know, .. fun....'
exit 0
###################################################################################################
# execution

# check user
_root_check

# Init borg-repo if absent
if [ ! -d $backup_path ]; then
  borg init --encryption=$encryption $backup_path 
  echo "created borg repository in $backup_path"
fi

# backup data
SECONDS=0
echo "Start of backup on $(date)."

borg create --compression $compression --exclude-caches --one-file-system -v --stats --progress \
            $backup_path::'{hostname}-{now:%Y-%m-%d-%H%M%S}' $includes

echo "Backup finished for $(date). duration: $SECONDS Seconds"

# prune archives
borg prune -v --list $backup_path --prefix '{hostname}-' $prune
