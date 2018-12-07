#!/usr/bin/env sh

# a very convenient one-liner to set all properties of a file / directory:

sudo install create-database.sql \ 
    --target-directory /var/lib/pgsql/scripts \
    --owner=postgres \
    --group=postgres \
    --compare \
    --mode=640

sudo install create-database.sql \ 
    --no-target-directory /var/lib/pgsql/scripts/sql-file.sql \ # treat as normal file
    --owner=postgres \
    --group=postgres \
    --compare \
    --mode=640

# this way, the regular user may edit the file in an environment, that is well known
# the file is provided in an easily executable way for the postgres user in a known, convenient directory      


# [--------------------------------------------------------------]


unit_service_file=/home/benno/northern-lights/systemd/profile-setup.service
user_unit_file_dir=/etc/systemd/system

echo 'start'
# works!
# sudo systemd-analyze verify "${unit_service_file}"

# okay, lets see if we can use this for service file "installation"
install "${unit_service_file}" \
    --target-directory "${user_unit_file_dir}" \
    --compare \
    --mode=622

ls -lah "${user_unit_file_dir}/${unit_service_file##*/}"
stat "${user_unit_file_dir}/${unit_service_file##*/}"
# enabling comes later, trapping any things ealierer   

# a very convenient one-liner to set all properties of a file / directory:

sudo install create-database.sql \ 
    --target-directory /var/lib/pgsql/scripts \
    --owner=postgres \
    --group=postgres \
    --compare \
    --mode=640

# this way, the regular user may edit the file in an environment, that is well known
# the file is provided in an easily executable way for the postgres user in a known, convenient directory      
