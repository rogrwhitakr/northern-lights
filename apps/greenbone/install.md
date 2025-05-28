# install

1. install docker
2. export a greenbone directory env variable for some reason
2. pull compose file and images

```sh
# export a greenbone directory env variable for some reason
export DOWNLOAD_DIR=$HOME/greenbone-community-container && mkdir -p $DOWNLOAD_DIR

# pull compose file and images
curl -f -O -L https://greenbone.github.io/docs/latest/_static/docker-compose.yml --output-dir "$DOWNLOAD_DIR"

docker compose -f $DOWNLOAD_DIR/docker-compose.yml pull

# start images
docker compose -f $DOWNLOAD_DIR/docker-compose.yml up -d

# set the admin password
docker compose -f $DOWNLOAD_DIR/docker-compose.yml exec -u gvmd gvmd gvmd --user=admin --new-password='<password>'

# now starts a long process that pulls cve definitions and imports them into a postgres database

# view logs
docker compose -f $DOWNLOAD_DIR/docker-compose.yml logs -f

# also via graylog possible if configured beforehand
```

## configuration for non-localhost web access

- add a global interface at 0.0.0.0
- allow firewall traffic for port 9392 and 80

```yaml
...
  gsa:
    image: registry.community.greenbone.net/community/gsa:stable
    restart: on-failure
    ports:
      - 0.0.0.0:9392:80
    volumes:
      - gvmd_socket_vol:/run/gvmd
    depends_on:
      - gvmd

...
```

## problem with the database import failing

```sh
# suggested solution - remove volumes (but not the postgres one) and start again

# list volumes
docker volume ls

# remove volumes with command
docker volume rm greenbone-community-edition_cert_data_vol
...

# in the end i also removed the postgres volume, that prompted recreation, that probably did it...
docker volume rm greenbone-community-edition_psql_data_vol
```

## updating cve definitions

```sh
# export a greenbone directory env variable for some reason and stop all containers
export DOWNLOAD_DIR=$HOME/greenbone-community-container && mkdir -p $DOWNLOAD_DIR
docker compose -f $DOWNLOAD_DIR/docker-compose.yml down

# Downloading the Feed Changes / Downloading the Greenbone Community Edition feed data containers
docker compose -f $DOWNLOAD_DIR/docker-compose.yml pull notus-data vulnerability-tests scap-data dfn-cert-data cert-bund-data report-formats data-objects

# start the feed containers
docker compose -f $DOWNLOAD_DIR/docker-compose.yml up -d notus-data vulnerability-tests scap-data dfn-cert-data cert-bund-data report-formats data-objects

# feeds are then synchronised, takes a long time (hours)
```