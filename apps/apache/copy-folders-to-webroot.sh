#!/usr/bin/env sh

RED='\e[1;31m'  
YELLOW='\e[33m'
NOC='\033[0m'
BLUE='\e[34m'

say_hello() {
  echo -e "${RED}Hello! My current process PID using the variable \$BASHPID is${NOC}"
  echo "$BASHPID"
}
say_hello

display_help(){
if ([[ "$1" = "-h" ]] || [[ "$1" = "--help" ]]); then
    readonly local
    echo -e "${RED}USAGE:$0${NOC}"
    echo -e "\tcopies all folders from ~/html to \$webroot/html"
    exit 0
fi
}
display_help $1

echo -e "${RED}copying these directories...${NOC}"
find ~/html -mindepth 1 -maxdepth 1 -type d -print 
src=( $(find /home/admin/html -mindepth 1 -maxdepth 1 -type d) )

echo -e "${RED}\$webroot is at /var/www/html. \$webroot contains directories:${NOC}"
find /var/www/html -mindepth 1 -maxdepth 1 -type d -print
target="/var/www/html"

# get that overview
echo "threre are ${#src[@]} ROOT folders for webroot"

# simpler variant
# the target is known, it is /var/www/html
for source in ${src}; do
    echo "copying source "$source" to target "$target":"
#    sudo cp --recursive --force "${source}" "${target}"
done

echo -e "${RED}all files within \$webroot not owned or group-owned by apache user that are being modified...${NOC}"
sudo find /var/www/html -type f \
    ! -uid $(id -u "apache") \
    ! -gid $(id -g "apache") \
    -print \
    -exec chown apache.apache {} \;

exit 0
if [[ ! -z "$1" ]]; then
   systemctl status "$1"
fi