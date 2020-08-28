#! /usr/bin/env bash

echo "start"

start="$(date +%s)"

hosts="$(nmap -v -sn -O 192.168.0.0/16)"

end="$(date +%s)"

runtime="$((end-start))"

# date --date="${runtime}" "+%h:%m:%s"

echo done
echo "$(date --universal --date @"${runtime}" "+%H:%M:%S")"
echo "${runtime}"

echo "${hosts}" > ./nmap-hosts