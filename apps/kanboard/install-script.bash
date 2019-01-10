#! /usr/bin/env bash

# a very convenient one-liner to set all properties of a file / directory:

sudo install create-database.sql /var/lib/pgsql/scripts \
    --owner=postgres \
    --group=postgres \
    --mode=640

# this way, the regular user may edit the file in an environment, that is well known
# the file is provided in an easily executable way for the postgres user in a known, convenient directory      
