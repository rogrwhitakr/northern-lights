#! /usr/bin/env bash

# add the existing user "admin" to the existing group "ldap"
sudo usermod -aG ldap admin

# get the groups available for current user
getent group | grep ":$(id -un)"