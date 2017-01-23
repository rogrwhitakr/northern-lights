# /bin/sh

echo
echo AWK
echo
echo -F == --field-separators

getent aliases | awk -F: '{ print $1,"||", $5 }'
