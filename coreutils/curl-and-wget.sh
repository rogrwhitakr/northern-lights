# bin/sh

URL='https://curl.haxx.se/docs/manual.html'

# HOW-TO use curl
curl {http://sftp://smb://<protocol>...etc}

# make curl verbose
curl -v 'https://curl.haxx.se/docs/manual.html'

# DOWNLOAD TO A FILE
# Get a web page and store in a local file with a specific name:
curl -o thatpage.html ${URL}

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

