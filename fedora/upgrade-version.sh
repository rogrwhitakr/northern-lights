# bin/sh

#check user

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#start upgrade process

dnf upgrade --refresh

dnf install dnf-plugin-system-upgrade -y

dnf system-upgrade download --releasever=25 --allowerasing -y

# hier ist ein zusätzlicher read auf den schlüssel import !!!

#system-upgrade reboot