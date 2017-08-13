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

# count files in current directory
ls -1 /usr/share/applications/*.desktop | wc -l

# exclude symbolic links
ls -1 /usr/share/applications/*.desktop | grep -v ^l | wc -l

# loop through randomly selected range

readonly range=$(( RANDOM % 20 ))

for i in $( seq 3 $range ); 
do
	files=$( ls /usr/share/applications/*.desktop | head -n $range )
	echo -e "$i"
	echo -e "$files"
	sleep 0.2
#	cat $(ls /usr/share/applications/*.desktop | head -$(i))
done

exit 0