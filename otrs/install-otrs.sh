# bin/sh
#variabes
container=swcc/docker-otrs
clear
echo
echo Update and upgrade system
sudo apt-get update && sudo apt-get upgrade -y

echo
echo install system utilities
sudo apt-get install docker docker-compose htop nano -y

echo
echo vorhandenene docker images : Command [docker images]
echo
read -r -p "Press key to continue..." key

echo
echo Docker run Options : -it [interactive] -d [detached] --rm --help -p [port-forwarding 8080:8090 \| host:container] 
echo pulling demo container: $container
docker pull $container
docker run -it -p 80:80 $container 