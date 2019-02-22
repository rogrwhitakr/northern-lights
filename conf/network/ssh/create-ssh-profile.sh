#! /usr/bin/env bash

# make sure this is not run by the root user
if [ ${id -u} == 0 ]; then
    printf "creating ssh config for user ${id -un}"
else
    printf "this script must not be run as root!\nExiting"
    exit 1
fi

# create the ssh-config file, if it does not exist 
if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh/
    if [ ! -f ~/.ssh/config ]; then
        touch ~/.ssh/config
    fi
fi    

# populate the config file
curl -o ~/.ssh/config.github 'https://raw.githubusercontent.com/rogrwhitakr/northern-lights/master/conf/dotfiles/.ssh.northernlights.config'

# own the config file
chown ${id -un} ~/.ssh/config
chmod 600 ~/.ssh/config

# if all else fails, recheck this last one
find ~/.ssh/config ! -perm 600 -exec chmod 600  {} \;
