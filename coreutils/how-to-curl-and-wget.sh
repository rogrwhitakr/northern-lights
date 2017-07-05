# bin/sh

RED='\033[0;31m'
NOC='\033[0m' 	# No Color

function line() {
	echo -e '\n'
	echo [------------------------------------------]
	echo -e '\n'
}

###############################################################################################
# curl
###############################################################################################

echo -e HOW-TO use curl'\n' ${RED}curl {http://sftp://smb://...etc}${NOC}
echo -e go to'\n' ${RED}https://curl.haxx.se/docs/manual.html${NOC}'\n'for a detailed explanation and examples'\n'
xdg-open 'https://curl.haxx.se/docs/manual.html'
line

###############################################################################################
# wget
###############################################################################################

echo -e ${NOC}HOW-TO wget '\n' ${RED}TODO: wget {URL ???}${NOC}

###############################################################################################
# open webpages
###############################################################################################

line

echo -e HOW-TO open URLs '\n'xdg-open - open web pages with the system-standard web browser '\n' ${RED}xdg-open {URL}${NOC}

echo -e alternatively you can just 'echo' the URL like so and go to the webpage via Terminal:'\n'${RED}https://curl.haxx.se/docs/manual.html${NOC}'\n'will not work in a desktopless environment'\n'

###############################################################################################
# download a webpage and then display it in the terminal
###############################################################################################


curl http://www.cyberciti.biz/faq/bash-for-loop/
Use curl and store output into a variable as follows:

page="$(curl http://www.cyberciti.biz/)"
page="$(curl http://www.cyberciti.biz/faq/bash-for-loop/)"
To display content use echo or printf command as follows:

echo "$page"