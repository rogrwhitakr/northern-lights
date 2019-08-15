#!/usr/bin/env bash

RED='\e[1;31m'  
YELLOW='\e[33m'
NOC='\033[0m'
BLUE='\e[34m'

say_hello() {
  echo -e "${RED}Hello! My current process PID using the variable \$BASHPID is${NOC}"
  echo "$BASHPID"
}

display_help(){
if ([[ "$1" = "-h" ]] || [[ "$1" = "--help" ]]); then
    local RED='\e[1;31m'  
    local YELLOW='\e[33m'
    local NOC='\033[0m'
    local BLUE='\e[34m'
    echo -e "${RED}USAGE:$0${NOC}"
    echo -e "\tcopies all folders from ~/html to \$webroot/html"
    echo -e "\tusing somesin somesin"
    exit 0
elif ([[ "$1" = "-p" ]] || [[ "$1" = "--pid" ]]); then
    say_hello
fi
}
display_help $1

echo -e "${RED}copying these directories...${NOC}"
find ~/html -mindepth 1 -maxdepth 1 -type d -print 

# here, multiple things apply:
# NO array  -> i can do for source in ${src}; do
#           -> element count does not work

src_no_array=$(find /home/admin/html -mindepth 1 -maxdepth 1 -type d)

# array     -> use ()
#           -> use a while or for loop
# for i in ${array[@]}
# do
#    echo $i
# done

# or in a while loop
# i=0;
# while [ $i -lt ${#array[@]} ]
# do
#     echo $i: ${array[$i]}
#     ((i++))
# done

src=( $(find /home/admin/html -mindepth 1 -maxdepth 1 -type d) )

echo -e "${RED}\$webroot is at /var/www/html. \$webroot contains directories:${NOC}"
find /var/www/html -mindepth 1 -maxdepth 1 -type d -print
target="/var/www/html"

# get that overview
echo "threre are ${#src[@]} ROOT folders for webroot"
echo "threre are ${#src_no_array[@]} ROOT folders for webroot"

# simpler variant
# the target is known, it is /var/www/html

echo -e "${YELLOW}using the coincidence, that no path name has a space${NOC}"

for source in ${src_no_array}; do
    echo "copying source "$source" to target "$target":"
    sudo cp --recursive ${source} ${target}
done

echo -e "${YELLOW}using array${NOC}"

iterations="${#src[@]}"
echo $iterations
read
for (( no=1; no<="${iterations}"; i++ ));do
    echo "$no"
    echo "copying source "${src[$no]}" to target "$target":"
#    sudo cp --recursive ${source} ${target}
done    

echo -e "${RED}all files within \$webroot not owned or group-owned by apache user that are being modified...${NOC}"
sudo find /var/www/html -type f \
    ! -uid $(id -u "apache") \
    ! -gid $(id -g "apache") \
    -print \
    -exec chown apache.apache {} \;

exit 0