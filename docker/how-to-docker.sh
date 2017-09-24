# bin/sh

# install docker
 
# manage group to allow users non-sudo docker control
sudo groupadd docker

# add user to docker group

# get current locally available docker images
docker images

# get current docker processes
docker ps

# docker run options
docker run
	 -it [interactive]
	 -d [detached]
	 --rm 
	 --help
	 -p [port-forwarding 8080:8090 \| host:container] 

# default
docker run -d <container>

# docker stats
docker stats

# docker logs
docker logs