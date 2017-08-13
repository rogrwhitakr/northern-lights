# /bin/sh

RED='\033[0;31m'
NOC='\033[0m' 	# No Color

function line() {
	echo [------------------------------------------------------------------]
}

echo
echo AWK
echo
echo -F == --field-separators

getent aliases | awk -F: '{ print $1,"||", $5 }'

line

echo -e "${RED}Contents of /etc/passwd ${NOC}"

# print contents of /etc/passwd 
cat /etc/passwd
line

# print only the GID and UID columns
awk -F: '{print $3,$4}' /etc/passwd
line

# print only the ones containing "systemd"
awk -F: '$1 ~ /^systemd/ {print $5}' /etc/passwd
line

# print using regex
# awk -F  '$3 ~ /[0-9]{3}/ {print $1}' /etc/passwd
# https://techarena51.com/blog/advance-text-processing-examples-awk/
line

