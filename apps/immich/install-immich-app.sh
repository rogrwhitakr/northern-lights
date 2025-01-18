#! /usr/bin/env bash

curl -s -O -L https://raw.githubusercontent.com/rogrwhitakr/northern-lights/refs/heads/master/script/helpers/printer.bash

source ./printer.bash

print line
print "installing / updating immich app"
print line

cd /opt/immich-app

docker compose down

curl -O -L https://github.com/immich-app/immich/releases/latest/download/docker-compose.yml 

docker compose pull && docker compose up -d

print line
print "install complete"
print line
exit 0
