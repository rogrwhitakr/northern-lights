#!/usr/bin/env bash

# path to backup target
backup_target="/mnt"

# name of backup repository / one level down
repository="borg"

# combined path
backup_path="${backup_target}"/"${repository}"

# list of includes
# find $(pwd) -maxdepth 1 -noleaf | grep -E '/\.' --invert-match
includes="$(find ~ -name includes.borg -exec cat {} \;)"
# includes="$(find ~ -mindepth 1 -maxdepth 1 \( ! -name ".*" \) )"
# excludes="$(find ~ -name excludes.borg -print -exec cat {} \;)"

encryption="none"

# mode of compression / options = "none, lz4, ???"
compression="lz4"

# Hier angeben nach welchem Schema alte Archive gelöscht werden sollen.
# Die Vorgabe behält alle sicherungen des aktuellen Tages. Zusätzlich das aktuellste Archiv der
# letzten 7 includesstage, der letzten 4 Wochen sowie der letzten 12 Monate.
prune="--keep-within=1d --keep-daily=7 --keep-weekly=4 --keep-monthly=12"

###################################################################################################
# some functions

script_finish() {

	# DESC: Trap exits with cleanup function
	# ARGS: exit code -> trap <script_finish> EXIT INT TERM
	# OUTS: None (so far)

	local ERROR_CODE="$?"

	if [[ "${ERROR_CODE}" != 0 ]]; then
		printf "ERROR\n"
	else
		printf "All is well. Exiting."
	fi
}

trap script_finish EXIT INT TERM

###################################################################################################
# execution

# create the dir if it does not exist
if [ ! -d "${backup_target}" ]; then
	mkdir "${backup_target}"
fi

# Init borg-repo if absent
if [ ! -d "${backup_path}" ]; then
	borg init --encryption="${encryption}" "${backup_path}"
	echo "created borg repository in ${backup_path}"
fi

# backup data
SECONDS=0
echo "Start of backup on $(date)."

borg create --compression $compression --exclude-caches --one-file-system -v --stats --progress \
	"${backup_path}"::'{hostname}-{now:%Y-%m-%d-%H%M%S}' "${includes}" --exclude "${excludes}"

echo "Backup finished for $(date). duration: $SECONDS Seconds"

# prune archives
borg prune -v --list "${backup_path}" --prefix '{hostname}-' $prune

# added crontab with this line
# */10 *    * * *   /home/benno/script/apps/borg/backup.HS.sh > /dev/null 2>&1

# added env var
#BORG_REPO to repository directory
# then you can call
#borg list ::

# http://borgbackup.readthedocs.io/en/stable/usage/general.html#environment-variables
