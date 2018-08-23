#! /usr/bin/env bash

# from stackoverflow:
# check validity of a date, format yyyymmdd
date="20180212"
date="20180s12"

[[ $date =~ ^[0-9]{4}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$ ]] && echo "yes" || echo "no"
#           |^^^^^^^^ ^^^^^^ ^^^^^^  ^^^^^^ ^^^^^^^^^^ ^^^^^^ |
#           |   |     ^^^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^^^^^ |
#           |   |          |                   |              |
#           |   |           \                  |              |
#           | --year--   --month--           --day--          |
#           |          either 01...09      either 01..09     end of line
# start of line            or 10,11,12         or 10..29
#                                              or 30, 31

# ATM there are some downloaded youtube videos in ~/Videos
# named like so:
#   'Ansible - an absolute basic overview-MfoAb50Br94.mp4'
# todo:
#   replace spaces with dashes
#   remove trailing whatevers 

cd ~/Videos
file='Ansible - an absolute basic overview-MfoAb50Br94.mp4'

# You can parameterize the substrings.
X=' '

echo "${file##$X}"
echo "${file#$X}"