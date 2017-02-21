# bin/sh

RED='\033[0;31m'
NOC='\033[0m' 

#variabes
container=docker.io/nginx:latest
clear
echo
echo Docker Prozesse : Command [docker ps]
echo
docker ps


echo
echo vorhandenene docker images : Command [docker images]
echo
docker images
read -n1 -r -p "Press key to continue..." key

echo
echo Docker run Options : -it [interactive] -d [detached] --rm --help -p [port-forwarding 8080:8090 \| host:container] 
echo

#docker run --rm $container
docker run -d $container
read -n1 -r -p "Press key to continue..." key

