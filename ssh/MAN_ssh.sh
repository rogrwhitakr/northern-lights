#! /bin/sh


### functions

function line() {
	echo [--------------------------------------------------------------------------------------------------------------]
}

### variables

RED='\033[0;31m'
YELLOW='\e[33m'
NOC='\033[0m'

### exec

line
echo -e "${RED}SSH${NOC}"
echo -e "${NOC}Reverse DNS lookup (rDNS) bezeichnet eine DNS-Anfrage, bei der zu einer IP-Adresse der Name ermittelt werden soll.\n Alternativbezeichnungen sind inverse Anfragen[1], reverse lookup oder inverse requests.
In den meisten Fällen wird das Domain Name System (DNS) verwendet,\n um zu einem Domain-Namen die zugehörige IP-Adresse zu ermitteln.\n Es gibt aber auch die umgekehrte Situation, bei der zu einer vorgegebenen IP-Adresse der Name benötigt wird. 
Wenn diese Auflösung ermöglicht werden soll, wird eine reverse Domäne angelegt.
${NOC}"

line
echo -e "${RED}langsames SSH${NOC}"
echo -e "${NOC}	1. It seems like a reverse DNS problem. By default, SSH will check where incoming connections are from by performing a reverse DNS query on the incoming IP address. This will work fine when you come from an external computer, but might fail when you come locally if you don't have DNS setup properly. If you haven't done so already, you could try to add all your computer's hostnames and IP address in /etc/hosts on all computers (especially the ssh server) to make sure the reverse DNS will succeed. Obviously, you'd need to use static IP addresses on your LAN for that to work.
${NOC}"
echo -e "${NOC}	2. Failing the /etc/hosts solution above, you could try setting the UseDNS setting to 'no' in the ssh server. To do this:

		sudo nano /etc/ssh/sshd_config
		
	add this line to the bottom (or change the 'yes' to 'no' if it's already in the config file):
	
		UseDNS no
		
	then restart the ssh server:

		sudo /etc/init.d/ssh restart
		
andere Ideen:

	Edit your "/etc/ssh/ssh_config" and comment out these lines:

		GSSAPIAuthentication yes
		GSSAPIDelegateCredentials no${NOC}"

line
exit 0		