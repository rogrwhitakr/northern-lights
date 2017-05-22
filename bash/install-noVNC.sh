#!/usr/bin bash

function findlaunch {
	noVNC_dir=/usr/bin/noVNC
	starter=./utils/launch.sh

	if [ -d $noVNC_dir ]; then
		cd $noVNC_dir
	else 
		sudo mkdir -m 774 $noVNC_dir
		cd $noVNC_dir
	fi 

	if [ -e $starter ]; then
		clear
		sh $starter
	else
		git clone https://github.com/kanaka/noVNC.git
		mv -f /noVNC $noVNC_dir
		sleep 5 && clear
		sh $starter
	fi
}

### execution ###

findlaunch

#noVNC=/usr/bin/noVNC
#starter=./utils/launch.sh

#cd $noVNC && cd ./utils

#clear

#sh launch.sh --cert self.pem  --vnc localhost:6080