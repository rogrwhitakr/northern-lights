# /bin/sh

print_red() {
	if [[ -z "$@" ]]; then
		echo -e "print_red(): no args set"
	fi	  	
	local RED='\033[0;31m'
	local NOC='\033[0m'
	echo -e ${RED}"$@"${NOC}
}

function line() {
	echo [------------------------------------------------------------------]
}

######################## exec ###

print_red AWK
print_red principal functionality: 

echo awk 'program' input-file1 input-file2 …
echo awk -f program-file input-file1 input-file2 …
echo awk [-F --field-separators] 'program' input-file1 input-file2 …
line

getent aliases | awk -F: '{ print $1,"||", $5 }'
line

print_red Contents of /etc/passwd

# print contents of /etc/passwd 
cat /etc/passwd
line

# print only the GID and UID columns
awk -F: '{print $3,$4}' /etc/passwd
line

# print only the ones containing "systemd"
awk -F: '$1 ~/^systemd/ {print $5}' /etc/passwd
line

# print using regex
awk -F  '$3 ~/^[0-9]{4,5}/$ {print $1,"|---|",$5}' /etc/passwd
line

# awk logic / can be added to a file and called as arg -f
awk -F  '{
	for(i=1;i<=NF;i++)
		{ if($i=="/[0-9]{4,5}/")
		{print $i} 
		}
	}' /etc/passwd

# https://techarena51.com/blog/advance-text-processing-examples-awk/
line

exit 0
