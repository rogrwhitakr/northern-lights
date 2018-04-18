#!/bin/bash

# Skriptvorlage BorgBackup
# https://wiki.ubuntuusers.de/BorgBackup/
# https://borgbackup.readthedocs.io/en/stable/


# Hier Pfad zum Sicherungsmedium angeben.
# z.B. zielpfad="/media/peter/HD_Backup"
zielpfad="/home/alonsoquinn"

# Hier Namen des Repositorys angeben.
# z.B. repository="borgbackups"
repository="borgbackup"

# Hier eine Liste mit den zu sichernden Verzeichnissen angeben
# z.B. sicherung="/home/peter/Bilder /home/peter/Videos --exclude *.tmp"
sicherung="/home/alonsoquinn --exclude '/home/alonsoquinn/.*'"
# sicherung="/home/alonsoquinn"
# Hier die Art der Verschlüsselung angeben
# z.B. verschluesselung="none"
verschluesselung="none"

# Hier die Art der Kompression angeben
# z.B. kompression="none"
kompression="lz4"

# Hier angeben, ob vor der Ausführung von BorgBackup auf vorhandene Root-Rechte geprüft werden soll
# z.B. rootuser="ja"
rootuser="nein"

# Hier angeben nach welchem Schema alte Archive gelöscht werden sollen.
# Die Vorgabe behält alle Sicherungen des aktuellen Tages. Zusätzlich das aktuellste Archiv der 
# letzten 7 Sicherungstage, der letzten 4 Wochen sowie der letzten 12 Monate.
pruning="--keep-within=1d --keep-daily=7 --keep-weekly=4 --keep-monthly=12"

###################################################################################################

repopfad="$zielpfad"/"$repository"

# check for root
if [ $(id -u) -ne 0 ] && [ "$rootuser" == "ja" ]; then
  echo "Sicherung muss als Root-User ausgeführt werden."
  exit 1
fi

# Init borg-repo if absent
if [ ! -d $repopfad ]; then
  borg init --encryption=$verschluesselung $repopfad 
  echo "Borg-Repository erzeugt unter $repopfad"
fi

# backup data
SECONDS=0
echo "Start der Sicherung $(date)."

borg create --compression $kompression --exclude-caches --one-file-system -v --stats --progress \
            $repopfad::'{hostname}-{now:%Y-%m-%d-%H%M%S}' $sicherung

echo "Ende der Sicherung $(date). Dauer: $SECONDS Sekunden"

# prune archives
borg prune -v --list $repopfad --prefix '{hostname}-' $pruning