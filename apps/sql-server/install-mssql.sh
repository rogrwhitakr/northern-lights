# bin/sh

###################################################################################################################
#
#	Install-script for MSSQL demo on LINUX / RHEL 7
#	Version 1.0
#	2016-12-07
#
###################################################################################################################

RED='\033[0;31m'
NOC='\033[0m'

PROGRAMME=MSSQL

if [ -e $(command -v dnf) ]; then
	INSTALLER=$(command -v dnf)
	echo Installer is $INSTALLER
fi

#check user

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

read -rsp $'Press enter to start installation of '$PROGRAMME \n

# remove OBDC, if installed
$INSTALLER remove unixODBC -y

# This command retrieves the YUM repository configuration file:
curl https://packages.microsoft.com/config/rhel/7/mssql-server.repo | tee /etc/yum.repos.d/mssql-server.repo

# linux CLI
curl https://packages.microsoft.com/config/rhel/7/prod.repo | tee /etc/yum.repos.d/mssql-prod.repo

#install
$INSTALLER install mssql-server mssql-tools

firewall-cmd --add-port=1433/tcp --permanent
firewall-cmd --reload