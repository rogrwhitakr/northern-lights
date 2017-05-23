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
echo -e "${RED}<service_name> dead but subsys locked${NOC}"
echo -e "${NOC}	-->	the service was running at one time, but has crashed.${NOC}"
echo -e "${NOC}	-->	When you start a service, it creates a "lock" file to indicate that the service is running${NOC}"

line
echo -e "${RED}two areas for services --> run / lock ${NOC}"
echo -e "${NOC}	/var/run/<service_name>/<service_name>.pid  ${NOC}"
echo -e "${NOC}	/var/lock/subsys/<service_name>${NOC}"

line
echo -e "${RED}Removing <service_name> lock file${NOC}"
echo -e "${NOC}    rm /var/lock/subsys/<service_name>${NOC}"

line
echo -e "${RED}init_file${NOC}"
echo -e "${NOC}	--> This is the init script for starting up the <service_name>${NOC}"
echo -e "${NOC}	-->Pfad	
	/etc/rc.d/init.d/<service_name>
Pfad Service Command
	/sbin/service
	--> bash script, das die Funktionalität des commands <service> (z.B. service --status-all) definiert
	
	service		--status-all
	service 	--status-all 		| grep <service>	SELECT 1${NOC}"

line
echo -e "${RED}Turn on / off service${NOC}"
echo -e "${NOC}	chkconfig <service> off/on${NOC}"

line
echo -e "${RED}configuration to start up <service_name> at boot time${NOC}"
echo -e "${NOC}	--> initscript utility
		--> /sbin/chkconfig
		-->	/usr/sbin/ntsysv
			--> scheint es bei CentOS Minimal Installation nicht zu geben!
			
	-->	/etc/rc.d
		--> rc.0-6 
		--> RunLevel
		--> Ausgabe über  chkconfig
	-->	symbolic links beginning with either k or s. 
		-->	s = yes
		--> k = no
	--> Number refers to Sequence${NOC}"
line
exit 0