#! /bin/sh

##########################################################################
# https://appdb.winehq.org/objectManager.php?sClass=application&iId=2594
# https://hub.docker.com/r/suchja/wine/
# http://alesnosek.com/blog/2015/07/04/running-wine-within-docker/
##########################################################################

#################
### functions ###
#################

printline() {
	echo [-------------------------------------------------]
}

#################
### variables ###
#################

NOC='\033[0m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'

user=$(id -un) 

#################
### execution ###
#################

printline
echo -e "${RED}$0${NOC}"
printline
echo -e "${NOC}this script installs Windows Emulation (Wine),\nRoller-Coaster-Tycoon 2,\nRoller-Coaster-Tycoon 2 Extension Pack${NOC}"
printline
