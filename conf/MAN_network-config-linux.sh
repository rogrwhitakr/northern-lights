#! /bin/sh


### functions

function line() {
	echo [--------------------------------------------------------------------------------------------------------------]
}

### variables

RED='\033[0;31m'
NOC='\033[0m' 	

### exec
line
echo -e "${RED}NM_CONTROLLED=yes${NOC}"
echo -e "${NOC}	Will have your network interface be managed the NetworkManager daemon.${NOC}"
line
echo -e "${RED}NM_CONTROLLED=no${NOC}"
echo -e "${NOC}	Will have your network interface be managed the old way. \n	It means fully configured by the /etc/sysconfig/network-scripts/ifcfg-ethX files.${NOC}"
line
exit 0