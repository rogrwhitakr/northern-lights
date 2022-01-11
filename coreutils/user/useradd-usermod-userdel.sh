#!/usr/bin/env bash

# create user
useradd [OPTIONS] USERNAME

# -m (--create-home) 
# -u (--uid) option to create a user with a specific UID
# -G (--groups) -> specify a list of supplementary groups which the user will be a member of
# -c (--comment)

sudo useradd -m username
sudo useradd -e login_user

# creates user admin with home and wheel 
sudo useradd -m -G wheel -c "Guacamole login user" admin

# then set password
sudo passwd admin

# add user to supplemental group
usermod -a -G groupName login_user
