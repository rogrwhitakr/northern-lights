# to make space on the box

## get local images

```sh
docker images
```

```sh
# Delete all containers
docker rm $(docker ps -a -q)
# Delete all images
docker rmi $(docker images -q)
```

## get ...

```sh
docker images -f "dangling=true"
docker images -f "dangling=false"
docker image prune -f
```