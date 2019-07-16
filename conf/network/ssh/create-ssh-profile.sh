#! /usr/bin/env bash

trap echo "something failed. exit by trap" INT TERM EXIT 

# make sure this is not run by the root user
if [ "$(id -u)" != 0 ]; then
    echo -e "creating ssh config for user $(id -un)"
else
    echo -e "this script must not be run as root!\nExiting"
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
# first we look locally

# script directory also contains a default sshconfig file
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="ssh.default.config"
echo -e "copying file ${__dir}/${__file} to ssh directory"
cp "${__dir}/${__file}" ~/.ssh/config

# if copy fails we source from github
if [[ $? != 0 ]]; then
    echo -e "copy process failed. curling from github"
    curl -o ~/.ssh/config.github 'https://raw.githubusercontent.com/rogrwhitakr/northern-lights/master/conf/network/ssh/ssh.default.config'
fi
# own the config file, set right params
chown $(id -un) ~/.ssh/config
chmod 600 ~/.ssh/config

# if all else fails, recheck this last one
# leaving this one in place for its unnecessary complexity and convolutedness...
find ~/.ssh/config ! -perm 600 -exec chmod 600  {} \;

echo -e "ssh config now in place" 
exit 0