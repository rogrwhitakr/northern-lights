#! /bin/sh

#################
### functions ###
#################

printline() {
	echo [---------------------------------------------------------------------]
}

#################
### variables ###
#################

NOC='\033[0m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'

user=$(id -un) 
container=whiplash

#################
### execution ###
#################

printline
echo -e "${RED}$0${NOC}"
printline
echo -e "${NOC}this script installs whiplash in a docker container${NOC}"
printline


rm -f $container/Dockerfile
rmdir $container

clear

mkdir $container

touch $container/Dockerfile
tee $container/Dockerfile > /dev/null <<EOF
FROM fedora

RUN dnf update -y \
	&& dnf install whiplash -y \
	&& dnf clean all

CMD /bin/bash
EOF

echo -e "${RED}created container $container and Dockerfile${NOC}"
cat $container/Dockerfile

cd $container
echo -e "${RED}building container $container:${NOC} docker build -t $container"
sudo docker build -t $container

sleep 5

echo -e "${RED}created docker image $container:${NOC} docker images"
sudo docker images | grep $container

sleep 5

echo -e "${RED}running docker image $container:${NOC} docker run $container"
# --rm removes container after it exits
sudo docker run -it --rm $container