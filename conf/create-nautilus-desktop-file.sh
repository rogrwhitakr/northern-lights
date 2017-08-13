#! /bin/sh

#	for all users:
#	-	place into
#		/usr/share/applications
#
#	for own user:
#	-	place into
#		~/.local/share/applications

NOC='\033[0m'
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
On_Green='\e[42m'       # Green

echo -e "${BRed}example desktop entry${NOC}"
echo -e "${On_Green}
[Desktop Entry]
Type=Application
Encoding=UTF-8
Name=Sample Application Name
Comment=A sample application
Exec=application
Icon=application.png
Terminal=false${NOC}"

# loop through randomly selected range

range=$(( RANDOM % 20 ))

for i in $( seq 1 $range ); 
do
	echo -e "$i"
	sleep 0.2
#	cat $(ls /usr/share/applications/*.desktop | head -$(i))
done

exit 0