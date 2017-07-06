#! /bin/sh

ip_address=192.168.100.100
host=test

grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $ip_address
