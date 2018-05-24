#! /usr/bin/env sh

log="/var/log/$(basename "$0")"

echo $log

if [[ ! -f "$log" ]]; then
    touch "$log"
fi

if [[ ! -r ! -w "$log" ]]; then
