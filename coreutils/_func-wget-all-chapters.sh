#! /bin/sh

url="https://automatetheboringstuff.com/chapter"
site="/index.html"
dest="chapter"
ext=".html"

for i in $( seq 1 19 ); do

    getter=$url$i$site
    echo "$getter"
    setter=${dest}${i}${ext}
    echo "$setter"
    wget ${getter} -O ${setter}
done    