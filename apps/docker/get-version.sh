#! /bin/sh

uri="https://github.com/PowerShell/PowerShell/releases/latest"

latest_release=$(curl -L -s -H 'Accept: application/json' ${uri})
echo "${latest_release}" 
latest_version=$(echo $latest_release | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')  
echo "${latest_version}"
curl -sL ${uri}/tag/${latest_version} > ./pwsh/core
exit 0