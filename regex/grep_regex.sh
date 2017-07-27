#! /bin/sh

ip_address=192.168.100.100
host=test

grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $ip_address

# test this !!!
ping -i 2 localhost | cut -d= -f4 | grep -E '[1-9]+.[0-9]{3}'

# works
grep -E '[1-9]+.[0-9]{3}' regex.template 

# grep from stout

grep -f -

# -f is file
#  - is stout 
#  does not seem to work / proposed on stack oveflow
  
ping google.de | grep -E '[0-9]+\.[0-9]{1,3}\s'