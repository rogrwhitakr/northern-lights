#! /usr/bin/env bash
# todo:

set -o nounset
set -x
# 1. identify the databases
# 2. loop through those, making a backup
# 3. zip those backups using borg maybe
# 4. all systemd run

db_user="root"
db_password="vasques"

# get a defaults file and coly to home dir, location may not be final
find /etc -name mysql-clients.cnf -exec install {} --target-directory ~/ --owner "$(id -un)" --group "$(id -un)" \; 2>/dev/null

echo "got through find"

# modify utility

sed --in-place '/^user/d' ~/mysql-clients.cnf
sed --in-place '/^password/d' ~/mysql-clients.cnf

echo deletion okay
read

#sed --in-place 's/^[mysqldump]$/[mysqldump] \nuser=${db_user}\npassword=${db_password}/g' ~/mysql-clients.cnf
sed --in-place 's/^[mysqlshow]$/[mysqlshow] \nuser=aurora\npassword=aurora/g' ~/mysql-clients.cnf

cat ~/mysql-clients.cnf
read
# own it, this unfortungately does not work without sudo
# maybe "install" ????
# sudo chown "$(id -un)"."$(id -un)" mysql-clients.cnf 
# install works! no need to own and run privileged

# create a backup dir
backup_dir=~/backups
mkdir "${backup_dir}"

# todo: sed the correct credentials in place from a variable of the script
# what i did with nano here
nano mysql-clients.cnf 

# show the databases
mysqlshow --defaults-file=~/mysql-clients.cnf

# yield a list of databases
mysqlshow --defaults-file=~/mysql-clients.cnf | sed '/^+/d' | awk '{print $2}'

# i need to get rid of 
# read into array
readarray -t databases< <(mysqlshow --defaults-file=~/mysql-clients.cnf | sed '/^+/d' | sed '/Databases/d' | sed '/_schema/d' | awk '{print $2}')

for database in "${databases[@]}";do
    mysqldump --defaults-file=~/mysql-clients.cnf "${database}" > "${backup_dir}"/"${database}"_"$(date +"%Y-%m-%d_%H:%M")".sql
    echo "did database $database";
done

# okay, done

# borg now

# and systemd