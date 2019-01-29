#! /usr/bin/env bash

# securing an (ubuntu) server

# updates

# user creattion
useradd deploy
mkdir /home/deploy
mkdir /home/deploy/.ssh
chmod 700 /home/deploy/.ssh

# set shell for user
usermod -s /bin/bash deploy

# best practive: Require ssh key authentication
# HAVE A LONG AND SECURE PASSPHRASE PROTECTING YOUR KEY.

# Copy the contents of your id_rsa.pub1 on your local machine to your servers authorized keys file.
# Let's set the right permissions based on the Linux security principal of least privilege:
touch /home/deploy/.ssh/authorized_keys
chmod 400 /home/deploy/.ssh/authorized_keys
chown deploy:deploy /home/deploy -R

passwd deploy

# Setting up sudo
visudo 

# Add the %sudo group below the root user as shown below. 
# Make sure to comment out any other users and groups with a #. 
# users have no prefix and groups start with %.) Most fresh installs won't have any there, but just make sure.
root    ALL=(ALL) ALL
%sudo   ALL=(ALL:ALL) ALL

# add deploy user to the sudo group.
usermod -aG sudo deploy

# restrict ssh
nano /etc/ssh/sshd_config

# PermitRootLogin no
# PasswordAuthentication no
# AllowUsers deploy@(your-VPN-or-static-IP)