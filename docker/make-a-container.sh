# bin/sh

RED='\033[0;31m'
NOC='\033[0m' 	# No Color



container=net-tools

rm -f $container/Dockerfile
rmdir $container

clear

mkdir $container

touch $container/Dockerfile
tee $container/Dockerfile > /dev/null <<EOF
FROM fedora

RUN dnf update -y \
	&& dnf install nmap traceroute whois htop nano -y \
	&& dnf clean all

CMD /usr/bin/nmap -v -A gil.ot.local

EOF

echo -e "${RED}created container $container and Dockerfile${NOC}"
cat $container/Dockerfile

sleep 5

echo $0
echo $1

cd $container
echo -e "${RED}building container $container:${NOC} docker build -t $container ."
sudo docker build -t $container .

sleep 5

echo -e "${RED}created docker image $container:${NOC} docker images"
sudo docker images | grep $container

sleep 5

echo -e "${RED}running docker image $container:${NOC} docker run $container"
sudo docker run -it $container