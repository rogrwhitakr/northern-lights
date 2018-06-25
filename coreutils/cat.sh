# /usr/bin/env bash

###################################
# creating and populating a file
# ###################################

demofile=~/cat-a-file.txt

#remove file and recreate

if [ -f $demofile ]; then
	rm $demofile
	touch  $demofile
	chmod 644 $demofile
fi

# way 1)
# populate the file
tee >> /dev/null $demofile << EOF

#######################################
#
# creating and populating $demofile
#
#######################################

WAY 1)

RED='\033[0;31m'
YELLOW='\e[33m'
NOC='\033[0m'
BLUE='\e[34m'

EOF

cat $demofile

# TODO:
# how do i write from commandline
# how do i do anything with these stupid redirectors?  
# WAY 2)

cat > $demofile << EOF
Hello World!
This is my stupid text file.

You
can also
have
a whole lot
more text and
lines
EOF

# WAY N)

exit 0



sleep 1
cat $demofile

exit 0