#! /bin/sh

ip_address=192.168.100.100
host=test

grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $ip_address

# test this !!!
ping -i 2 localhost | cut -d= -f4 | grep -E '0.[2-9]{3}'