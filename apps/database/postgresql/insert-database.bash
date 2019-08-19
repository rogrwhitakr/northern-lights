#! /usr/bin/env bash

database=~/northern-lights/apps/database/_data/psql-names-database.sql
psql_backup_dir="/var/lib/pgsql/backups/"

# in future we could create some dated directories
# sudo -u root "mkdir"

# copy the file with correct permissions
sudo -u root install "${database}" --target-directory "${psql_backup_dir}" --owner=postgres --group=postgres --compare --mode=640