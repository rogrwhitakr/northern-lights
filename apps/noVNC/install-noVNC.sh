
#!/usr/bin/env bash

noVNC=/usr/bin/noVNC
cd $noVNC

if [ $noVNC!= /usr/bin/noVNC]; then
	mkdir -p /usr/bin/noVNC 
fi

cd "$(noVNC "$0")"

git clone https://github.com/kanaka/noVNC.git

cd ./utils

clear

sh launch.sh --cert self.pem  --vnc localhost:5999