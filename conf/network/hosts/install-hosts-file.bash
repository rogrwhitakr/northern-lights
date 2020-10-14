#!/usr/bin/env bash

# VERSION
version="0.0.1"

source "/home/admin/MyScripts/script/helpers/init.bash"

strict=1
debug=1

script_init
flags_init

sudo install --no-target-directory hosts.northern-lights.one /etc/hosts --mode=644