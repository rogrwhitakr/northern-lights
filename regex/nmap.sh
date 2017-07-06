#! /bin/sh

# TODOs
# validation, ip and/or host
# validate if ip or host


validate_ip(){

	if [ -z "$1" ]; then
		echo 'validate_ip: no input provided'
		exit 1
	fi
	
	if [[ $1 = [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]]; then
		echo 'valid'
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
