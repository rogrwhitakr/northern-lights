#! /bin/sh

directory=$arg1

function hidden {
		
	if [ -z $arg1 ]; then
		directory=`pwd`
	else 
		directory=$arg1	
	fi

echo $arg1
echo $directory

ls -1d $directory/.*
}

hidden $directory