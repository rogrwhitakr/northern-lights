# bin/sh

RED='\033[0;31m'
NOC='\033[0m' 	# No Color

echo -e how to create a symlink'\n' ${RED}ln -s {/path/to/file-name} {link-name}

echo -e ${NOC}How to delete a symlink '\n' ${RED}rm {link-name}${NOC}