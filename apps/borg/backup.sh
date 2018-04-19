#!/usr/bin/env bash

# Skriptvorlage BorgBackup
# https://wiki.ubuntuusers.de/BorgBackup/
# https://borgbackup.readthedocs.io/en/stable/
# should:
# -> create user specific for this task?
# -> if yes, what are the benefits?
# -> 

# path to backup target
backup_target="/mnt/backup"

# name of backup repository / one level down
repository="borg"

# list of 
# ->  files / dirs to backup
# ->  files / dirs to exclude from within these lists
# includes="/home/peter/Bilder /home/peter/Videos --exclude *.tmp"
includes="/home/alonsoquinn --exclude '/home/alonsoquinn/.*'"

# mode of encryption / options = "none, ???"
encryption="none"

# mode of compression / options = "none, lz4, ???"
compression="lz4"

# Hier angeben, ob vor der Ausführung von BorgBackup auf vorhandene Root-Rechte geprüft werden soll
# _root="ja"
_root="nein"

# Hier angeben nach welchem Schema alte Archive gelöscht werden sollen.
# Die Vorgabe behält alle sicherungen des aktuellen Tages. Zusätzlich das aktuellste Archiv der 
# letzten 7 includesstage, der letzten 4 Wochen sowie der letzten 12 Monate.
prune="--keep-within=1d --keep-daily=7 --keep-weekly=4 --keep-monthly=12"

###################################################################################################

repopfad="$backup_target"/"$repository"

# check for root
if [ $(id -u) -ne 0 ] && [ "$_root" == "ja" ]; then
  echo "includes muss als Root-User ausgeführt werden."
  exit 1
fi

# Init borg-repo if absent
if [ ! -d $repopfad ]; then
  borg init --encryption=$encryption $repopfad 
  echo "Borg-Repository erzeugt unter $repopfad"
fi

# backup data
SECONDS=0
echo "Start der includes $(date)."

borg create --compression $compression --exclude-caches --one-file-system -v --stats --progress \
            $repopfad::'{hostname}-{now:%Y-%m-%d-%H%M%S}' $includes

echo "Ende der includes $(date). Dauer: $SECONDS Sekunden"

# prune archives
borg prune -v --list $repopfad --prefix '{hostname}-' $prune
