# bin/sh

###################################
# creating and populating a file
# ###################################

demofile=~/demofile.txt

#create the file 
if [ ! -f $demofile ]; then
	touch  $demofile
	chmod 644 $demofile

fi

# populate the file
tee >> /dev/null $demofile << EOF

#######################################
#
# creating and populating $demofile
#
#######################################

demotext

RED='\033[0;31m'
YELLOW='\e[33m'
NOC='\033[0m'
BLUE='\e[34m'

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

EOF

sleep 1

cat $demofile
rm -f $demofile

exit 0