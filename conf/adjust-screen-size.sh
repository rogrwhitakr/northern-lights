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
echo -e "${RED}gnome-control-center${NOC}"
echo -e "${NOC}	-->	ruft die Einstellungen auf${NOC}"
line
echo -e "${RED}xrandr${NOC}"
echo -e "${NOC}	-->	screen resolution / sehen was eingestellt ist
	-->	Änderungsmöglichkeit, natürlich${NOC}"
line
exit 0