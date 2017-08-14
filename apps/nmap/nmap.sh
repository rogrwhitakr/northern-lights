#! /bin/sh

# TODOs
# validation, ip and/or host
# validate if ip or host
# validate ipv6
# https://stackoverflow.com/questions/19737675/shell-script-how-to-extract-string-using-regular-expressions

validate_ip(){

	if [ -z "$1" ]; then
		echo 'validate_ip: no input provided'
		exit 1
	fi
	
	ip_regex=^[0-2]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$

	if [[ $1 =~ $ip_regex ]]; then
		echo 'valid'
		echo needs range limits ! only 255.255.255.255 as max!

	else 
		echo 'doesnt work yet'
	fi
}


read -rp $'Enter an IP address:\n' ip_address

echo $ip_address

validate_ip $ip_address

exit 0

scan TCP and UDP ports of computer
sudo nmap -n -PN -sT -sU -p- 192.168.100.26

scan only TCP ports of computer
sudo nmap -n -PN -sT -p- 192.168.100.26

# https://www.stationx.net/nmap-cheat-sheet/