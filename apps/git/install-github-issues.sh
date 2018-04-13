#! /bin/sh

LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/stephencelis/ghi/releases/latest)  
LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')  

echo this script installs GitHub-Issues-on-the-commandline, Version $LATEST_VERSION.

read -rp $'Proceed ? (Y/n) : ' -ei $'Y' key;

if [[ $key != "Y" ]]; then
	echo "Script terminated by User."
	echo "Exiting..."
	exit 0
fi

curl -sL https://github.com/stephencelis/ghi/releases/tag/${LATEST_VERSION} > ghi

echo -e "\ncopying to /usr/local/bin/ghi"


chmod 755 ghi
sudo mv ghi /usr/local/bin 

echo "done!"
exit 0