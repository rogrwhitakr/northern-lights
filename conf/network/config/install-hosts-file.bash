#!/usr/bin/env bash

# VERSION
version="1.0.1"

source "/home/admin/MyScripts/script/helpers/init.bash"
source "/home/admin/MyScripts/script/helpers/log.bash"

strict=1
debug=0

script_init
flags_init

sudo install create-database.sql \ 
    --target-directory /var/lib/pgsql/scripts \
    --owner=postgres \
    --group=postgres \
    --compare \
    --mode=640