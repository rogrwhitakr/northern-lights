#! bin/sh

#################
### variables ###
#################

user=$(id -un)

#################
### execution ###
#################

# creating the ssh-config file 

if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh/

    if [ ! -f ~/.ssh/config ]; then
        touch ~/.ssh/config
    fi

fi    

# populate the config file

tee >> /dev/null ~/.ssh/config << EOF
## curl raw github content
EOF

# own the config file
chown $user ~/.ssh/config
chmod 600 ~/.ssh/config

# recheck this last one
find ~/.ssh/config ! -perm 600 -exec  chmod 600  {} \;

ls -lah ~/.ssh/config && cat ~/.ssh/config