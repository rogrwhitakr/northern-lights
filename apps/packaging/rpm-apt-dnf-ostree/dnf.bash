#! /usr/bin/env bash

# list groups
dnf grouplist

# list hidden groups
dnf grouplist --hidden

# get repositories
dnf repolist

# execute version update

sudo dnf upgrade --refresh

# Install dnf-plugin-system-upgrade package
sudo dnf install dnf-plugin-system-upgrade

# Download packages
sudo dnf system-upgrade download --refresh --releasever=$RELEASE_VERSION

# Trigger the upgrade process
sudo dnf system-upgrade reboot