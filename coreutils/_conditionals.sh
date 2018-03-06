#! /bin/dash
programme="htop"
demofile="~1.txt"

if ! [ which $programme = "0" ]; then
    echo "found $programme in $(which $programme)"
else
    echo "nah"
fi

# checking if a file exists
if [ ! -f $demofile ]; then
	touch  $demofile
	chmod 644 $demofile
fi