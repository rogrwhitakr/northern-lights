#! /bin/sh


<<<<<<< HEAD

grep -E '°[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' regex.template
=======
grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $ip_address

# test this !!!
ping -i 2 localhost | cut -d= -f4 | grep -E '0.[2-9]{3}'
>>>>>>> 100e83d6d2217a1969f8ddd4d38fdf44441728ed
