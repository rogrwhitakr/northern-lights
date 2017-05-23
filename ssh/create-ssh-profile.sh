#! bin/sh

# functions

function line() {
	echo [------------------------------------------]
}

# variables
RED='\033[0;31m'
YELLOW='\e[33m'
NOC='\033[0m'
BLUE='\e[34m'

rm ~/.ssh/config

identity="ident1"



if [ ! -d ~/.ssh ]; then
	mkdir ~/.ssh/

	if [ ! -f ~/.ssh/config ]; then
		touch ~/.ssh/config
	fi

fi

### create ssh key

#cd ~/.ssh/
#ssh-keygen -t rsa -C "bennoosterholt@gmail.com"


tee >> /dev/null ~/.ssh/config << EOF
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
 
# Geoserver OSM Docker Europe
Host osm_docker_europe
    HostName osm_docker_europe
    Port 22
    User optitool
    IdentityFile ~/.ssh/geoserver.key

# GITHUB as rogrwhitakr
Host rogrwhitakr.github.com
    HostName github.com
    User git
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/github

EOF

find ~/.ssh/config ! -perm 600 -exec echo nei

if [[ find . ! -perm -600 ]]; then
	chmod 600 ~/.ssh/config
fi

cat ~/.ssh/config &&  ls -lah ~/.ssh/