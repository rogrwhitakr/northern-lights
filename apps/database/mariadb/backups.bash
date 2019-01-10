#! /usr/bin/env bash
# todo:

set -o nounset
set -x
# 1. identify the databases
# 2. loop through those, making a backup
# 3. zip those backups using borg maybe
# 4. all systemd run

trap "rm -f $lockfile; exit" INT TERM EXIT

db_user="root"
db_password="vasques"

# get a defaults file and copy to user home  
# install works! no need to own and run privileged
find /etc -name mysql-clients.cnf -exec install {} --target-directory ~/ --owner "$(id -un)" --group "$(id -un)" \; 2>/dev/null
printf "\ncopied the \"mysql-clients.cnf\" file to the user-home-directory"
# modify utility
sed --in-place '/^user/d' ~/mysql-clients.cnf
sed --in-place '/^password/d' ~/mysql-clients.cnf

# todo: sed the correct credentials in place from a variable of the script
sed --in-place 's/^[mysqldump]$/[mysqldump] \nuser=${db_user}\npassword=${db_password}/g' ~/mysql-clients.cnf
sed --in-place 's/^[mysqlshow]$/[mysqlshow] \nuser=aurora\npassword=aurora/g' ~/mysql-clients.cnf

cat ~/mysql-clients.cnf

# create a backup dir
backup_dir=~/backups
mkdir "${backup_dir}"


# remove the trap at the end
trap - INT TERM EXIT

# show the databases
mysqlshow --defaults-file=~/mysql-clients.cnf

# yield a list of databases
mysqlshow --defaults-file=~/mysql-clients.cnf | sed '/^+/d' | awk '{print $2}'

# read into array
readarray -t databases < <(mysqlshow --defaults-file=~/mysql-clients.cnf | sed '/^+/d' | sed '/Databases/d' | sed '/_schema/d' | awk '{print $2}')

for database in "${databases[@]}"; do
	mysqldump --defaults-file=~/mysql-clients.cnf "${database}" >"${backup_dir}"/"${database}"_"$(date +"%Y-%m-%d_%H:%M")".sql
	echo "did database $database"
done

# okay, done

# borg now

# and systemd
