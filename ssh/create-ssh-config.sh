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
# Server-Demo 
Host blue-sun bluesun
    HostName 192.168.122.133
    Port 22
    User admin
    IdentityFile ~/.ssh/ssh_host_ecdsa_key

# GITHUB as rogrwhitakr
Host rogrwhitakr.github.com
    HostName github.com
    User git
    PreferredAuthentications publickey
#   IdentityFile ~/.ssh/tba_rsa

### default for all ##
Host *
     ForwardAgent no
     ForwardX11 no
     ForwardX11Trusted yes
     User admin
     Port 22
     Protocol 2
     ServerAliveInterval 60
     ServerAliveCountMax 30
EOF


# own the config file
chown $user ~/.ssh/config
chmod 600 ~/.ssh/config
