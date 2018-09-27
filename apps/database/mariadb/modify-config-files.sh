#!/bin/bash

set -xq

CLI=/etc/my.cnf.d/mysql-clients.cnf
CLI=/home/admin/MyScripts/apps/database/mariadb/mysql-clients.cnf

sed --in-place 's/^[mysqldump]$/[mysqldump] \nuser=aurora\npassword=aurora/g' "${CLI}"

cat "${CLI}"